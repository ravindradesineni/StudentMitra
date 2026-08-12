document.addEventListener("DOMContentLoaded", function() {
    var currentPath = window.location.pathname;

    // ================= DYNAMIC MAIN MENU HIGHLIGHTING =================
    var listItems = document.querySelectorAll(".sidebar > ul > li");

    function pathMatches(pagesArray) {
        return pagesArray.some(function(page) {
            return currentPath.indexOf(page) !== -1;
        });
    }

    listItems.forEach(function(li) {
        // Remove default active state so JS can resolve it dynamically
        li.classList.remove("active");

        var link = li.querySelector("a");
        if (!link) return;
        var href = link.getAttribute("href");
        if (!href) return;
        var page = href.split("/").pop();

        if (page === "DashboardServlet" && pathMatches(["DashboardServlet"])) {
            li.classList.add("active");
        } else if (page === "StudentsServlet" && pathMatches(["StudentsServlet", "students.jsp", "addStudent", "updateStudent", "studentSummary", "studentProfile.jsp"])) {
            li.classList.add("active");
        } else if (page === "DepartmentsServlet" && pathMatches(["DepartmentsServlet", "departments.jsp", "addDepartment", "updateDepartment", "departmentSummary"])) {
            li.classList.add("active");
        } else if (page === "CoursesServlet" && pathMatches(["CoursesServlet", "courses.jsp", "addCourse", "updateCourse"])) {
            li.classList.add("active");
        } else if (page === "AttendanceServlet" && pathMatches(["AttendanceServlet", "attendance.jsp", "addAttendance", "updateAttendance"])) {
            li.classList.add("active");
        } else if (page === "MarksServlet" && pathMatches(["MarksServlet", "marks.jsp", "addMarks", "updateMarks"])) {
            li.classList.add("active");
        } else if (page === "AnnouncementsServlet" && pathMatches(["AnnouncementsServlet", "announcements.jsp", "addAnnouncement", "updateAnnouncement"])) {
            li.classList.add("active");
        } else if (page === "AcademicCalendarServlet" && pathMatches(["AcademicCalendarServlet", "academicCalendar.jsp", "addEvent", "updateEvent"])) {
            li.classList.add("active");
        } else if (page === "StudyMaterialsServlet" && pathMatches(["StudyMaterialsServlet", "studyMaterials.jsp", "uploadMaterial", "updateMaterial"])) {
            li.classList.add("active");
        }
    });

    // ================= GENERIC COLLAPSIBLE ACCORDION =================
    var toggles = document.querySelectorAll(".submenu-toggle");

    toggles.forEach(function(toggle) {
        var parentLi = toggle.closest(".has-submenu");
        if (!parentLi) return;

        // Click event listener
        toggle.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            // Collapse other submenus if accordion behavior is desired
            document.querySelectorAll(".has-submenu").forEach(function(otherParent) {
                if (otherParent !== parentLi) {
                    otherParent.classList.remove("open");
                }
            });

            // Toggle current submenu
            parentLi.classList.toggle("open");
        });

        // Check if current page is within this submenu's links to auto-expand
        var subItems = parentLi.querySelectorAll(".submenu-item a");
        var shouldExpand = false;

        subItems.forEach(function(item) {
            var href = item.getAttribute("href");
            if (href && currentPath.indexOf(href.split("/").pop()) !== -1) {
                item.parentElement.classList.add("active");
                shouldExpand = true;
            }
        });

        // Specific rules for subpages that might not be in direct sub-menu links
        if (parentLi.querySelector(".fa-pen-to-square")) { // Assignments Parent
            if (pathMatches(["ViewSubmissionServlet", "UpdateAssignmentServlet"])) {
                shouldExpand = true;
            }
        }

        if (shouldExpand) {
            parentLi.classList.add("open");
            parentLi.classList.add("active");
        }
    });

    // ================= DYNAMIC MOBILE SIDEBAR TOGGLE =================
    var sidebar = document.querySelector(".sidebar");
    if (sidebar) {
        // Create hamburger button dynamically
        var toggleBtn = document.createElement("button");
        toggleBtn.className = "sidebar-toggle";
        toggleBtn.setAttribute("aria-label", "Toggle Menu");
        toggleBtn.innerHTML = '<i class="fa-solid fa-bars"></i>';
        document.body.appendChild(toggleBtn);

        // Bind click event to toggle sidebar state
        toggleBtn.addEventListener("click", function(e) {
            e.stopPropagation();
            sidebar.classList.toggle("open");
        });

        // Close sidebar when clicking on main container or body outside
        document.addEventListener("click", function(e) {
            if (!sidebar.contains(e.target) && e.target !== toggleBtn) {
                sidebar.classList.remove("open");
            }
        });
    }
});
