package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.challenge.ChallengeDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeRegisterDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeRequestBodyDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeResponseDTO;
import com.samuel.tcc.authapi.entities.challenge.Challenge;
import com.samuel.tcc.authapi.entities.challenge.ChallengeRecord;
import com.samuel.tcc.authapi.entities.challenge.ChallengeRequest;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.ChallengeMapper;
import com.samuel.tcc.authapi.repositories.challenge.ChallengeRecordRepository;
import com.samuel.tcc.authapi.repositories.challenge.ChallengeRepository;
import com.samuel.tcc.authapi.repositories.challenge.ChallengeRequestRepository;
import com.samuel.tcc.authapi.services.exceptions.*;
import com.samuel.tcc.authapi.utils.EpochConverter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ChallengeService {
    private final ChallengeRepository _repository;
    private final ChallengeRecordRepository _recordRepository;
    private final ChallengeRequestRepository _requestRepository;
    private final UserService _userService;
    private final ChallengeMapper _mapper;

    private ChallengeRecord createChallengeRecord(Challenge challenge, User user) {
        ChallengeRecord record = new ChallengeRecord();
        record.setChallenge(challenge);
        record.setStreak(0);
        record.setUser(user);
        return record;
    }

    public ChallengeResponseDTO getUserChallenges(String userEmail) {
        var challenges = _repository.findUserChallenges(userEmail);
        var requests = _requestRepository.findRequestByEmail(userEmail);

        return new ChallengeResponseDTO(_mapper.entityToDTO(challenges), _mapper.requestsToDTO(requests));
    }

    @Transactional
    public ChallengeDTO register(ChallengeRegisterDTO dto, String userEmail) {
        var user = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

        if(dto.name().isEmpty()) throw new IncorrectFormatException();

        Date finishesAt = EpochConverter.convert(dto.finishesAt());

        Challenge challenge = new Challenge();
        var record = createChallengeRecord(challenge, user);

        challenge.setCreator(user);
        challenge.setFinishesAt(finishesAt);
        challenge.setName(dto.name());
        challenge.getParticipants().add(user);
        challenge.getRecords().add(record);

        _repository.save(challenge);
        _recordRepository.save(record);

        return _mapper.entityToDTO(challenge);
    }

    @Transactional
    public void recordChallenge(String userEmail, UUID uuid) {
        Challenge challenge = _repository.findById(uuid).orElseThrow(ChallengeNotFoundException::new);
        var optRecord = _recordRepository.findByUserEmailAndRecordDate(userEmail, uuid);
        ChallengeRecord record;
        if(optRecord.isPresent()) {
            record = optRecord.get();

            var lastUpdated = optRecord.get().getLastUpdated();
            if(lastUpdated != null) {
                LocalDate lastUpdatedDate = lastUpdated.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                LocalDate today = LocalDate.now();
                long daysBetween = ChronoUnit.DAYS.between(lastUpdatedDate, today);
                if(daysBetween < 1) return;
            }
        }
        else {
            User user = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

            record = new ChallengeRecord();
            record.setChallenge(challenge);
            record.setUser(user);
        }

        record.setStreak(record.getStreak() + 1);
        record.setLastUpdated(new Date());

        _recordRepository.save(record);
    }

    @Transactional
    public void sendChallengeRequest(String requesterEmail, ChallengeRequestBodyDTO dto) {
        var challenger = _userService.getUserByEmail(requesterEmail).orElseThrow(UserNotFoundException::new);
        var challenged = _userService.getUserByEmail(dto.email()).orElseThrow(UserNotFoundException::new);

        if(Objects.equals(challenger.getEmail(), challenged.getEmail())) throw new EmailsAreEqualException();

        var challenge = _repository.findById(dto.challengeId()).orElseThrow(ChallengeNotFoundException::new);
        if(challenge.getParticipants().contains(challenged)) return;

        ChallengeRequest challengeRequest = new ChallengeRequest();
        challengeRequest.setChallenger(challenger);
        challengeRequest.setChallenged(challenged);
        challengeRequest.setChallenge(challenge);
        challengeRequest.setActive(true);

        _requestRepository.save(challengeRequest);
    }

    @Transactional
    public void acceptChallengeRequest(String requesterEmail, String userEmail, UUID challengeId) {
        if (requesterEmail.equals(userEmail)) {
            throw new EmailsAreEqualException();
        }

        inactivateChallengeRequest(requesterEmail, userEmail, challengeId);

        User challenger = _userService.getUserByEmail(requesterEmail).orElseThrow(UserNotFoundException::new);
        User challenged = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

        Challenge challenge = _repository.findById(challengeId).orElseThrow(ChallengeNotFoundException::new);
        if (!challenge.getParticipants().contains(challenger)) throw new UserNotInChallengeException();

        if (!challenge.getParticipants().contains(challenged)) {
            var record = createChallengeRecord(challenge, challenged);

            challenge.getParticipants().add(challenged);
            challenge.getRecords().add(record);

            _repository.save(challenge);
        }
    }


    @Transactional
    public void inactivateChallengeRequest(String requesterEmail, String userEmail, UUID id) {
        var request = _requestRepository
                .findFriendRequestByUserAndRequesterEmail(requesterEmail, userEmail, id).orElseThrow(RequestNotFoundException::new);

        request.setActive(false);
        _requestRepository.save(request);
    }
}
