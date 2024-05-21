package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.infra.security.TokenService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
public class UserController {
    private final TokenService tokenService;

    @GetMapping(value="/{token}")
    public ResponseEntity<String> isTokenValid(@PathVariable(value="token") String token) {
        var a = tokenService.validateToken(token);

        return ResponseEntity.ok(a);
    }
}
