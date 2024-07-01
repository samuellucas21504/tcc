package com.samuel.tcc.authapi.services.exceptions;

public class UserNotInChallengeException extends RuntimeException{
    public UserNotInChallengeException() {
        super("O usuário não está no desafio.");
    }

    public int getErrorCode() {
        return 9;
    }
}
