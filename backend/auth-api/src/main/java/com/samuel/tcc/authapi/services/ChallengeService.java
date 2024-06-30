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
import com.samuel.tcc.authapi.services.exceptions.ChallengeNotFoundException;
import com.samuel.tcc.authapi.services.exceptions.IncorrectFormatException;
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import com.samuel.tcc.authapi.utils.EpochConverter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
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

        ChallengeRecord record = new ChallengeRecord();
        record.setChallenge(challenge);
        record.setStreak(0);
        record.setUser(user);

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

        var challenge = _repository.findById(dto.challengeId()).orElseThrow(ChallengeNotFoundException::new);

        ChallengeRequest challengeRequest = new ChallengeRequest();
        challengeRequest.setChallenger(challenger);
        challengeRequest.setChallenged(challenged);
        challengeRequest.setChallenge(challenge);
        challengeRequest.setActive(true);

        _requestRepository.save(challengeRequest);
    }
}
