package com.example.studentinfosystem.controller;

import com.example.studentinfosystem.entity.Student;
import com.example.studentinfosystem.service.StudentService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/students")
public class StudentController {

    private final StudentService studentService;

    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping
    public List<Student> getAllStudents() {
        return studentService.getAllStudents();
    }

    @GetMapping("/{id}/gpa")
    public Double getGpa(@PathVariable Long id) {
        return studentService.getGpa(id);
    }
}
