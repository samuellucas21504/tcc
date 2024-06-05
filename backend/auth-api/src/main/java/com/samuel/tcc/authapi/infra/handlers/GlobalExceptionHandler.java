package com.samuel.tcc.authapi.infra.handlers;

import com.samuel.tcc.authapi.infra.handlers.models.CustomError;
import com.samuel.tcc.authapi.services.exceptions.FriendRequestNotFoundException;
import com.samuel.tcc.authapi.services.exceptions.UserNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(UserNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseEntity<CustomError> handleUserNotFoundException(UserNotFoundException ex) {
        CustomError error = new CustomError(ex.getErrorCode(), ex.getMessage());

        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(FriendRequestNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseEntity<CustomError> handleFriendRequestNotFoundException(FriendRequestNotFoundException ex) {
        CustomError error = new CustomError(ex.getErrorCode(), ex.getMessage());

        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }
}
