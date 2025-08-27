package com.codewitharal.sis.controllers;

import com.codewitharal.sis.entities.Student;
import com.codewitharal.sis.services.StudentService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    private final StudentService studentService;

    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping
    public List<Student> all() { return studentService.findAll(); }

    @PostMapping
    public Student create(@RequestBody Student s) { return studentService.create(s); }

    @GetMapping("/{id}/gpa")
    public Double gpa(@PathVariable Long id) { return studentService.getGpa(id); }
}
