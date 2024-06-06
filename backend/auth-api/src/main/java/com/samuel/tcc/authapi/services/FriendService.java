package com.samuel.tcc.authapi.services;

import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.FriendRequestMapper;
import com.samuel.tcc.authapi.repositories.FriendRequestRepository;
import com.samuel.tcc.authapi.services.exceptions.FriendRequestNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FriendService {
    private final FriendRequestRepository _friendRequestRepository;
    private final FriendRequestMapper _mapper;

    public void sendFriendRequest(User requester,User friend) {
        FriendRequest friendRequest = new FriendRequest();
        friendRequest.setActive(true);
        friendRequest.setRequester(requester);
        friendRequest.setFriend(friend);

        _friendRequestRepository.save(friendRequest);
        friend.getFriendRequests().add(friendRequest);
    }

    @Transactional
    public void inactivateFriendRequest(String requesterEmail, String userEmail) {
        var friendRequest = _friendRequestRepository
                .findFriendRequestByUserAndRequesterEmail(requesterEmail, userEmail).orElseThrow(FriendRequestNotFoundException::new);

        friendRequest.setActive(false);
        _friendRequestRepository.save(friendRequest);
    }

    public List<FriendRequestDTO> getFriendRequestsByEmail(String name) {
        var friendRequests =  _friendRequestRepository.findFriendRequestByEmail(name);

        return _mapper.entityToDTO(friendRequests);
    }

}
