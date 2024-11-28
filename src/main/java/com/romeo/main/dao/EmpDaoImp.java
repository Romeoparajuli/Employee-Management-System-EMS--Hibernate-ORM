package com.romeo.main.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.romeo.main.model.Employee;

/**
 * Implementation of the EmpDao interface. 
 * This class provides concrete methods for managing employee data using Hibernate.
 * The methods in this class interact with the database through HibernateTemplate, a Spring-provided helper 
 * class that simplifies the use of Hibernate ORM.
 * 
 * It includes CRUD operations for creating, reading, updating, and deleting Employee records, 
 * as well as pagination and search functionality.
 */
@Repository // Indicates that this class is a DAO component that interacts with the database
public class EmpDaoImp implements EmpDao {
    
    // Autowiring HibernateTemplate to handle all Hibernate operations
    @Autowired
    private HibernateTemplate hibernateTemplate;

    /**
     * Saves a new employee to the database.
     * 
     * This method uses HibernateTemplate's save method to persist the employee data. 
     * The save operation returns a generated identifier (ID) for the newly created employee.
     * The @Transactional annotation ensures that the method is wrapped in a transaction, 
     * making sure that if the operation fails, changes are rolled back.
     * 
     * @param employee The employee object containing the details to be saved.
     * @return The ID of the newly saved employee.
     */
    @Override
    @Transactional
    public int saveEmp(Employee employee) {
        int save = (int) hibernateTemplate.save(employee);  // Save the employee and return the generated ID
        return save;
    }

    /**
     * Retrieves an employee by their unique ID.
     * 
     * This method fetches the employee with the specified ID using HibernateTemplate's get method.
     * If no employee is found, it returns null.
     * 
     * @param id The unique identifier of the employee to be fetched.
     * @return The employee object with the given ID, or null if no employee is found.
     */
    @Override
    public Employee getEmpById(int id) {
        Employee employee = hibernateTemplate.get(Employee.class, id); // Retrieve employee by ID
        return employee;
    }

    /**
     * Retrieves a list of all employees from the database.
     * 
     * This method loads all employee records using HibernateTemplate's loadAll method, 
     * which returns a list of all employees in the database.
     * 
     * @return A list of all employees.
     */
    @Override
    public List<Employee> getEmployees() {
        List<Employee> all = hibernateTemplate.loadAll(Employee.class); // Retrieve all employees
        return all;
    }

    /**
     * Updates an existing employee's details in the database.
     * 
     * This method first fetches the existing employee using HibernateTemplate's get method. 
     * If the employee exists, it updates their fields with the new values provided in the input `employee` object, 
     * and then uses HibernateTemplate's update method to save the changes to the database.
     * 
     * @param employee The employee object containing updated details.
     * @return 1 if the update was successful, or 0 if the employee was not found.
     */
    @Override
    @Transactional
    public int updateemp(Employee employee) {
        Employee existingEmployee = hibernateTemplate.get(Employee.class, employee.getId()); // Retrieve the existing employee by ID
        if (existingEmployee != null) {
            // Update the fields from the new employee object
            existingEmployee.setFullname(employee.getFullname());
            existingEmployee.setGender(employee.getGender());
            existingEmployee.setPhoneNumber(employee.getPhoneNumber());
            existingEmployee.setEmail(employee.getEmail());
            existingEmployee.setDepartment(employee.getDepartment());
            existingEmployee.setPosition(employee.getPosition());
            existingEmployee.setAddress(employee.getAddress());

            hibernateTemplate.update(existingEmployee); // Update the employee record in the database
            return 1; // Indicating the update was successful
        }
        return 0; // Indicating the employee was not found for update
    }

    /**
     * Deletes an employee from the database based on their unique ID.
     * 
     * This method fetches the employee by ID and uses HibernateTemplate's delete method to remove the employee record 
     * from the database. The @Transactional annotation ensures that the operation is performed within a transaction.
     * 
     * @param id The unique identifier of the employee to be deleted.
     */
    @Override
    @Transactional
    public void delete(int id) {
        Employee employee = hibernateTemplate.get(Employee.class, id); // Retrieve the employee by ID
        hibernateTemplate.delete(employee); // Delete the employee from the database
    }

    /**
     * Retrieves a paginated list of employees.
     * 
     * This method uses Hibernate's session API to execute a custom query that retrieves a subset of employees 
     * based on the specified page number and size. It sets the offset and limit for the query 
     * based on the pagination parameters, ensuring that only the requested page of results is returned.
     * 
     * @param page The page number to retrieve (1-based index).
     * @param size The number of employees to retrieve per page.
     * @return A list of employees for the specified page.
     */
    @Override
    @Transactional
    public List<Employee> getEmployees(int page, int size) {
        return hibernateTemplate.execute(session -> {
            return session.createQuery("from Employee", Employee.class)
                    .setFirstResult((page - 1) * size) // Offset for pagination
                    .setMaxResults(size) // Limit for pagination
                    .list();
        });
    }

    /**
     * Retrieves the total count of employees in the database.
     * 
     * This method executes a Hibernate query to count the total number of employees in the database.
     * The result is returned as a Long object, which is then converted to an int.
     * This is useful for pagination, where knowing the total number of records helps in calculating 
     * the total number of pages.
     * 
     * @return The total count of employees in the database.
     */
    @Override
    public int getTotalEmployeeCount() {
        return hibernateTemplate.execute(session -> {
            return ((Long) session.createQuery("select count(e) from Employee e")
                    .uniqueResult()) // Count the total number of employees
                    .intValue(); // Convert the result to an integer
        });
    }

    /**
     * Searches for employees based on a keyword.
     * 
     * This method searches for employees whose fields (name, email, department, etc.) contain the specified keyword. 
     * The keyword is used in a `LIKE` query to match any employee whose attributes contain the search term. 
     * The method returns a list of matching employees.
     * 
     * @param keyword The search keyword to find matching employees.
     * @return A list of employees whose fields match the keyword.
     */
    @Override
    @Transactional
    public List<Employee> searchEmployees(String keyword) {
        return hibernateTemplate.execute(session -> {
            // Query to search for employees where the keyword matches any of the fields
            String query = "from Employee e where e.fullname like :keyword or e.email like :keyword or e.department like :keyword";
            return session.createQuery(query, Employee.class)
                          .setParameter("keyword", "%" + keyword + "%") // Apply the keyword with wildcards
                          .list(); // Return the list of employees matching the search term
        });
    }
}
