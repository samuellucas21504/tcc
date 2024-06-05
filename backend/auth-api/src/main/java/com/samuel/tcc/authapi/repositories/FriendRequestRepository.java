package com.samuel.tcc.authapi.repositories;

import com.samuel.tcc.authapi.entities.user.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface FriendRequestRepository extends JpaRepository<FriendRequest, UUID> {
    @Query("SELECT fr FROM FriendRequest fr WHERE fr.friend.email = :email")
    List<FriendRequest> findFriendRequestByEmail(@Param("email") String email);
}
