package com.romeo.main.dao;

import java.util.List;

import com.romeo.main.model.Employee;

/**
 * Data Access Object (DAO) interface for managing Employee entities. 
 * The DAO pattern is used to separate the persistence logic from the business logic of the application.
 * This interface defines methods to perform CRUD (Create, Read, Update, Delete) operations 
 * on the Employee entity and interact with the underlying database or data source.
 * The methods in this interface are implemented by a concrete DAO class that interacts with the database.
 */
public interface EmpDao {

    /**
     * Saves a new employee in the database.
     * This method is responsible for persisting the employee details into the database.
     * 
     * @param employee The employee object containing details to be saved.
     * @return An integer representing the number of rows affected by the operation.
     *         Typically, 1 if the employee is saved successfully, 0 if the operation fails.
     */
    int saveEmp(Employee employee);

    /**
     * Retrieves an employee by their unique ID.
     * This method queries the database to fetch a specific employee's details based on their ID.
     * 
     * @param id The unique identifier of the employee.
     * @return The employee object with the specified ID, or null if no employee is found.
     */
    Employee getEmpById(int id);

    /**
     * Retrieves a list of all employees.
     * This method queries the database to get a list of all employees stored in the system.
     * 
     * @return A list of employee objects representing all employees in the database.
     */
    List<Employee> getEmployees();

    /**
     * Deletes an employee from the database based on their ID.
     * This method removes the employee record from the database.
     * 
     * @param id The unique identifier of the employee to be deleted.
     */
    void delete(int id);

    /**
     * Retrieves a paginated list of employees.
     * This method allows for retrieving a subset (page) of employees from the database, 
     * based on the specified page number and size.
     * It is useful for displaying employees in a paginated view, ensuring efficient memory usage 
     * when dealing with a large number of records.
     * 
     * @param page The page number to fetch (1-based index).
     * @param size The number of employees to display per page.
     * @return A list of employees that belongs to the specified page.
     */
    List<Employee> getEmployees(int page, int size);

    /**
     * Retrieves the total number of employees in the database.
     * This method is typically used in combination with pagination to calculate the total 
     * number of pages required for displaying employee data.
     * 
     * @return The total count of employees in the database.
     */
    int getTotalEmployeeCount();

    /**
     * Updates an existing employee's details in the database.
     * This method is responsible for modifying the details of an existing employee.
     * 
     * @param employee The employee object containing updated details.
     * @return An integer representing the number of rows affected by the update operation.
     *         Typically, 1 if the employee is updated successfully, 0 if the operation fails.
     */
    int updateemp(Employee employee);

    /**
     * Searches for employees by a specific keyword.
     * This method is used to perform a search operation in the employee database, 
     * typically for finding employees whose names or other fields match the search keyword.
     * 
     * @param keyword The search term used to find matching employees.
     * @return A list of employee objects whose fields match the search keyword.
     */
    List<Employee> searchEmployees(String keyword);
}
