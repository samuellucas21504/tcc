package com.samuel.tcc.authapi.infra.mappers;

import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User dtoToEntity(UserDTO dto);
    List<User> dtoToEntity(List<UserDTO> dtos);
    UserDTO entityToDTO(User user);
    List<UserDTO> entityToDTO(List<User> users);

}
