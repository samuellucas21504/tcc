package com.samuel.tcc.authapi.infra.mappers;

import com.samuel.tcc.authapi.dto.challenge.ChallengeDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeRequestDTO;
import com.samuel.tcc.authapi.dto.habit.HabitDTO;
import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.entities.challenge.Challenge;
import com.samuel.tcc.authapi.entities.challenge.ChallengeRequest;
import com.samuel.tcc.authapi.entities.habit.Habit;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface ChallengeMapper {
    ChallengeDTO entityToDTO(Challenge entity);
    List<ChallengeDTO> entityToDTO(List<Challenge> entity);

    @Mapping(source = "challenger", target = "requester")
    ChallengeRequestDTO entityToDTO(ChallengeRequest challengeRequest);

    List<ChallengeRequestDTO> requestsToDTO(List<ChallengeRequest> challengeRequests);
}
