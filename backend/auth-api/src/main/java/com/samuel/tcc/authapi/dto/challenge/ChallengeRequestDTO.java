package com.samuel.tcc.authapi.dto.challenge;

import com.samuel.tcc.authapi.dto.user.UserDTO;

import java.util.Date;

public record ChallengeRequestDTO(
        UserDTO requester,
        ChallengeDTO challengeDTO,
        Date date
) {
}
