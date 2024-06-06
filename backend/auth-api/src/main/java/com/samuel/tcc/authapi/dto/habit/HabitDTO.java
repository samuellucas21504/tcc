package com.samuel.tcc.authapi.dto.habit;

import jakarta.annotation.Nullable;

import java.util.Optional;

public record HabitDTO(String reason, @Nullable String motivation) {
}
