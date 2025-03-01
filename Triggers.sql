create database employee;
use employee;
CREATE TABLE Teachers (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  subject VARCHAR(255),
  experience INT,
  salary DECIMAL(10, 2)
);
INSERT INTO Teachers (id, name, subject, experience, salary)
VALUES
(1, 'Akhil Krishnan', 'Math', 5, 50000.00),
(2, 'Aparna Nair', 'Science', 10, 60000.00),
(3, 'Arjun Raveendran', 'English', 7, 55000.00),
(4, 'Ashwathy Sreekumar', 'History', 12, 70000.00),
(5, 'Biju Balakrishnan', 'Geography', 8, 58000.00),
(6, 'Dhanya Das', 'Physics', 6, 52000.00),
(7, 'Jithin Jose', 'Chemistry', 9, 62000.00),
(8, 'Karthika Suresh', 'Biology', 11, 68000.00);

DELIMITER //
CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON Teachers
FOR EACH ROW
BEGIN
  IF NEW.salary < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Salary cannot be negative';
  END IF;
END //
DELIMITER ;
CREATE TABLE Teacher_Log (
  teacher_id INT,
  action VARCHAR(255),
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON Teachers
FOR EACH ROW
BEGIN
  INSERT INTO Teacher_Log (teacher_id, action)
  VALUES (NEW.id, 'INSERT');
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON Teachers
FOR EACH ROW
BEGIN
  IF OLD.experience > 10 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot delete teacher with experience greater than 10 years';
  END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER after_delete_teacher
AFTER DELETE ON Teachers
FOR EACH ROW
BEGIN
  INSERT INTO Teacher_Log (teacher_id, action)
  VALUES (OLD.id, 'DELETE');
END //
DELIMITER ;
select * from teachers;
drop database employee;