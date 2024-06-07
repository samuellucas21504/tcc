package com.samuel.tcc.authapi.controllers;

import com.samuel.tcc.authapi.dto.habit.HabitDTO;
import com.samuel.tcc.authapi.dto.habit.HabitRecordDTO;
import com.samuel.tcc.authapi.dto.habit.HabitRecordRequestDTO;
import com.samuel.tcc.authapi.entities.habit.Habit;
import com.samuel.tcc.authapi.infra.gateways.MotivationMessagesClient;
import com.samuel.tcc.authapi.infra.security.TokenService;
import com.samuel.tcc.authapi.services.HabitService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.swing.text.html.parser.Entity;
import java.util.List;

@RestController
@RequestMapping("/habits")
@AllArgsConstructor
public class HabitController {
    private final TokenService _tokenService;
    private final HabitService _habitService;

    @GetMapping
    public ResponseEntity<HabitDTO> get(@RequestHeader("Authorization") String bearerToken) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_habitService.getHabit(userEmail));
    }

    @PostMapping
    public ResponseEntity<HabitDTO> registerHabit(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody HabitDTO dto
    ) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_habitService.registerHabit(userEmail, dto.reason()));
    }

    @GetMapping("/record")
    public ResponseEntity<List<HabitRecordDTO>> getRecordsByMonth(
            @RequestHeader("Authorization") String bearerToken,
            @RequestBody HabitRecordRequestDTO dto
    ) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_habitService.getHabitRecords(userEmail, dto.month(), dto.year()));
    }

    @PostMapping("/record")
    public ResponseEntity recordHabit(
            @RequestHeader("Authorization") String bearerToken) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        _habitService.recordHabit(userEmail);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/new")
    public ResponseEntity<HabitDTO> generateNewMotivation(
            @RequestHeader("Authorization") String bearerToken
    ) {
        var userEmail = _tokenService.validateBearerToken(bearerToken);
        return ResponseEntity.ok(_habitService.generateNewMotivation(userEmail));
    }
}
