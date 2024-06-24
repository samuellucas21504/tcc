package com.samuel.tcc.authapi.services.exceptions;

public class ChallengeNotFoundException extends RuntimeException {
    public ChallengeNotFoundException() {
        super("O desafio não foi encontrado.");
    }

    public int getErrorCode() {
        return 7;
    }
}
