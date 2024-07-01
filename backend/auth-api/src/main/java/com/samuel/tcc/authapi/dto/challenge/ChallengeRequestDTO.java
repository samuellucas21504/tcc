package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.samuel.tcc.authapi.dto.user.UserDTO;

import java.util.Date;

public record ChallengeRequestDTO(
        UserDTO requester,
        ChallengeDTO challenge,
        Date date
) {
}
