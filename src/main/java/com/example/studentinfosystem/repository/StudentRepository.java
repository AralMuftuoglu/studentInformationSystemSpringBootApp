package com.example.studentinfosystem.repository;

import com.example.studentinfosystem.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface StudentRepository extends JpaRepository<Student, Long> {

    // örnek stored procedure çağrımı
    @Procedure(name = "calculate_gpa")
    Double calculateGpa(@Param("student_id_in") Long studentId);
}
