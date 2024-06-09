package com.samuel.tcc.authapi.infra.mappers;

import com.samuel.tcc.authapi.dto.user.Friend;
import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(source = "registeredAt", target = "createdAt")
    User dtoToEntity(UserDTO dto);
    @Mapping(source = "registeredAt", target = "createdAt")
    List<User> dtoToEntity(List<UserDTO> dtos);
    @Mapping(source = "createdAt", target = "registeredAt")
    UserDTO entityToDTO(User user);
    @Mapping(source = "createdAt", target = "registeredAt")

    List<UserDTO> entityToDTO(List<User> users);

    Friend entityToFriend(User entity);
    List<Friend> entityToFriend(List<User> entities);

}
