package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.user.UserDTO;
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

    @GetMapping
    public ResponseEntity<UserDTO> getUser(@RequestHeader("Authorization") String bearerToken) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);

        return ResponseEntity.ok(_userService.getUserDTOByEmail(userEmail));
    }
}
