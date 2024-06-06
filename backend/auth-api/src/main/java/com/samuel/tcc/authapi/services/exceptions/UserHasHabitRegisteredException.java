package com.samuel.tcc.authapi.services.exceptions;

public class UserHasHabitRegisteredException extends RuntimeException {
    public UserHasHabitRegisteredException() {
        super("O usuário já tem um hábito registrado.");
    }
    public int getErrorCode() {
        return 5;
    }
}
