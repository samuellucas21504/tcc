package com.samuel.tcc.authapi.entities.habit;

import com.samuel.tcc.authapi.entities.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.LastModifiedDate;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "HABITS")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Habit {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(columnDefinition = "TEXT")
    private String reason;

    @Column(columnDefinition = "LONGTEXT")
    private String motivation;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @OneToMany(mappedBy = "habit", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<HabitRecord> records = new HashSet<>();

    @LastModifiedDate
    @Temporal(TemporalType.DATE)
    private Date lastModified;
}
