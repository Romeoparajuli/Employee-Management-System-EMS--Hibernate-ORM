<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String contextPath = request.getContextPath(); // Retrieve the context path
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Employees</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
/* Pop-up message styles */
.popup-message {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #38a169; /* Green background */
	color: white;
	padding: 16px;
	border-radius: 8px;
	font-size: 16px;
	font-weight: bold;
	z-index: 1000;
	display: none; /* Hidden by default */
	opacity: 0;
	transition: opacity 0.5s ease-in-out;
}

/* Rest of your styles */
body {
	font-family: 'Poppins', sans-serif;
}

/* Table */
table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	text-align: left;
	padding: 12px 20px;
}

th {
	background-color: #2D6A4F;
	color: white;
}

td {
	background-color: #f9f9f9;
	transition: background-color 0.3s ease;
}

td:hover {
	background-color: #f1f1f1;
}

/* Table row hover effect */
tr:hover {
	background-color: #f1f1f1;
}

/* Sidebar */
.sidebar {
	transition: all 0.3s ease-in-out;
	width: 250px;
	min-height: 100vh;
}

.sidebar.collapsed {
	width: 64px;
}

.sidebar.collapsed .menu-text {
	display: none;
}

.main-content {
	transition: margin-left 0.3s ease-in-out;
	padding: 2rem;
}

.main-content.collapsed {
	margin-left: 64px;
}

/* Action buttons */
.action-buttons a {
	margin-right: 10px;
	color: white;
	padding: 8px 16px;
	border-radius: 8px;
	text-transform: uppercase;
	font-weight: bold;
	transition: transform 0.3s ease, background-color 0.3s ease;
}

.action-buttons .edit {
	background-color: #34D399; /* Green */
}

.action-buttons .delete {
	background-color: #F87171; /* Red */
}

.action-buttons .edit:hover {
	transform: scale(1.05);
	background-color: #2D6A4F;
}

.action-buttons .delete:hover {
	transform: scale(1.05);
	background-color: #C53030;
}

/* Pagination */
.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination a {
	margin: 0 5px;
	padding: 10px 15px;
	border: 1px solid #ddd;
	color: #2D6A4F;
	text-decoration: none;
	border-radius: 8px;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.pagination a.active {
	background-color: #2D6A4F;
	color: white;
	pointer-events: none;
}

.pagination a:hover:not(.active) {
	background-color: #d9d9d9;
}
</style>
</head>
<body class="bg-gray-100 flex">

	<!-- Sidebar -->
	<div class="sidebar bg-gray-800 text-white transition-all">
		<div class="flex items-center justify-between px-6 py-4">
			<button id="toggleSidebar" class="text-white">
				<i class="fas fa-bars"></i>
			</button>
		</div>
		<nav>
			<ul>
				<li class="px-6 py-3 hover:bg-gray-700 flex items-center"><a
					href="dashboard" class="flex items-center"> <i
						class="fas fa-home menu-icon mr-4"></i> <span class="menu-text">Dashboard</span></a></li>
				<li
					class="px-6 py-3 hover:bg-gray-700 flex items-center cursor-pointer"
					onclick="toggleSubmenu('employeeSubmenu')"><i
					class="fas fa-user-tie menu-icon mr-4"></i> <span class="menu-text">Employee</span>
					<i class="fas fa-chevron-down ml-auto"></i></li>
				<ul id="employeeSubmenu" class="submenu hidden">
					<li class="px-6 py-2 hover:bg-gray-600"><a href="addEmp"
						class="flex items-center"> <i class="fas fa-plus-circle mr-4"></i>Add
							Employee
					</a></li>
					<li class="px-6 py-2 hover:bg-gray-600"><a href="viewemp"
						class="flex items-center"> <i class="fas fa-eye mr-4"></i>
							View Employee
					</a></li>
				</ul>
				<li class="px-6 py-3 hover:bg-gray-700 flex items-center"><a
					href="logOut" class="flex items-center"> <i
						class="fas fa-sign-out-alt menu-icon mr-4"></i> <span
						class="menu-text">Logout</span></a></li>
			</ul>
		</nav>
	</div>

	<!-- Display success message -->
	<c:if test="${not empty sessionScope.msg}">
		<div id="popupMessage" class="popup-message">
			<span>${sessionScope.msg}</span>
		</div>
		<c:set var="msg" value="${sessionScope.msg}" />
		<c:remove var="msg" />
	</c:if>

	<!-- Main Content -->
	<div class="main-content flex-grow">
		<div class="container mx-auto p-4">
			<h2 class="text-3xl font-bold text-gray-800 mb-6">Employee List</h2>

			<!-- Search Bar -->
			<div class="flex justify-between items-center mb-6">
				<input type="text" id="searchInput"
					placeholder="Search employees..."
					class="px-4 py-2 border rounded-lg w-1/3 focus:outline-none focus:ring-2 focus:ring-green-500"
					onkeyup="filterTable()" />
			</div>
			<div class="overflow-x-auto">
				<table id="employees" class="table-auto w-full border">
					<thead>
						<tr>
							<th>ID</th>
							<th>Full Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>Address</th>
							<th>Department</th>
							<th>Position</th>
							<th>Phone Number</th>
							<th>Actions</th>
						</tr>
					</thead>
					<c:if test="${not empty employeeList}">
						<c:forEach var="emp" items="${employeeList}">
							<tr>
								<td>${emp.id}</td>
								<td>${emp.fullname}</td>
								<td>${emp.gender}</td>
								<td>${emp.email}</td>
								<td>${emp.address}</td>
								<td>${emp.department}</td>
								<td>${emp.position}</td>
								<td>${emp.phoneNumber}</td>
								<td class="action-buttons">
									<div class="flex space-x-2">
										<a href="editEmp/${emp.id}"
											class="edit px-4 py-2 rounded-lg text-white font-semibold bg-green-500 hover:bg-green-600 transition-all duration-300">Edit</a>
										<a href="deleteEmp/${emp.id}"
											onclick="return confirm('Are you sure?')"
											class="delete px-4 py-2 rounded-lg text-white font-semibold bg-red-500 hover:bg-red-600 transition-all duration-300">Delete</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty employeeList}">
						<tr>
							<td colspan="9" class="text-center py-4 text-gray-500">No
								employees found.</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>

		<!-- Pagination Controls -->
		<div class="pagination">
			<c:if test="${currentPage > 1}">
				<a href="?page=${currentPage - 1}">&laquo; Previous</a>
			</c:if>
			<c:forEach var="i" begin="1" end="${totalPages}">
				<a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
			</c:forEach>
			<c:if test="${currentPage < totalPages}">
				<a href="?page=${currentPage + 1}">Next &raquo;</a>
			</c:if>
		</div>
	</div>


	<script>
    
    document.getElementById('toggleSidebar').onclick = function() {
		document.querySelector('.sidebar').classList.toggle('collapsed');
		document.querySelector('.main-content').classList
				.toggle('collapsed');
	};
	
	function filterTable() {
	    const searchInput = document.getElementById('searchInput').value.toLowerCase();
	    const table = document.getElementById('employees');
	    const rows = table.getElementsByTagName('tr');
	    let matchFound = false; // Track if any match is found

	    // Ensure the table and rows are present
	    if (!table || rows.length < 2) {
	        console.error("Table or rows not found!");
	        return;
	    }

	    // Iterate through each row (starting from index 1 to skip header)
	    for (let i = 1; i < rows.length; i++) {
	        const cells = rows[i].getElementsByTagName('td');
	        let rowMatches = false;

	        // Check each cell in the row for a match with the search input
	        for (let j = 0; j < cells.length; j++) {
	            const cellText = cells[j].textContent || cells[j].innerText;
	            if (cellText.toLowerCase().includes(searchInput)) {
	                rowMatches = true; // A match is found
	                break;
	            }
	        }

	        // Show or hide the row based on whether it matches
	        rows[i].style.display = rowMatches ? '' : 'none';
	        if (rowMatches) matchFound = true; // At least one match found
	    }

	    // Manage the "No matching users found" message visibility
	    let noMatchMessage = document.getElementById('noMatchMessage');

	    if (searchInput.length > 0) {
	        if (!matchFound) {
	            // If no matches and there is input, display the "No matching users found" message
	            if (!noMatchMessage) {
	                const messageRow = document.createElement('tr');
	                messageRow.id = 'noMatchMessage';
	                const cell = document.createElement('td');
	                cell.colSpan = rows[0].getElementsByTagName('th').length; // Span across all columns
	                cell.className = 'text-center py-4 text-red-500 font-bold';
	                cell.textContent = "No matching users found.";
	                messageRow.appendChild(cell);
	                table.appendChild(messageRow);
	            }
	        } else {
	            // If there are matches, remove the "No matching users found" message (if it exists)
	            if (noMatchMessage) {
	                noMatchMessage.remove();
	            }
	        }
	    } else {
	        // If the search input is empty, remove the "No matching users found" message
	        if (noMatchMessage) {
	            noMatchMessage.remove();
	        }
	    }
	}

	function toggleSubmenu(id) {
		document.getElementById(id).classList.toggle('open');
	}
        // Show the popup message if it's present
        window.onload = function() {
            const msg = "<c:out value='${sessionScope.msg}' />";
            if (msg) {
                const popupMessage = document.getElementById('popupMessage');
                popupMessage.style.display = 'block'; // Show the message
                setTimeout(() => {
                    popupMessage.style.opacity = 1; // Fade in
                }, 100); // Delay for fade in effect
                setTimeout(() => {
                    popupMessage.style.opacity = 0; // Fade out
                    setTimeout(() => {
                        popupMessage.style.display = 'none'; // Hide the message
                    }, 500); // Wait for fade-out to complete
                }, 4000); // Delay before fading out
            }
        }
    </script>
</body>
</html>
