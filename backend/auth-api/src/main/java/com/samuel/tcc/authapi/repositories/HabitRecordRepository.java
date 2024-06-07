package com.samuel.tcc.authapi.repositories;

import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface HabitRecordRepository extends JpaRepository<HabitRecord, UUID> {
    @Query("SELECT hr FROM HabitRecord hr WHERE hr.habit.user.email = :userEmail AND hr.recordDate = :recordDate")
    Optional<HabitRecord> findByUserEmailAndRecordDate(@Param("userEmail") String userEmail, @Param("recordDate") Date recordDate);

    @Query("SELECT day(hr.recordDate) " +
            "FROM HabitRecord hr " +
            "WHERE hr.habit.user.email = :userEmail AND MONTH(hr.recordDate) = :month AND YEAR(hr.recordDate) = :year " +
            "ORDER BY DAY(hr.recordDate) ASC")
    List<Integer> findByUserEmailAndRecordMonth(@Param("userEmail") String userEmail, @Param("month") int month, @Param("year") int year);
}
