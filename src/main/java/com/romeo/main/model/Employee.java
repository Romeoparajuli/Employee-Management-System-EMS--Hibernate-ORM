package com.romeo.main.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * The Employee class represents an employee entity in the system.
 * This class is mapped to the 'employees' table in the database.
 * It contains fields that correspond to the columns of the 'employees' table.
 * The class uses JPA (Java Persistence API) annotations to define the entity and its mappings.
 * This is a POJO (Plain Old Java Object) used for data encapsulation.
 */
@Entity
@Table(name = "employees")  // Specifies the table name in the database
public class Employee {

    /**
     * The primary key of the employee entity.
     * It is annotated with @Id to indicate that this field will be the unique identifier in the database.
     * @GeneratedValue with strategy GenerationType.IDENTITY indicates that the database will handle the ID generation.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
    private int id;

    // Employee personal information
    private String fullname;  // The full name of the employee
    private String gender;    // The gender of the employee
    private String email;     // The email address of the employee
    private String address;   // The residential address of the employee
    private String department; // The department the employee works in
    private String position;   // The job position of the employee
    private long phoneNumber;  // The phone number of the employee (long to handle large numbers)

    /**
     * Default constructor. Used by JPA for entity instantiation.
     * The constructor does not take any parameters as it is expected to be called by the persistence context.
     */
    public Employee() {
        // Default constructor is needed for JPA entity instantiation
    }

    // Getters and Setters

    /**
     * Getter for employee ID
     * @return the ID of the employee
     */
    public int getId() {
        return id;
    }

    /**
     * Setter for employee ID
     * @param id the ID of the employee
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Getter for the full name of the employee
     * @return the full name of the employee
     */
    public String getFullname() {
        return fullname;
    }

    /**
     * Setter for the full name of the employee
     * @param fullname the full name of the employee
     */
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    /**
     * Getter for the gender of the employee
     * @return the gender of the employee
     */
    public String getGender() {
        return gender;
    }

    /**
     * Setter for the gender of the employee
     * @param gender the gender of the employee
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * Getter for the email address of the employee
     * @return the email address of the employee
     */
    public String getEmail() {
        return email;
    }

    /**
     * Setter for the email address of the employee
     * @param email the email address of the employee
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Getter for the address of the employee
     * @return the address of the employee
     */
    public String getAddress() {
        return address;
    }

    /**
     * Setter for the address of the employee
     * @param address the address of the employee
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * Getter for the department of the employee
     * @return the department of the employee
     */
    public String getDepartment() {
        return department;
    }

    /**
     * Setter for the department of the employee
     * @param department the department of the employee
     */
    public void setDepartment(String department) {
        this.department = department;
    }

    /**
     * Getter for the position of the employee
     * @return the position of the employee
     */
    public String getPosition() {
        return position;
    }

    /**
     * Setter for the position of the employee
     * @param position the position of the employee
     */
    public void setPosition(String position) {
        this.position = position;
    }

    /**
     * Getter for the phone number of the employee
     * @return the phone number of the employee
     */
    public long getPhoneNumber() {
        return phoneNumber;
    }

    /**
     * Setter for the phone number of the employee
     * @param phoneNumber the phone number of the employee
     */
    public void setPhoneNumber(long phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /**
     * Overrides the toString() method to provide a string representation of the employee.
     * Useful for debugging and logging purposes.
     * @return a string representation of the employee object
     */
    @Override
    public String toString() {
        // This method returns a string with all employee details, formatted as a string.
        return "Employee [id=" + id + ", fullname=" + fullname + ", gender=" + gender + ", email=" + email
            + ", address=" + address + ", department=" + department + ", position=" + position + ", phoneNumber=" + phoneNumber + "]";
    }
}
