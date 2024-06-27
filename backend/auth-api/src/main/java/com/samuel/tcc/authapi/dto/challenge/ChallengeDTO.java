package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;

import java.util.Date;
import java.util.List;

public record ChallengeDTO(
        String name,
        UserDTO creator,
        List<UserDTO> participants,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
        @JsonProperty("finishes_at")
        Date finishesAt
) {}
