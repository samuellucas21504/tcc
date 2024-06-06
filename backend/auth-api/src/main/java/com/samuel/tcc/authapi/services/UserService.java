package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.auth.RegisterRequestDTO;
import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.FriendRequestMapper;
import com.samuel.tcc.authapi.infra.mappers.UserMapper;
import com.samuel.tcc.authapi.repositories.FriendRequestRepository;
import com.samuel.tcc.authapi.repositories.UserRepository;
import com.samuel.tcc.authapi.services.exceptions.FriendRequestNotFoundException;
import com.samuel.tcc.authapi.services.exceptions.UserBefriendingItSelfException;
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository _repository;
    private final FriendRequestRepository _friendRequestRepository;
    private final PasswordEncoder _passwordEncoder;
    private final FriendRequestMapper _friendRequestMapper;
    private final UserMapper _mapper;

    public UserDTO register(RegisterRequestDTO dto) {
        User user = new User();
        user.setPassword(_passwordEncoder.encode(dto.password()));
        user.setEmail(dto.email());
        user.setName(dto.name());

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

        FriendRequest friendRequest = new FriendRequest();
        friendRequest.setActive(true);
        friendRequest.setRequester(requester);
        friendRequest.setFriend(friend);

        _friendRequestRepository.save(friendRequest);

        friend.getFriendRequests().add(friendRequest);

        _repository.save(friend);
    }

    @Transactional
    public void acceptFriendRequest(String requesterEmail, String userEmail) {
        if (requesterEmail.equals(userEmail)) {
            throw new UserBefriendingItSelfException();
        }

        var friendRequest = _friendRequestRepository
                .findFriendRequestByUserAndRequesterEmail(requesterEmail, userEmail).orElseThrow(FriendRequestNotFoundException::new);

        friendRequest.setActive(false);
        _friendRequestRepository.save(friendRequest);

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

    public List<FriendRequestDTO> getFriendRequestsByEmail(String name) {
        var friendRequests =  _friendRequestRepository.findFriendRequestByEmail(name);

        return _friendRequestMapper.entityToDTO(friendRequests);
    }
}
