package com.samuel.tcc.authapi.repositories.habit;

import com.samuel.tcc.authapi.entities.habit.Habit;
import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.Optional;
import java.util.UUID;

public interface HabitRepository extends JpaRepository<Habit, UUID> {
    @Query("SELECT ht FROM Habit ht WHERE ht.user.email = :userEmail")
    Optional<Habit> findByUserEmail(@Param("userEmail") String email);
}
