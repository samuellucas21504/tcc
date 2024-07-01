package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.challenge.ChallengeDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeRegisterDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeRequestBodyDTO;
import com.samuel.tcc.authapi.dto.challenge.ChallengeResponseDTO;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.ChallengeService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/challenges")
@AllArgsConstructor
public class ChallengeController {
    private final TokenService _tokenService;
    private final ChallengeService _challengeService;

    @GetMapping
    public ResponseEntity<ChallengeResponseDTO> getChallenges(@RequestHeader("Authorization") String bearerToken) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_challengeService.getUserChallenges(requesterEmail));
    }

    @PostMapping
    public ResponseEntity<ChallengeDTO> createChallenge(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody ChallengeRegisterDTO dto
    ) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_challengeService.register(dto, requesterEmail));
    }

    @PostMapping("/{id}/records")
    public ResponseEntity recordChallenge(
            @RequestHeader("Authorization") String bearerToken, @PathVariable UUID id) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        _challengeService.recordChallenge(userEmail, id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/request")
    public ResponseEntity sendChallengeRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody ChallengeRequestBodyDTO request) {
        String requesterEmail = _tokenService.validateBearerToken(bearerToken);
        _challengeService.sendChallengeRequest(requesterEmail, request);

        return ResponseEntity.ok().build();
    }


    @PostMapping(value = "/request/accept")
    public ResponseEntity acceptChallengeRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody ChallengeRequestBodyDTO challengeRequest
    ) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);
        _challengeService.acceptChallengeRequest(challengeRequest.email(), userEmail, challengeRequest.challengeId());

        return ResponseEntity.ok().build();
    }

    @PostMapping(value = "/request/refuse")
    public ResponseEntity refuseChallengeRequest(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody ChallengeRequestBodyDTO challengeRequest
    ) {
        String userEmail = _tokenService.validateBearerToken(bearerToken);
        _challengeService.inactivateChallengeRequest(challengeRequest.email(), userEmail, challengeRequest.challengeId());

        return ResponseEntity.ok().build();
    }
}
