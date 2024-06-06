package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.user.FriendRequestBodyDTO;
import com.samuel.tcc.authapi.dto.user.FriendRequestDTO;
import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.infra.mappers.UserMapper;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
public class UserController {
    private final TokenService _tokenService;
    private final UserService _userService;

    @GetMapping
    public ResponseEntity<UserDTO> getUser(@RequestHeader("Authorization") String bearerToken) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);

        return ResponseEntity.ok(_userService.getUserDTOByEmail(userEmail));
    }

    @GetMapping(value="/friendRequests")
    public ResponseEntity<List<FriendRequestDTO>> getFriendRequests(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_userService.getFriendRequestsByEmail(requesterEmail));
    }

    @PostMapping("/friendRequest")
    public ResponseEntity sendFriendRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody FriendRequestBodyDTO friendEmail) {
        String requesterEmail =_tokenService.validateBearerToken(bearerToken);
        _userService.sendFriendRequest(requesterEmail, friendEmail.email());

        return ResponseEntity.ok().build();
    }

    @PostMapping(value="/friendRequest/accept")
    public ResponseEntity acceptFriendRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody FriendRequestBodyDTO requesterEmail
    ) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);
        _userService.acceptFriendRequest(requesterEmail.email(), userEmail);

        return ResponseEntity.ok().build();
    }

    @GetMapping(value="/friends")
    public ResponseEntity<List<UserDTO>> getFriends(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_userService.getFriendsByEmail(requesterEmail));
    }
}
