package com.samuel.tcc.authapi.repositories.challenge;

import com.samuel.tcc.authapi.entities.challenge.Challenge;
import com.samuel.tcc.authapi.entities.challenge.ChallengeRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface ChallengeRecordRepository extends JpaRepository<ChallengeRecord, UUID> {
    @Query("SELECT cr " +
            "FROM ChallengeRecord cr " +
            "WHERE cr.user.email = :userEmail and cr.challenge.id = :challengeId")
    Optional<ChallengeRecord> findByUserEmailAndRecordDate(@Param("userEmail") String userEmail, @Param("challengeId") UUID challengeId);
}
