package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.UUID;

public record ChallengeRequestBodyDTO(
        @JsonProperty("id")
        UUID challengeId,
        String email
) { }
