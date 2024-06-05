package com.samuel.tcc.authapi.infra.handlers.models;

public record CustomError(
        int errorCode,
         String message
) { }
