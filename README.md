

# Employee Management System (EMS)-Hibernate ORM

## Overview

The **Employee Management System (EMS)** is a scalable and extensible web application designed for managing employee records in an organization. Built using **Spring MVC** and **Hibernate ORM**, this application enables CRUD (Create, Read, Update, Delete) operations on employee data. It is designed with clean, modular architecture and follows industry best practices for web applications.

While the system currently does not feature user authentication or authorization, it provides a simple, effective interface for managing employee information.

### Key Features

- **CRUD Operations**: Full CRUD support for employee records, including employee personal details, job information, and more.
- **Intuitive User Interface**: Simple and intuitive JSP-based front-end with responsive design.
- **Data Persistence**: Uses Hibernate ORM for seamless database interaction and MySQL as the relational database.
- **Modular Architecture**: Separated layers for controller, service, and data access for maintainability and scalability.
- **Extensibility**: Easy to extend with additional features such as authentication, role-based access control, and reporting.

---

## Tech Stack

- **Backend**: 
  - **Java** with **Spring MVC** for web framework
  - **Hibernate ORM** for Object-Relational Mapping (ORM)
  - **MySQL** for database management
  - **JSP** and **JSTL** for view rendering and templating
  - **Apache Maven** for dependency management and build automation
- **Frontend**:
  - **HTML5** and **CSS3** for structure and styling
  - **JSP** (Java Server Pages) for rendering views
- **Development Tools**:
  - **Eclipse IDE** for Java development
  - **Git** for version control
  - **Postman** for API testing (if applicable)

---

## Features

- **Home Page**: Landing page with system description and a navigation button to the dashboard.
- **Sidebar Menu**:
  - **Dashboard**: Overview of the system.
  - **Employee Management**:
    - **Add Employee**: Form to add new employee records.
    - **View Employees**: Displays all employee records in a list format.
  - **Logout**: Placeholder for logout functionality (not yet implemented).

---

## Project Setup and Installation

### Prerequisites

Before running the EMS application, ensure you have the following installed:

- **Java 8 or higher**
- **Maven** (for dependency management)
- **MySQL** (for database management)
- **Apache Tomcat** or any other servlet container (for deploying the WAR file)

### Step 1: Clone the Repository

Clone the repository from GitHub:

```bash
git clone https://github.com/yourusername/EmployeeManagment.git
cd EmployeeManagment
```

### Step 2: Database Configuration

1. **Create MySQL Database**:

   Log into MySQL:

   ```bash
   mysql -u root -p
   ```

   Then, create the database for the application:

   ```sql
   CREATE DATABASE employee_management;
   ```

2. **Configure DataSource in Spring**:

   In `src/main/webapp/WEB-INF/spring-servlet.xml`, configure the `DataSource` and Hibernate session factory:

   ```xml
   <bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource">
       <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
       <property name="url" value="jdbc:mysql://localhost:3306/employee_management"/>
       <property name="username" value="root"/>
       <property name="password" value="password"/>
   </bean>

   <bean id="sessionFactory" class="org.springframework.orm.hibernate5.LocalSessionFactoryBean">
       <property name="dataSource" ref="dataSource"/>
       <property name="packagesToScan" value="com.romeo.main.model"/>
       <property name="hibernateProperties">
           <props>
               <prop key="hibernate.dialect">org.hibernate.dialect.MySQL5Dialect</prop>
               <prop key="hibernate.hbm2ddl.auto">update</prop>
               <prop key="hibernate.show_sql">true</prop>
           </props>
       </property>
   </bean>
   ```

3. **Configure Hibernate for Employee Model**:

   Ensure that your `Employee.java` is mapped as an entity class in Hibernate, with appropriate annotations.

   ```java
   @Entity
   @Table(name = "employee")
   public class Employee {
       @Id
       @GeneratedValue(strategy = GenerationType.IDENTITY)
       @Column(name = "id")
       private int id;

       @Column(name = "name")
       private String name;

       @Column(name = "job_title")
       private String jobTitle;

       @Column(name = "salary")
       private double salary;

       // Getters and Setters
   }
   ```

### Step 3: Build and Run

1. **Install Dependencies**:

   Run the following Maven command to install dependencies:

   ```bash
   mvn clean install
   ```

2. **Build the WAR File**:

   To build the WAR (Web Application Archive) file for deployment:

   ```bash
   mvn clean package
   ```

3. **Deploy the WAR File**:

   Deploy the generated `target/EmployeeManagment.war` file to a servlet container like Apache Tomcat.

4. **Access the Application**:

   Once the server is up and running, navigate to:

   ```
   http://localhost:8080/EmployeeManagment
   ```

---

## Project Structure

```
EmployeeManagment/
├── pom.xml                         # Maven build file with dependencies
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── com/
│   │   │   │   ├── romeo/
│   │   │   │   │   ├── main/
│   │   │   │   │   │   ├── controller/      # Controllers for handling HTTP requests
│   │   │   │   │   │   ├── dao/             # Data Access Objects for database interaction
│   │   │   │   │   │   ├── model/           # Hibernate entity classes (Employee.java)
│   │   │   │   │   │   └── service/         # Service layer with business logic
│   │   ├── resources/
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           ├── jsp/                    # JSP files for front-end views
│   │           ├── spring-servlet.xml      # Spring MVC configuration
│   │           ├── web.xml                # Web application deployment descriptor
│   └── test/
├── README.md                        # Project documentation
└── LICENSE                          # License file (MIT, Apache, etc.)
```

---

## How It Works

### 1. **Home Page**

The **Home Page** introduces the system and allows users to navigate to the **Dashboard** page via a button. The home page layout includes:

- **Header**: Brief description of the system.
- **Navigation Button**: A button that directs users to the dashboard.

### 2. **Sidebar Menu**

The sidebar menu includes the following options:

- **Dashboard**: Provides an overview of the system's data (currently basic).
- **Employee**:
  - **Add Employee**: Displays a form to input new employee details.
  - **View Employees**: Lists all employees stored in the system.
- **Logout**: Placeholder for logout functionality.

### 3. **Employee Management**

- **Add Employee**: Users can input employee details such as name, job title, salary, etc., and submit the form to add an employee to the database.
- **View Employees**: Displays a list of all employees stored in the system, with the option to update or delete records.

---

## Testing

You can run unit tests to ensure that everything is working properly:

```bash
mvn test
```

---

## Future Enhancements

This project serves as a basic framework for employee management. In the future, the following features can be added:

- **Authentication & Authorization**: Implement user roles (Admin, Employee) with login functionality.
- **Reporting**: Add functionality to generate employee reports (e.g., salary reports).
- **Search Functionality**: Implement search functionality for employees.
- **Data Validation**: Add server-side and client-side validation for forms.
- **RESTful APIs**: Expose REST APIs for mobile app integration.

---

##ui
![image](https://github.com/user-attachments/assets/cec4216f-d70f-4420-aefc-72e70cbf4093)

## Acknowledgements

- **Spring Framework**: The core web framework used to build the application.
- **Hibernate ORM**: Used for database interaction through object-relational mapping.
- **MySQL**: The database used to store employee data.
- **Apache Maven**: The dependency management and build automation tool used.

---


