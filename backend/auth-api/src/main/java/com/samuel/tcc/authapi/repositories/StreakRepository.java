package com.samuel.tcc.authapi.repositories;

import com.samuel.tcc.authapi.entities.streak.StreakDay;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StreakRepository extends JpaRepository<StreakDay, String> {
}
