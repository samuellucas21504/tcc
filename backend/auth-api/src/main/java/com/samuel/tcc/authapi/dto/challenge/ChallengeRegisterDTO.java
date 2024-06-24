package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;
import lombok.Builder;

import java.util.Date;

public record ChallengeRegisterDTO(
        String name,
        @JsonProperty("finishes_at")
        Date finishesAt
) {}
