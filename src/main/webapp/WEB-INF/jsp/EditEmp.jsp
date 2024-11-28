<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Employee</title>
<base href="${pageContext.request.contextPath}/">
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Poppins', sans-serif;
}

/* Sidebar styles */
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

.sidebar.collapsed .submenu {
	display: none;
}

.sidebar.collapsed .menu-icon {
	margin-right: 0;
}

.submenu {
	display: none;
	padding-left: 1.5rem;
}

.submenu.open {
	display: block;
}

.main-content {
	transition: margin-left 0.3s ease-in-out;
	padding: 2rem;
}

.main-content.collapsed {
	margin-left: 64px;
}

/* Center content (form) */
.center-content {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	text-align: center;
}

.form-container {
	width: 100%;
	max-width: 600px;
	padding: 2rem;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Button style */
.btn-primary {
	background-color: #2D6A4F; /* Olive green */
	color: white;
	padding: 0.75rem 1.5rem;
	border-radius: 8px;
	text-transform: uppercase;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #1A4E36; /* Darker olive green */
}

/* Sidebar Icon */
.sidebar i {
	font-size: 1.5rem;
}

/* Success/Warning Message */
.message {
	background-color: #F3F4F6;
	padding: 1rem;
	border-radius: 8px;
	margin-bottom: 1rem;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	font-size: 1rem;
	color: #4B5563;
}

.message.success {
	background-color: #D1FAE5; /* Light green */
	border-left: 4px solid #10B981; /* Green border */
	color: #065F46; /* Dark green text */
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 5px;
}

.message.warning {
	background-color: #FEE2E2; /* Light red */
	border-left: 4px solid #F87171; /* Red border */
	color: #7F1D1D; /* Dark red text */
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 5px;
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
					href="${pageContext.request.contextPath}/dashboard"
					class="flex items-center"> <i
						class="fas fa-home menu-icon mr-4"></i> <span class="menu-text">Dashboard</span>
				</a></li>
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
						class="menu-text">Logout</span>
				</a></li>
			</ul>
		</nav>
	</div>

	<div class="main-content flex-grow p-6">
		<div class="max-w-3xl mx-auto bg-white p-8 rounded-lg shadow-lg">
			<h2 class="text-3xl font-bold text-center mb-8 text-gray-800">Edit
				Employee</h2>

			<!-- Display message if present -->
			<c:if test="${not empty msg}">
				<div id="messageBox"
					class="${msgType eq 'success' ? 'message success' : 'message warning'}">
					<p>${msg}</p>
				</div>
				<!-- Remove the message from session after it's displayed -->
				<c:remove var="msg" scope="session" />
				<c:remove var="msgType" scope="session" />
			</c:if>


			<!-- Edit Employee Form -->
			<form action="updateEmployee" method="POST" class="space-y-8">
				<input type="hidden" name="id" value="${employee.id}" />
				<!-- Full Name and Gender -->
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div class="form-group">
						<label for="fullname"
							class="block text-sm font-medium text-gray-600">Full Name</label>
						<input type="text" id="fullname" name="fullname"
							value="${employee.fullname}" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
					</div>
					<div class="form-group">
						<label for="gender"
							class="block text-sm font-medium text-gray-600">Gender</label> <select
							id="gender" name="gender" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
							<option value="">Select Gender</option>
							<option value="Male"
								${employee.gender == 'Male' ? 'selected' : ''}>Male</option>
							<option value="Female"
								${employee.gender == 'Female' ? 'selected' : ''}>Female</option>
							<option value="Other"
								${employee.gender == 'Other' ? 'selected' : ''}>Other</option>
						</select>
					</div>
				</div>

				<!-- Phone Number and Email -->
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div class="form-group">
						<label for="phoneNumber"
							class="block text-sm font-medium text-gray-600">Phone
							Number</label> <input type="tel" id="phoneNumber" name="phoneNumber"
							value="${employee.phoneNumber}" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
					</div>
					<div class="form-group">
						<label for="email" class="block text-sm font-medium text-gray-600">Email</label>
						<input type="email" id="email" name="email"
							value="${employee.email}" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
					</div>
				</div>

				<!-- Department and Position -->
				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
					<div class="form-group">
						<label for="department"
							class="block text-sm font-medium text-gray-600">Department</label>
						<select id="department" name="department" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
							<option value="">Select Department</option>
							<option value="HR"
								${employee.department == 'HR' ? 'selected' : ''}>HR</option>
							<option value="Finance"
								${employee.department == 'Finance' ? 'selected' : ''}>Finance</option>
							<option value="IT"
								${employee.department == 'IT' ? 'selected' : ''}>IT</option>
								<option value="Marketing"
								${employee.department == 'Marketing' ? 'selected' : ''}>Marketing</option>
						</select>
					</div>
					<div class="form-group">
						<label for="position"
							class="block text-sm font-medium text-gray-600">Position</label>
						<select id="position" name="position" required
							class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500">
							<option value="">Select Position</option>
							<option value="Manager"
								${employee.position == 'Manager' ? 'selected' : ''}>Manager</option>
							<option value="Team Lead"
								${employee.position == 'Team Lead' ? 'selected' : ''}>Team
								Lead</option>
							<option value="Staff"
								${employee.position == 'Staff' ? 'selected' : ''}>Staff</option>
						</select>
					</div>
				</div>
				<!-- Address Field -->
				<div class="form-group">
					<label for="address"
						class="block text-sm font-medium text-gray-600">Address</label>
					<textarea id="address" name="address" required
						class="mt-1 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
						rows="3">${employee.address}</textarea>
				</div>


				<!-- Buttons -->
				<div class="mt-8 flex justify-between">
					<a href="viewemp" class="btn-primary text-gray-700">Back</a>
					<button type="submit" class="btn-primary">Save Changes</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		document.getElementById('toggleSidebar').onclick = function() {
			document.querySelector('.sidebar').classList.toggle('collapsed');
			document.querySelector('.main-content').classList
					.toggle('collapsed');
		};

		function toggleSubmenu(id) {
			document.getElementById(id).classList.toggle('open');
		}
		 // Automatically hide the message box after 5 seconds
	    document.addEventListener("DOMContentLoaded", () => {
	        const messageBox = document.getElementById("messageBox");
	        if (messageBox) {
	            setTimeout(() => {
	                messageBox.style.transition = "opacity 0.5s";
	                messageBox.style.opacity = 0; // Gradual fade-out effect
	                setTimeout(() => {
	                    messageBox.style.display = "none"; // Completely hide the element
	                }, 500); // Wait for the fade-out to complete
	            }, 5000); // 5 seconds delay
	        }
	    });
	</script>

</body>
</html>
