-- ==========================================
-- CampusCore Database Schema for Assignments & Submissions
-- Execute these statements in MySQL Workbench
-- ==========================================

USE student_management_system;

-- 1. Ensure Student table has profile_photo column and set default to uploads/students/default-avatar.png
-- Run these statements as needed.
-- ALTER TABLE student ADD COLUMN profile_photo VARCHAR(255) DEFAULT 'uploads/students/default-avatar.png';
-- If column already exists, we modify its default value:
ALTER TABLE student MODIFY COLUMN profile_photo VARCHAR(255) DEFAULT 'uploads/students/default-avatar.png';

-- 2. Create Assignments Table
CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    due_date DATE NOT NULL,
    pdf_path VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create Submissions Table
CREATE TABLE IF NOT EXISTS submissions (
    submission_id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);
