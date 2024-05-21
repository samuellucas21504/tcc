package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.domain.user.User;
import com.samuel.tcc.authapi.dto.LoginRequestDTO;
import com.samuel.tcc.authapi.dto.LoginResponseDTO;
import com.samuel.tcc.authapi.dto.RegisterRequestDTO;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody LoginRequestDTO body) {
        User user = repository.findByEmail(body.email())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if(passwordEncoder.matches(user.getPassword(), body.password())) {
            String token = tokenService.generateToken(user);
            return ResponseEntity.ok(new LoginResponseDTO(user.getName(), token));
        }

        return ResponseEntity.badRequest().build();
    }

    @PostMapping("/register")
    public ResponseEntity register(@RequestBody RegisterRequestDTO body) {
        Optional<User> user = repository.findByEmail(body.email());

        if(user.isEmpty()) {
            User newUser = new User();
            newUser.setPassword(passwordEncoder.encode(body.password()));
            newUser.setEmail(body.email());
            newUser.setName(body.name());
            repository.save(newUser);

            String token = tokenService.generateToken(newUser);
            return ResponseEntity.ok(new LoginResponseDTO(newUser.getName(), token));
        }

        return ResponseEntity.badRequest().build();
    }
}
