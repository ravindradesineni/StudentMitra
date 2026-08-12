-- ==========================================
-- CampusCore Database Schema Update - Submissions Table
-- Execute these statements in MySQL Workbench
-- ==========================================

USE student_management_system;

-- Add marks, feedback, and graded_on columns to submissions table
ALTER TABLE submissions ADD COLUMN IF NOT EXISTS marks INT DEFAULT NULL;
ALTER TABLE submissions ADD COLUMN IF NOT EXISTS feedback TEXT DEFAULT NULL;
ALTER TABLE submissions ADD COLUMN IF NOT EXISTS graded_on TIMESTAMP DEFAULT NULL;
