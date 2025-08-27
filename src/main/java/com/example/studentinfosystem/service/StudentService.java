package com.example.studentinfosystem.service;

import com.example.studentinfosystem.entity.Student;
import com.example.studentinfosystem.repository.StudentRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class StudentService {

    private final StudentRepository studentRepository;

    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public Double getGpa(Long studentId) {
        return studentRepository.calculateGpa(studentId);
    }
}
