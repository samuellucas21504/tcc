package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.infra.mappers.UserMapper;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
public class UserController {
    private final TokenService _tokenService;
    private final UserService _userService;
    private final UserMapper _mapper;

    @PostMapping("/sendFriendRequest/{friendEmail}")
    public ResponseEntity sendFriendRequest(@RequestHeader("Authorization") String bearerToken, @PathVariable("friendEmail") String friendEmail) {
        String requesterEmail =_tokenService.validateBearerToken(bearerToken);
        _userService.sendFriendRequest(requesterEmail, friendEmail);

        return ResponseEntity.ok().build();
    }

    @GetMapping(value="/{name}")
    public ResponseEntity teste(@PathVariable(value="email") String email) {
        var user = _userService.getUserByEmail(email);
        return ResponseEntity.ok(_mapper.entityToDTO(user.get()));
    }

    @GetMapping(value="/friends")
    public ResponseEntity getFriends(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_userService.getFriendsByEmail(requesterEmail));
    }

    @GetMapping(value="/friendRequests")
    public ResponseEntity getFriendRequests(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_userService.getFriendRequestsByEmail(requesterEmail));
    }
}
