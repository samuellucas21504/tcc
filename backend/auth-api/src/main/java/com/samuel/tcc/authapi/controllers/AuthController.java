package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.domain.user.User;
import com.samuel.tcc.authapi.dto.LoginRequestDTO;
import com.samuel.tcc.authapi.dto.LoginResponseDTO;
import com.samuel.tcc.authapi.dto.RegisterRequestDTO;
import com.samuel.tcc.authapi.dto.ValidationDTO;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

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

        if(passwordEncoder.matches(body.password(), user.getPassword())) {
            String token = tokenService.generateToken(user);
            return ResponseEntity.ok(new LoginResponseDTO(user.getName(), user.getEmail(), token));
        }

        return ResponseEntity.badRequest().build();
    }

    @PostMapping("/register")
    public ResponseEntity<LoginResponseDTO> register(@RequestBody RegisterRequestDTO body) {
        Optional<User> user = repository.findByEmail(body.email());

        if(user.isEmpty()) {
            User newUser = new User();
            newUser.setPassword(passwordEncoder.encode(body.password()));
            newUser.setEmail(body.email());
            newUser.setName(body.name());
            repository.save(newUser);

            String token = tokenService.generateToken(newUser);
            return ResponseEntity.ok(new LoginResponseDTO(newUser.getName(), newUser.getEmail(), token));
        }

        return ResponseEntity.badRequest().build();
    }

    @GetMapping("/validate")
    public ResponseEntity<Void> validateToken(@RequestBody ValidationDTO body) {
        var tokenSubject = tokenService.validateToken(body.token());

        if(tokenSubject == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }
}
