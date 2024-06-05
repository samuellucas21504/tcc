package com.samuel.tcc.authapi.entities.user;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
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
@Table(name = "FRIEND_REQUESTS")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIdentityInfo(generator= ObjectIdGenerators.IntSequenceGenerator.class, property="id")
public class FriendRequest implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    private User requester;

    @ManyToOne
    @JoinColumn(referencedColumnName = "id")
    @JsonBackReference
    private User friend;

    @Temporal(TemporalType.TIMESTAMP)
    @CreationTimestamp
    Date date;

    @Column(nullable = false)
    boolean active;
}
