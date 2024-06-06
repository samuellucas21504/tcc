package com.samuel.tcc.authapi.services.exceptions;

public class FriendRequestNotFoundException extends RuntimeException {
    public FriendRequestNotFoundException() {
        super("O pedido de amizade não foi encontrado.");
    }
    public int getErrorCode() {
        return 3;
    }
}
