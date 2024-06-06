package com.samuel.tcc.authapi.services.exceptions;

public class HabitNotFoundException extends RuntimeException{
    public HabitNotFoundException() {
        super("O hábito não foi encontrado.");
    }

    public int getErrorCode() {
        return 6;
    }
}
