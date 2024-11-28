<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
        rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .sidebar {
            transition: all 0.3s ease-in-out;
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
        }

        .main-content.collapsed {
            margin-left: 64px;
        }

        .center-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
    </style>
</head>
<body class="bg-gray-100">

    <!-- Sidebar -->
    <div class="flex">
        <aside id="sidebar"
            class="sidebar bg-gray-800 text-white w-64 min-h-screen transition-all">
            <div class="flex items-center justify-between px-6 py-4">
                <h1 class="text-lg font-semibold menu-text">Dashboard</h1>
                <button id="toggleSidebar" class="text-white">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
            <nav>
                <ul>
                    <li class="px-6 py-3 hover:bg-gray-700 flex items-center"><i
                        class="fas fa-home menu-icon mr-4"></i> <span class="menu-text">Dashboard</span>
                    </li>
                    <li
                        class="px-6 py-3 hover:bg-gray-700 flex items-center cursor-pointer"
                        onclick="toggleSubmenu('employeeSubmenu')"><i
                        class="fas fa-user-tie menu-icon mr-4"></i> <span
                        class="menu-text">Employee</span> <i
                        class="fas fa-chevron-down ml-auto"></i></li>
                    <ul id="employeeSubmenu" class="submenu">
                       	<li class="px-6 py-2 hover:bg-gray-600"><a href="addEmp"
						class="flex items-center"> <i class="fas fa-plus-circle mr-4"></i>Add
							Employee
					</a></li>
					<li class="px-6 py-2 hover:bg-gray-600"><a href="viewemp"
						class="flex items-center"> <i class="fas fa-eye mr-4"></i>
							View Employee
					</a></li>
                    </ul>
                    <li class="px-6 py-3 hover:bg-gray-700 flex items-center"><i
                        class="fas fa-sign-out-alt menu-icon mr-4"></i> <span
                        class="menu-text"><a href="logOut">Logout</a></span></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main id="mainContent" class="main-content flex-grow">
            <div class="center-content">
                <h1 class="text-4xl font-bold text-gray-800 mb-4">Welcome to Employee Management System</h1>
                <p class="text-gray-600 text-lg">Developed by Parajuli Technology Ltd</p>
            </div>
        </main>
    </div>

    <!-- JavaScript for Sidebar -->
    <script>
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleSidebar = document.getElementById('toggleSidebar');

        toggleSidebar.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('collapsed');
        });

        function toggleSubmenu(id) {
            const submenu = document.getElementById(id);
            submenu.classList.toggle('open');
        }
    </script>
</body>
</html>
