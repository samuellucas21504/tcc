package com.samuel.tcc.authapi.entities.habit;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "HABIT_RECORDS")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class HabitRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "habit_id", referencedColumnName = "id")
    private Habit habit;

    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date recordDate;
}
