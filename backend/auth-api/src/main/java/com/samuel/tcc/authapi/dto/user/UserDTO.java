package com.samuel.tcc.authapi.dto.user;

import com.fasterxml.jackson.annotation.JsonProperty;

public record UserDTO (
        String name,
        String email,
        @JsonProperty("habit_registered")
        boolean habitRegistered
) {}