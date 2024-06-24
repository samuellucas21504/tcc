package com.samuel.tcc.authapi.dto.challenge;

import java.util.UUID;

public record ChallengeRequestBodyDTO(
        UUID challengeId,
        String email
) { }
