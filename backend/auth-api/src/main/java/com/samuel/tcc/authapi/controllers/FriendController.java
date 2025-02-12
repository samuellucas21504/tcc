package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.user.*;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.FriendService;
import com.samuel.tcc.authapi.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/friends")
@AllArgsConstructor
public class FriendController {
    private final TokenService _tokenService;
    private final UserService _userService;
    private final FriendService _friendService;

    @GetMapping
    public ResponseEntity<FriendResponseDTO> getFriends(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_userService.getFriendsAndRequestsByEmail(requesterEmail));
    }

    @PostMapping("/request")
    public ResponseEntity sendFriendRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody FriendRequestBodyDTO friendEmail) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        _userService.sendFriendRequest(requesterEmail, friendEmail.email());

        return ResponseEntity.ok().build();
    }


    @PostMapping(value = "/request/accept")
    public ResponseEntity acceptFriendRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody FriendRequestBodyDTO requesterEmail
    ) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);
        _userService.acceptFriendRequest(requesterEmail.email(), userEmail);

        return ResponseEntity.ok().build();
    }

    @PostMapping(value = "/request/refuse")
    public ResponseEntity refuseFriendRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody FriendRequestBodyDTO requesterEmail
    ) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);
        _friendService.inactivateFriendRequest(requesterEmail.email(), userEmail);

        return ResponseEntity.ok().build();
    }
}