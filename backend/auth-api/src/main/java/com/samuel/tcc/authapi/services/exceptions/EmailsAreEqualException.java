package com.samuel.tcc.authapi.services.exceptions;

public class EmailsAreEqualException extends RuntimeException {
    public EmailsAreEqualException() {
        super("Os emails são iguais.");
    }
    public int getErrorCode() {
        return 8;
    }
}
