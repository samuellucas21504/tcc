package com.samuel.tcc.authapi.controllers.exceptions;

public class  EmailAlreadyExistsException extends RuntimeException  {
    public EmailAlreadyExistsException() {
        super("Esse email já está cadastrado.");
    }
    public int getErrorCode() {
        return 1;
    }
}
