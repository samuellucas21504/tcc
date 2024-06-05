package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.user.UserDTO;
import com.samuel.tcc.authapi.entities.user.User;
import com.samuel.tcc.authapi.dto.auth.LoginRequestDTO;
import com.samuel.tcc.authapi.dto.auth.RegisterRequestDTO;
import com.samuel.tcc.authapi.infra.mappers.UserMapper;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    private final UserService _userService;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;
    private final UserMapper _userMapper;

    @PostMapping("/login")
    public ResponseEntity<UserDTO> login(@RequestBody LoginRequestDTO body) {
        User user = _userService.getUserByEmail(body.email())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if(passwordEncoder.matches(body.password(), user.getPassword())) {
            var headers = generateTokenHeader(user);
            var dto = _userMapper.entityToDTO(user);

            return ResponseEntity.ok().headers(headers).body(dto);
    }

        return ResponseEntity.badRequest().build();
}

    @PostMapping("/register")
    public ResponseEntity<UserDTO> register(@RequestBody RegisterRequestDTO body) {
        boolean emailExists = _userService.emailExists(body.email());
        if(emailExists) return ResponseEntity.badRequest().build();

        User user = _userService.register(body);
        var dto = _userMapper.entityToDTO(user);

        var headers = generateTokenHeader(user);

        return ResponseEntity.ok().headers(headers).body(dto);
    }

    private HttpHeaders generateTokenHeader(User user) {
        String token = tokenService.generateToken(user);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("TOKEN", token);
        return responseHeaders;
    }
}
