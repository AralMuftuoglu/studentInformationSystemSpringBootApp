package com.codewitharal.sis.services;

import com.codewitharal.sis.entities.Student;
import com.codewitharal.sis.repositories.StudentRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    private final StudentRepository studentRepository;

    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public Student create(Student s) { return studentRepository.save(s); }
    public List<Student> findAll() { return studentRepository.findAll(); }
    public Double getGpa(Long studentId) { return studentRepository.getStudentGpa(studentId); }
}
