# Student Information System (SIS) - Spring Boot 

## Features
- Spring Web, Spring Data JPA
- Oracle JDBC, Flyway (Oracle plugin)
- Entity / Repository / Service / Controller layers
- Example usage of Stored Procedures & Functions
- Flyway migration files:
    - Tables
    - Sequences
    - Triggers
    - Procedures
    - Functions
    - Views

## API Examples
- `GET /api/students` : Get all students  
- `POST /api/students` : Create a new student  
- `GET /api/students/{id}/gpa` : Calls Oracle FUNCTION `get_gpa`  
- `POST /api/enrollments/enroll?studentId=1&courseId=2` : Calls Oracle PROCEDURE `ENROLL_STUDENT`  

