package com.samuel.tcc.authapi.services.exceptions;

public class UserNotFoundException extends RuntimeException{
    public UserNotFoundException() {
        super("O usuário não foi encontrado.");
    }

    public int getErrorCode() {
        return 2;
    }
}
