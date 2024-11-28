<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Custom Hover Effects */
        .card:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
            transition: all 0.3s ease;
        }
    </style>
</head>
<body class="bg-gray-50">
    <!-- Navbar -->
    <header class="bg-gray-800 text-white fixed top-0 left-0 w-full z-50 shadow-md">
        <div class="container mx-auto flex justify-between items-center py-4 px-6">
            <h1 class="text-xl font-bold">Employee Management System</h1>
            <nav>
                <ul class="flex space-x-6">
                    <li><a href="#home" class="hover:text-green-400">Home</a></li>
                    <li><a href="#features" class="hover:text-green-400">Features</a></li>
                    <li><a href="#about" class="hover:text-green-400">About</a></li>
                    <li><a href="#contact" class="hover:text-green-400">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section id="home" class="h-screen bg-gray-900 text-white flex items-center justify-center">
        <div class="text-center">
            <h2 class="text-5xl font-bold mb-4">Effortless Employee Management</h2>
            <p class="text-lg text-gray-300 mb-6">Simplify workforce management with cutting-edge tools and analytics.</p>
            <a href="dashboard" class="bg-green-500 hover:bg-green-400 text-white py-3 px-8 rounded-lg text-lg">Go to Dashboard</a>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-white">
        <div class="container mx-auto">
            <h3 class="text-4xl font-bold text-gray-800 text-center mb-12">Key Features</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Comprehensive Records</h4>
                    <p class="text-gray-600">Easily maintain employee details, including personal info, roles, and salaries.</p>
                </div>
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Performance Analytics</h4>
                    <p class="text-gray-600">Track and evaluate employee performance with real-time dashboards.</p>
                </div>
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Responsive Interface</h4>
                    <p class="text-gray-600">Access the system from any device, ensuring ease of use on the go.</p>
                </div>
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Secure Database</h4>
                    <p class="text-gray-600">Your data is protected with enterprise-grade security measures.</p>
                </div>
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Customizable Roles</h4>
                    <p class="text-gray-600">Assign permissions tailored to different roles in your organization.</p>
                </div>
                <div class="p-6 bg-gray-100 rounded-lg card">
                    <h4 class="text-xl font-semibold mb-4">Efficient Workflows</h4>
                    <p class="text-gray-600">Automate repetitive tasks to save time and focus on growth.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-20 bg-gray-900 text-white">
        <div class="container mx-auto text-center">
            <h3 class="text-4xl font-bold mb-8">About Our System</h3>
            <p class="text-lg leading-relaxed max-w-4xl mx-auto mb-8">
                Developed by a passionate team of software engineers, our Employee Management System is trusted by over 
                5,000 companies worldwide. Designed with usability and scalability in mind, it empowers HR teams to 
                streamline workflows and enhance productivity. 
            </p>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                    <h4 class="text-2xl font-bold">Our Mission</h4>
                    <p class="text-gray-300 mt-4">To simplify workforce management with innovative tools and user-friendly designs.</p>
                </div>
                <div>
                    <h4 class="text-2xl font-bold">Why Choose Us?</h4>
                    <p class="text-gray-300 mt-4">We combine cutting-edge technology with exceptional support to deliver unmatched value.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-20 bg-white">
        <div class="container mx-auto">
            <h3 class="text-4xl font-bold text-center text-gray-800 mb-8">Get in Touch</h3>
            <div class="text-center">
                <p class="text-gray-600 mb-4">Have questions or need help? We're here for you.</p>
                <a href="mailto:contact@ems.com" class="text-lg text-green-500 hover:underline">contact@ems.com</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-800 text-gray-400 py-6">
        <div class="container mx-auto text-center">
            <p>© 2024 Employee Management System. Designed with care by your dedicated developers.</p>
        </div>
    </footer>
</body>
</html>
