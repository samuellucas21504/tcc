package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.auth.RegisterRequestDTO;
import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.UserMapper;
import com.samuel.tcc.authapi.repositories.UserRepository;
import com.samuel.tcc.authapi.services.exceptions.UserBefriendingItSelfException;
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository _repository;
    private final PasswordEncoder _passwordEncoder;
    private final FriendService _friendService;
    private final UserMapper _mapper;

    public UserDTO register(RegisterRequestDTO dto) {
        User user = new User();
        user.setPassword(_passwordEncoder.encode(dto.password()));
        user.setEmail(dto.email());
        user.setName(dto.name());
        user.setHabitRegistered(false);

        _repository.save(user);

        return _mapper.entityToDTO(user);
    }

    public Optional<User> getUserByEmail(String email) {
        return _repository.findByEmail(email);
    }

    public UserDTO getUserDTOByEmail(String email) {
        var user = getUserByEmail(email).orElseThrow(UserNotFoundException::new);
        return _mapper.entityToDTO(user);
    }
    public boolean emailExists(String email) {
        return _repository.findByEmail(email).isPresent();
    }

    public void sendFriendRequest(String requesterEmail,String friendEmail) {
        User requester = getUserByEmail(requesterEmail).orElseThrow(UserNotFoundException::new);
        User friend = getUserByEmail(friendEmail).orElseThrow(UserNotFoundException::new);

        _friendService.sendFriendRequest(requester, friend);
        _repository.save(friend);
    }

    public void acceptFriendRequest(String requesterEmail, String userEmail) {
        if (requesterEmail.equals(userEmail)) {
            throw new UserBefriendingItSelfException();
        }

        _friendService.inactivateFriendRequest(requesterEmail, userEmail);

        User requester = getUserByEmail(requesterEmail).orElseThrow(UserNotFoundException::new);
        User friend = getUserByEmail(userEmail).orElseThrow(UserNotFoundException::new);

        friend.getFriends().add(requester);
        requester.getFriends().add(friend);

        _repository.save(friend);
        _repository.save(requester);
    }

    public List<UserDTO> getFriendsByEmail(String email) {
        var user = _repository.findByEmail(email).orElseThrow(UserNotFoundException::new);

        return _mapper.entityToDTO(user.getFriends());
    }
}
