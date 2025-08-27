package com.example.studentinfosystem.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "STUDENTS")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long studentId;

    private String firstName;
    private String lastName;
    private Date birthDate;

    // getter-setter
}
