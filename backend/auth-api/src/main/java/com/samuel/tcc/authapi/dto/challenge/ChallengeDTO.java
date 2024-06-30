package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.samuel.tcc.authapi.dto.user.UserDTO;

import java.util.Date;
import java.util.List;
import java.util.UUID;

public record ChallengeDTO(
        UUID id,
        String name,
        UserDTO creator,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
        @JsonProperty("finishes_at")
        Date finishesAt,
        List<UserDTO> participants,
        List<ChallengeRecordDTO> records
) {}
