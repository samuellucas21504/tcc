package com.samuel.tcc.authapi.repositories.challenge;

import com.samuel.tcc.authapi.entities.challenge.Challenge;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ChallengeRepository extends JpaRepository<Challenge, UUID> {
    @Query("SELECT ch FROM CHALLENGES ch JOIN ch.participants p WHERE p.email = :userEmail AND ch.finishesAt <= current date ")
    List<Challenge> findUserChallenges(@Param("userEmail") String userEmail);
}
