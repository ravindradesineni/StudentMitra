<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sms.model.Department"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Departments | StudentMitra</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/students.css">

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

    <div class="top-bar">

        <div>

            <h1>Department Management</h1>

            <p>Manage all departments from one place.</p>

        </div>

        <a href="${pageContext.request.contextPath}/DashboardServlet" class="logout">
            <i class="fa-solid fa-arrow-left"></i>
            Back
        </a>

    </div>

    <div class="actions">

        <button onclick="window.location.href='${pageContext.request.contextPath}/admin/addDepartment.jsp'">

            <i class="fa-solid fa-plus"></i>

            Add Department

        </button>

    </div>

    <div class="table-box">

        <table>

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Department Name</th>

                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

            <%

            ArrayList<Department> departmentList =
                    (ArrayList<Department>) request.getAttribute("departmentList");

            if(departmentList != null && !departmentList.isEmpty()){

                for(Department department : departmentList){

            %>

            <tr>

                <td><%=department.getDepartmentId()%></td>

                <td><%=department.getDepartmentName()%></td>

                <td>

                    <a href="${pageContext.request.contextPath}/UpdateDepartmentServlet?id=<%=department.getDepartmentId()%>">

                        Edit

                    </a>

                    |

                    <a href="${pageContext.request.contextPath}/DeleteDepartmentServlet?id=<%=department.getDepartmentId()%>"
                       onclick="return confirm('Are you sure you want to delete this department?')">

                        Delete

                    </a>

                </td>

            </tr>

            <%

                }

            } else {

            %>

            <tr>

                <td colspan="3">

                    No Departments Available

                </td>

            </tr>

            <%

            }

            %>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>