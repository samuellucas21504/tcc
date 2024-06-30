package com.samuel.tcc.authapi.dto.challenge;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.samuel.tcc.authapi.dto.user.UserDTO;

import java.util.Date;

public record ChallengeRecordDTO(
        long streak,
        @JsonProperty("last_updated")
        Date lastUpdated,
        UserDTO user){ }
