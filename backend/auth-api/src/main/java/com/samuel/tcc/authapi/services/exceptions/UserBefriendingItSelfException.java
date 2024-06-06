package com.samuel.tcc.authapi.services.exceptions;

public class UserBefriendingItSelfException extends RuntimeException {
    public UserBefriendingItSelfException() {
        super("Não é possível se adicionar como amigo.");
    }

    public int getErrorCode() {
        return 4;
    }
}
