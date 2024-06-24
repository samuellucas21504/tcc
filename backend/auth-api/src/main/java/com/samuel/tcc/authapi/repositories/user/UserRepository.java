package com.samuel.tcc.authapi.repositories.user;

import com.samuel.tcc.authapi.entities.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByEmail(String email);
    @Query("SELECT fr.friend FROM FriendRequest fr JOIN fr.requester u WHERE u.email = :email AND fr.active = true")
    List<User> findFriendsByEmail(@Param("email") String email);
}
