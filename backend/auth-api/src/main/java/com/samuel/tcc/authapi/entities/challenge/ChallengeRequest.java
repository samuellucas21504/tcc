package com.samuel.tcc.authapi.entities.challenge;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.samuel.tcc.authapi.entities.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "CHALLENGE_REQUEST")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIdentityInfo(generator= ObjectIdGenerators.IntSequenceGenerator.class, property="id")
public class ChallengeRequest implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    private Challenge challenge;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    private User challenger;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    @JsonBackReference
    private User challenged;

    @Temporal(TemporalType.TIMESTAMP)
    @CreationTimestamp
    Date date;

    @Column(nullable = false)
    boolean active;
}
