package com.sms.model;

public class Marks {
    private int marksId;
    private int studentId;
    private String studentName; // Helper for display
    private int courseId;
    private String courseCode; // Helper for display
    private String courseName; // Helper for display
    private int internal1;
    private int internal2;
    private int assignment;
    private int finalExam;
    private int total;
    private String grade;

    public Marks() {}

    public int getMarksId() {
        return marksId;
    }

    public void setMarksId(int marksId) {
        this.marksId = marksId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getInternal1() {
        return internal1;
    }

    public void setInternal1(int internal1) {
        this.internal1 = internal1;
    }

    public int getInternal2() {
        return internal2;
    }

    public void setInternal2(int internal2) {
        this.internal2 = internal2;
    }

    public int getAssignment() {
        return assignment;
    }

    public void setAssignment(int assignment) {
        this.assignment = assignment;
    }

    public int getFinalExam() {
        return finalExam;
    }

    public void setFinalExam(int finalExam) {
        this.finalExam = finalExam;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
