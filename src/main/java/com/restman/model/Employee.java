package com.restman.model;

/**
 * Lop truong hop: thong tin chung cho cac loai nhan vien.
 * Khong co thuoc tinh "id" (khoa chinh nam o bang con tuong ung).
 */
public abstract class Employee extends Member {

    private String employeeID;
    private String position;

    public Employee() {
    }

    public Employee(String employeeID, String position) {
        this.employeeID = employeeID;
        this.position = position;
    }

    public Employee(String username, String password, String fullName, java.util.Date dateOfBirth,
                    String address, String phoneNumber, String email,
                    String employeeID, String position) {
        super(username, password, fullName, dateOfBirth, address, phoneNumber, email);
        this.employeeID = employeeID;
        this.position = position;
    }

    public String getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(String employeeID) {
        this.employeeID = employeeID;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
