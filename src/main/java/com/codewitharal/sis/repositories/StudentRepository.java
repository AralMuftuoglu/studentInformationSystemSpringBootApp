package com.codewitharal.sis.repositories;

import com.codewitharal.sis.entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {

    // Oracle FUNCTION example (must exist in DB via Flyway)
    @Query(value = "SELECT get_gpa(:studentId) FROM dual", nativeQuery = true)
    Double getStudentGpa(@Param("studentId") Long studentId);
}
