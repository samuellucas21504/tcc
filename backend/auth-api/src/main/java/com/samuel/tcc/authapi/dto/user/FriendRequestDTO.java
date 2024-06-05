package com.samuel.tcc.authapi.dto.user;

import java.util.Date;

public record FriendRequestDTO(
        UserDTO requester,
        Date date
        ) {
}
