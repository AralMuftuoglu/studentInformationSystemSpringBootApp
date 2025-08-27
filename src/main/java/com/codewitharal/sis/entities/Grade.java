package com.codewitharal.sis.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "GRADE")
public class Grade {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "GRADE_ID")
    private Long gradeId;

    @ManyToOne
    @JoinColumn(name = "ENROLLMENT_ID")
    private Enrollment enrollment;

    @Column(name = "SCORE")
    private Double score;

    // getters and setters
    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
    public Enrollment getEnrollment() { return enrollment; }
    public void setEnrollment(Enrollment enrollment) { this.enrollment = enrollment; }
    public Double getScore() { return score; }
    public void setScore(Double score) { this.score = score; }
}
