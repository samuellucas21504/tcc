package com.samuel.tcc.authapi.dto.user;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;

public record Friend(String name,
                     String email,
                     @JsonProperty("avatar_url")
                        @Nullable
                        String avatarUrl
) { }
