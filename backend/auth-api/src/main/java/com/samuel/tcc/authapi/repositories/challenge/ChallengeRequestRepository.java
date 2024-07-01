package com.samuel.tcc.authapi.repositories.challenge;

import com.samuel.tcc.authapi.entities.challenge.Challenge;
import com.samuel.tcc.authapi.entities.challenge.ChallengeRequest;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ChallengeRequestRepository extends JpaRepository<ChallengeRequest, UUID> {
    @Query("SELECT cr FROM ChallengeRequest cr WHERE cr.challenged.email = :email and cr.active = true")
    List<ChallengeRequest> findRequestByEmail(@Param("email") String email);

    @Query( "SELECT cr " +
            "FROM ChallengeRequest cr " +
            "WHERE cr.challenger.email = :user_email " +
            "and cr.challenged.email = :requester_email " +
            "and cr.challenge.id = :challenge_id"
    )
    Optional<ChallengeRequest> findFriendRequestByUserAndRequesterEmail(
            @Param("user_email") String userEmail,
            @Param("requester_email") String requesterEmail,
            @Param("challenge_id") UUID challengeId

    );
}
