package com.romeo.main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.romeo.main.dao.EmpDao;
import com.romeo.main.model.Employee;

/**
 * Controller class responsible for handling all the employee-related 
 * requests such as viewing, adding, editing, updating, and deleting employee 
 * data. It interacts with the EmpDao (Data Access Object) for CRUD operations
 * and uses Spring MVC annotations to map web requests to specific handler methods.
 */
@Controller
public class HomeController {

    // Dependency Injection: EmpDao is injected by Spring to perform database operations
    @Autowired
    private EmpDao empDao;

    /**
     * Handles the request for the home page.
     * @return The name of the view (home page) to be rendered.
     */
    @RequestMapping(path = "/home")
    public String home() {
        return "home"; // Returns the view name "home" to be rendered
    }

    /**
     * Handles the request for the dashboard page.
     * @return The name of the view (dashboard page) to be rendered.
     */
    @RequestMapping(path = "/dashboard")
    public String getDashboard() {
        return "Dashboard"; // Returns the view name "Dashboard" to be rendered
    }

    /**
     * Handles the request for the page where a new employee can be added.
     * @return The name of the view (add employee page) to be rendered.
     */
    @RequestMapping(path = "/addEmp")
    public String addEmp() {
        return "addemp"; // Returns the view name "addemp" to be rendered
    }

    /**
     * Handles the logout request. Redirects the user to the home page after logging out.
     * @return The redirection URL to the home page.
     */
    @RequestMapping(path = "/logOut")
    public String logOut() {
        return "redirect:home"; // Redirects to the home page after logout
    }

    /**
     * Handles the POST request for creating a new employee. 
     * It takes employee details from the form, saves the employee in the database,
     * and sets a message in the session to indicate success or failure.
     * @param employee The employee data submitted via the form.
     * @param session The HTTP session used to store messages for the user.
     * @return The redirection URL to the add employee page after processing the form.
     */
    @RequestMapping(path = "/addEmployee", method = RequestMethod.POST)
    public String createEmp(@ModelAttribute Employee employee, HttpSession session) {
        try {
            // Attempt to save the employee and get the result
            int result = empDao.saveEmp(employee);
            if (result > 0) {
                // If the employee is saved successfully, set a success message in the session
                session.setAttribute("msg", "Employee registered successfully.");
                session.setAttribute("msgType", "success");
            } else {
                // If the save operation failed, set a warning message in the session
                session.setAttribute("msg", "Failed to register employee. Please try again.");
                session.setAttribute("msgType", "warning");
            }
        } catch (Exception e) {
            // Catch any exception and set an error message in the session
            session.setAttribute("msg", "An error occurred while processing your request.");
            session.setAttribute("msgType", "warning");
            e.printStackTrace(); // Log the error (can be enhanced with proper logging)
        }
        return "redirect:/addEmp"; // Redirect to the 'addEmp' page after processing
    }

    /**
     * Handles the request to view the list of employees with pagination.
     * It retrieves a list of employees based on the requested page and page size,
     * and calculates the total number of pages required for pagination.
     * @param page The current page number (defaults to 1 if not provided).
     * @param size The number of employees to show per page (defaults to 10 if not provided).
     * @param model The model object used to pass data to the view.
     * @return The view name ("ViewEmp") to be rendered with the list of employees.
     */
    @RequestMapping(path = "/viewemp")
    public String viewEmployee(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int size,
            Model model) {
        // Retrieve the list of employees for the given page and page size
        List<Employee> employeesList = empDao.getEmployees(page, size);
        if (employeesList == null) {
            employeesList = List.of(); // Ensure that the list is never null
        }

        // Get the total number of employees for pagination calculation
        int totalEmp = empDao.getTotalEmployeeCount();
        int totalPages = (int) Math.ceil((double) totalEmp / size); // Calculate the total number of pages

        // Add the retrieved data to the model to be used in the view
        model.addAttribute("employeeList", employeesList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "ViewEmp"; // Return the view name "ViewEmp" to be rendered
    }

    /**
     * Handles the request to edit an employee's details by ID.
     * It retrieves the employee data based on the given ID and prepares it for editing.
     * @param id The ID of the employee to be edited.
     * @param model The model object used to pass the employee data to the view.
     * @return The view name ("EditEmp") to be rendered with the employee data for editing.
     */
    @RequestMapping(path = "/editEmp/{id}")
    public String editEmp(@PathVariable int id, Model model) {
        // Retrieve the employee details by ID
        Employee empById = empDao.getEmpById(id);
        model.addAttribute("employee", empById); // Add the employee to the model

        return "EditEmp"; // Return the view name "EditEmp" to be rendered
    }

    /**
     * Handles the request to update an employee's details. 
     * It takes the updated employee data from the form and saves it in the database.
     * A message is set in the session to indicate success or failure of the update operation.
     * @param employee The updated employee data submitted via the form.
     * @param session The HTTP session used to store messages for the user.
     * @return The view name ("EditEmp") after processing the update.
     */
    @RequestMapping(path = "/updateEmployee")
    public String updateEmp(@ModelAttribute Employee employee, HttpSession session) {
        try {
            // Attempt to update the employee and get the result
            int result = empDao.updateemp(employee);
            if (result > 0) {
                // If the update is successful, set a success message in the session
                session.setAttribute("msg", "Employee updated successfully!");
                session.setAttribute("msgType", "success");
            } else {
                // If the update fails, set a warning message in the session
                session.setAttribute("msg", "Failed to update employee.");
                session.setAttribute("msgType", "warning");
            }
        } catch (Exception e) {
            // Catch any exception and set an error message in the session
            session.setAttribute("msg", "An error occurred: " + e.getMessage());
            session.setAttribute("msgType", "warning");
        }
        return "EditEmp"; // Return the view name "EditEmp" to be rendered (could be redirected to avoid re-submission)
    }

    /**
     * Handles the request to delete an employee by ID. 
     * The employee is removed from the database and a success message is set in the session.
     * @param id The ID of the employee to be deleted.
     * @param session The HTTP session used to store messages for the user.
     * @return The redirection URL to the "viewemp" page after deletion.
     */
    @RequestMapping(path = "/deleteEmp/{id}")
    public String deleteEmp(@PathVariable int id, HttpSession session) {
        empDao.delete(id); // Perform the delete operation
        session.setAttribute("msg", "Deleted successfully"); // Set the success message in the session

        return "redirect:/viewemp"; // Redirect to the employee list page after deletion
    }

    /**
     * Handles the request to search for employees by a keyword.
     * It retrieves a list of employees whose names match the search keyword.
     * @param keyword The search keyword entered by the user.
     * @param model The model object used to pass the search results to the view.
     * @return The view name ("ViewEmp") with the search results.
     */
    @RequestMapping(path = "/search", method = RequestMethod.GET)
    public String searchEmployee(@RequestParam("keyword") String keyword, Model model) {
        // Retrieve the list of employees matching the search keyword
        List<Employee> searchResults = empDao.searchEmployees(keyword);
        model.addAttribute("employeeList", searchResults); // Add the search results to the model
        model.addAttribute("keyword", keyword); // Add the keyword to the model to display in the search bar
        return "ViewEmp"; // Return the view name "ViewEmp" to be rendered
    }
}
