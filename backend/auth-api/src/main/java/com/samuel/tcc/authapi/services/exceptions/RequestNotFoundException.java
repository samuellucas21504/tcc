package com.samuel.tcc.authapi.services.exceptions;

public class RequestNotFoundException extends RuntimeException {
    public RequestNotFoundException() {
        super("O pedido não foi encontrado.");
    }
    public int getErrorCode() {
        return 3;
    }
}
