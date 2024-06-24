package com.samuel.tcc.authapi.entities.challenge;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.samuel.tcc.authapi.entities.habit.HabitRecord;
import com.samuel.tcc.authapi.entities.user.FriendRequest;
import com.samuel.tcc.authapi.entities.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import com.samuel.tcc.authapi.entities.user.User;



import java.util.*;

@Entity(name = "CHALLENGES")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIdentityInfo(generator= ObjectIdGenerators.IntSequenceGenerator.class, property="id")
public class Challenge {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String name;
    private Date finishesAt;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    private User creator;

    @JsonManagedReference
    @ManyToMany(fetch = FetchType.EAGER)
    private List<User> participants = new ArrayList<>();

    @CreationTimestamp
    @Temporal(TemporalType.DATE)
    private Date createdAt;

    @OneToMany(mappedBy = "challenge", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ChallengeRecord> records = new HashSet<>();
}
