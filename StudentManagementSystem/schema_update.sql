-- ==========================================
-- CampusCore Database Schema Update
-- Execute these statements in MySQL Workbench
-- ==========================================

USE student_management_system;

-- 1. Create Academic Calendar Table
CREATE TABLE IF NOT EXISTS academic_calendar (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME,
    description TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'Upcoming'
);

-- 2. Create Study Materials Table
CREATE TABLE IF NOT EXISTS study_materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    course VARCHAR(100) NOT NULL,
    semester VARCHAR(20) NOT NULL,
    category VARCHAR(100) NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    uploaded_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Update Student Table with profile columns
-- Note: ALTER statements will fail if columns already exist.
-- You can run these ALTER statements individually as needed.

ALTER TABLE student ADD COLUMN address VARCHAR(255);
ALTER TABLE student ADD COLUMN emergency_contact VARCHAR(20);
-- default value 'uploads/profile-photos/default-avatar.png' will be used if no photo is uploaded
ALTER TABLE student ADD COLUMN profile_photo VARCHAR(255) DEFAULT 'uploads/profile-photos/default-avatar.png';
ALTER TABLE student ADD COLUMN course VARCHAR(100);
ALTER TABLE student ADD COLUMN semester VARCHAR(20);
ALTER TABLE student ADD COLUMN status VARCHAR(20) DEFAULT 'Active';
