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
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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

        Challenge challenge = new Challenge();
        challenge.setCreator(user);
        challenge.getParticipants().add(user);
        challenge.setFinishesAt(dto.finishesAt());
        challenge.setName(dto.name());

        _repository.save(challenge);

        return _mapper.entityToDTO(challenge);
    }

    @Transactional
    public void recordChallenge(String userEmail, UUID uuid) {
        Date today = new Date();

        Challenge challenge = _repository.findById(uuid).orElseThrow(ChallengeNotFoundException::new);
        var optRecord = _recordRepository.findByUserEmailAndRecordDate(userEmail, today);
        if(optRecord.isPresent()) return;

        User user = _userService.getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

        ChallengeRecord challengeRecord = new ChallengeRecord();
        challengeRecord.setChallenge(challenge);
        challengeRecord.setUser(user);
        challengeRecord.setRecordDate(today);

        _recordRepository.save(challengeRecord);
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
