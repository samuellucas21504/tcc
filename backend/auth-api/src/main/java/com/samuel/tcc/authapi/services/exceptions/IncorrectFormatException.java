package com.samuel.tcc.authapi.services.exceptions;

public class IncorrectFormatException extends RuntimeException {
    public IncorrectFormatException() {
        super("Formatação incorreta");
    }

    public int getErrorCode() {
        return 8;
    }
}
