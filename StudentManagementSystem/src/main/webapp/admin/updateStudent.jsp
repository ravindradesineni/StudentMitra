<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.sms.model.Student"%>

<%
Student student = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Students | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/addStudent.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<!-- Sidebar -->

<jsp:include page="sidebar.jsp"/>

<!-- Main -->

<div class="main">

    <div class="page-title">

        <h1>Update Student</h1>

        <p>Edit Student Information</p>

    </div>

    <div class="form-container">

        <form action="${pageContext.request.contextPath}/UpdateStudentSaveServlet" method="post">

            <div class="row">

                <div class="input-group">

                    <label>Student ID</label>

                    <input type="number"
                           name="studentId"
                           value="<%=student.getStudentId()%>"
                           readonly>

                </div>

                <div class="input-group">

                    <label>Full Name</label>

                    <input type="text"
                           name="fullName"
                           value="<%=student.getFullName()%>"
                           required>

                </div>

            </div>

            <div class="row">

                <div class="input-group">

                    <label>Email</label>

                    <input type="email"
                           name="email"
                           value="<%=student.getEmail()%>"
                           required>

                </div>

                <div class="input-group">

                    <label>Phone</label>

                    <input type="text"
                           name="phone"
                           value="<%=student.getPhone()%>"
                           required>

                </div>

            </div>

            <div class="row">

                <div class="input-group">

                    <label>Gender</label>

                    <select name="gender">

                        <option value="Male"
                        <%=student.getGender().equals("Male") ? "selected" : ""%>>
                        Male
                        </option>

                        <option value="Female"
                        <%=student.getGender().equals("Female") ? "selected" : ""%>>
                        Female
                        </option>

                        <option value="Other"
                        <%=student.getGender().equals("Other") ? "selected" : ""%>>
                        Other
                        </option>

                    </select>

                </div>

                <div class="input-group">

                    <label>Date of Birth</label>

                    <input type="date"
                           name="dob"
                           value="<%=student.getDob()%>"
                           required>

                </div>

            </div>

            <div class="row">

                <div class="input-group">

                    <label>Department</label>

                    <select name="department">

                        <option value="CSE" <%=student.getDepartment().equals("CSE")?"selected":""%>>CSE</option>

                        <option value="ECE" <%=student.getDepartment().equals("ECE")?"selected":""%>>ECE</option>

                        <option value="EEE" <%=student.getDepartment().equals("EEE")?"selected":""%>>EEE</option>

                        <option value="Mechanical" <%=student.getDepartment().equals("Mechanical")?"selected":""%>>Mechanical</option>

                        <option value="Civil" <%=student.getDepartment().equals("Civil")?"selected":""%>>Civil</option>

                    </select>

                </div>

                <div class="input-group">

                    <label>Year</label>

                    <select name="year">

                        <option value="1" <%=student.getYear()==1?"selected":""%>>1</option>

                        <option value="2" <%=student.getYear()==2?"selected":""%>>2</option>

                        <option value="3" <%=student.getYear()==3?"selected":""%>>3</option>

                        <option value="4" <%=student.getYear()==4?"selected":""%>>4</option>

                    </select>

                </div>

            </div>

            <div class="row">

                <div class="input-group full-width">

                    <label>Password</label>

                    <input type="password"
                           name="password"
                           value="<%=student.getPassword()%>"
                           required>

                </div>

            </div>

            <!-- Course & Semester -->
            <div class="row">
                <div class="input-group">
                    <label>Course</label>
                    <input type="text" name="course" value="<%=student.getCourse() != null ? student.getCourse() : ""%>" required>
                </div>
                <div class="input-group">
                    <label>Semester</label>
                    <select name="semester" required>
                        <option value="Semester 1" <%="Semester 1".equals(student.getSemester())?"selected":""%>>Semester 1</option>
                        <option value="Semester 2" <%="Semester 2".equals(student.getSemester())?"selected":""%>>Semester 2</option>
                        <option value="Semester 3" <%="Semester 3".equals(student.getSemester())?"selected":""%>>Semester 3</option>
                        <option value="Semester 4" <%="Semester 4".equals(student.getSemester())?"selected":""%>>Semester 4</option>
                        <option value="Semester 5" <%="Semester 5".equals(student.getSemester())?"selected":""%>>Semester 5</option>
                        <option value="Semester 6" <%="Semester 6".equals(student.getSemester())?"selected":""%>>Semester 6</option>
                        <option value="Semester 7" <%="Semester 7".equals(student.getSemester())?"selected":""%>>Semester 7</option>
                        <option value="Semester 8" <%="Semester 8".equals(student.getSemester())?"selected":""%>>Semester 8</option>
                    </select>
                </div>
            </div>

            <!-- Emergency Contact & Status -->
            <div class="row">
                <div class="input-group">
                    <label>Emergency Contact</label>
                    <input type="text" name="emergencyContact" value="<%=student.getEmergencyContact() != null ? student.getEmergencyContact() : ""%>" maxlength="10" required>
                </div>
                <div class="input-group">
                    <label>Status</label>
                    <select name="status" required>
                        <option value="Active" <%="Active".equals(student.getStatus())?"selected":""%>>Active</option>
                        <option value="Inactive" <%="Inactive".equals(student.getStatus())?"selected":""%>>Inactive</option>
                    </select>
                </div>
            </div>

            <!-- Address -->
            <div class="row">
                <div class="input-group full-width">
                    <label>Address</label>
                    <input type="text" name="address" value="<%=student.getAddress() != null ? student.getAddress() : ""%>" required>
                </div>
            </div>

            <button type="submit">

                <i class="fa-solid fa-pen-to-square"></i>

                Update Student

            </button>

        </form>

    </div>

</div>

</body>

</html>