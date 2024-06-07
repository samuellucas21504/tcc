package com.samuel.tcc.authapi.dto.user;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;

import java.util.Date;

public record UserDTO (
        String name,
        String email,
        @JsonProperty("habit_registered")
        boolean habitRegistered,
        @JsonProperty("registered_at")
        @Nullable
        Date registeredAt
) {}