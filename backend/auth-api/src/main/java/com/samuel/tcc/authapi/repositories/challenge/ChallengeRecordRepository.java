package com.samuel.tcc.authapi.repositories.challenge;

import com.samuel.tcc.authapi.entities.challenge.ChallengeRecord;
import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ChallengeRecordRepository extends JpaRepository<ChallengeRecord, UUID> {
    @Query("SELECT cr FROM ChallengeRecord cr WHERE cr.user.email = :userEmail AND cr.recordDate = :recordDate")
    Optional<ChallengeRecord> findByUserEmailAndRecordDate(@Param("userEmail") String userEmail, @Param("recordDate") Date recordDate);

    @Query("SELECT day(cr.recordDate) " +
            "FROM ChallengeRecord cr " +
            "WHERE cr.user.email = :userEmail AND MONTH(cr.recordDate) = :month AND YEAR(cr.recordDate) = :year " +
            "ORDER BY DAY(cr.recordDate) ASC")
    List<Integer> findByUserEmailAndRecordMonth(@Param("userEmail") String userEmail, @Param("month") int month, @Param("year") int year);
}
