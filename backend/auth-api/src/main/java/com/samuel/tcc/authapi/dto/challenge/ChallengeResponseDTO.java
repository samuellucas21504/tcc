package com.samuel.tcc.authapi.dto.challenge;

import java.util.List;
public record ChallengeResponseDTO(
        List<ChallengeDTO> challenges,
        List<ChallengeRequestDTO> requests
) {}
