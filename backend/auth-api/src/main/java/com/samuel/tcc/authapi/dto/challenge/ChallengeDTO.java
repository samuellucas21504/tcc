package com.samuel.tcc.authapi.dto.challenge;

import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;

import java.util.List;

public record ChallengeDTO(String name, UserDTO creator, List<UserDTO> participants) {}
