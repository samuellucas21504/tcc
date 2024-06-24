package com.samuel.tcc.authapi.repositories.user;

import com.samuel.tcc.authapi.entities.user.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface FriendRequestRepository extends JpaRepository<FriendRequest, UUID> {
    @Query("SELECT fr FROM FriendRequest fr WHERE fr.friend.email = :email and fr.active = true")
    List<FriendRequest> findFriendRequestByEmail(@Param("email") String email);

    @Query("SELECT fr FROM FriendRequest fr WHERE fr.friend.email = :user_email and fr.requester.email = :requester_email")
    Optional<FriendRequest> findFriendRequestByUserAndRequesterEmail(
            @Param("requester_email") String requesterEmail,
            @Param("user_email") String userEmail
    );
}
