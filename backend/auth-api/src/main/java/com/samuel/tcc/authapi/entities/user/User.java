package com.samuel.tcc.authapi.entities.user;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.util.*;

@Entity
@Table(name = "USERS", indexes = @Index(columnList = "name"))
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIdentityInfo(generator= ObjectIdGenerators.IntSequenceGenerator.class, property="id")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String name;
    private String email;
    private String password;

    @CreationTimestamp
    @Temporal(TemporalType.DATE)
    private Date createdAt;

    @JsonManagedReference
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "requester", cascade = CascadeType.ALL)
    private Set<FriendRequest> friendRequests = new HashSet<>();

    @JsonManagedReference
    @ManyToMany(fetch = FetchType.EAGER)
    private List<User> friends = new ArrayList<>();
}
