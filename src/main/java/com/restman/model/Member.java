package com.restman.model;

import java.util.Date;

/**
 * Lop truong hop: thong tin tai khoan dung chung cho khach hang va nhan vien.
 * Khong co thuoc tinh "id" va khong co thuoc tinh "role"
 * (role chi ton tai trong bang tblMember, xem MemberDAO).
 */
public abstract class Member {

    private String username;
    private String password;
    private String fullName;
    private Date dateOfBirth;
    private String address;
    private String phoneNumber;
    private String email;

    public Member() {
    }

    public Member(String username, String password, String fullName, Date dateOfBirth,
                  String address, String phoneNumber, String email) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
