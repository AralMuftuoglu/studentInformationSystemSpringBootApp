package com.codewitharal.sis.repositories;

import com.codewitharal.sis.entities.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {

    // Oracle PROCEDURE example (must exist in DB via Flyway)
    @Procedure(procedureName = "ENROLL_STUDENT")
    void enrollStudent(@Param("P_STUDENT_ID") Long studentId, @Param("P_COURSE_ID") Long courseId);
}
