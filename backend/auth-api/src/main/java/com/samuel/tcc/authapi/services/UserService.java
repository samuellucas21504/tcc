package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.auth.RegisterRequestDTO;
import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.FriendRequestMapper;
import com.samuel.tcc.authapi.repositories.FriendRequestRepository;
import com.samuel.tcc.authapi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository _repository;
    private final FriendRequestRepository _friendRequestRepository;
    private final PasswordEncoder _passwordEncoder;
    private final FriendRequestMapper _friendRequestMapper;

    public User register(RegisterRequestDTO dto) {
        User user = new User();
        user.setPassword(_passwordEncoder.encode(dto.password()));
        user.setEmail(dto.email());
        user.setName(dto.name());

        _repository.save(user);

        return user;
    }

    public Optional<User> getUserByEmail(String email) {
        return _repository.findByEmail(email);
    }

    public boolean emailExists(String email) {
        var user = getUserByEmail(email);
        return user.isPresent();
    }

    public void sendFriendRequest(String requesterEmail,String friendEmail) {
        User requester = getUserByEmail(requesterEmail).orElseThrow(() -> new RuntimeException("a"));
        User friend = getUserByEmail(friendEmail).orElseThrow(() -> new RuntimeException("a"));

        FriendRequest friendRequest = new FriendRequest();
        friendRequest.setActive(true);
        friendRequest.setRequester(requester);
        friendRequest.setFriend(friend);

        _friendRequestRepository.save(friendRequest);

        friend.getFriendRequests().add(friendRequest);

        _repository.save(friend);
    }

    public List<User> getFriendsByEmail(String name) {
        return _repository.findFriendsByEmail(name);
    }

    public List<FriendRequestDTO> getFriendRequestsByEmail(String name) {
        var friendRequests =  _friendRequestRepository.findFriendRequestByEmail(name);

        return _friendRequestMapper.entityToDTO(friendRequests);
    }
}
