package com.samuel.tcc.authapi.dto.user;
import java.util.List;

public record FriendResponseDTO(List<Friend> friends, List<FriendRequestDTO> requests) { }
