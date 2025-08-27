package com.codewitharal.sis.controllers;

import com.codewitharal.sis.services.EnrollmentService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/enrollments")
public class EnrollmentController {

    private final EnrollmentService enrollmentService;

    public EnrollmentController(EnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @PostMapping("/enroll")
    public void enroll(@RequestParam Long studentId, @RequestParam Long courseId) {
        enrollmentService.enroll(studentId, courseId);
    }
}
