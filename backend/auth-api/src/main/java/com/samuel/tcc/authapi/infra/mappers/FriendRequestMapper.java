package com.samuel.tcc.authapi.infra.mappers;

import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface FriendRequestMapper {
    FriendRequestDTO entityToDTO(FriendRequest friendRequest);

    List<FriendRequestDTO> entityToDTO(List<FriendRequest> friendRequests);
}
