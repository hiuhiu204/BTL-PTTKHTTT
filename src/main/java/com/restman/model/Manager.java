package com.restman.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Nhan vien quan ly. Module 2 (thong ke nha cung cap theo luong nhap).
 * "dishes" va "combos" khoi tao rong, 2 module hien tai khong nap.
 */
public class Manager extends Employee {

    private int id;
    private List<Dish> dishes;
    private List<Combo> combos;

    public Manager() {
        this.dishes = new ArrayList<>();
        this.combos = new ArrayList<>();
    }

    public Manager(int id, List<Dish> dishes, List<Combo> combos) {
        this.id = id;
        this.dishes = dishes != null ? dishes : new ArrayList<>();
        this.combos = combos != null ? combos : new ArrayList<>();
    }

    public Manager(int id, String employeeID, String position, String username, String password,
                   String fullName, java.util.Date dateOfBirth, String address, String phoneNumber,
                   String email, List<Dish> dishes, List<Combo> combos) {
        super(username, password, fullName, dateOfBirth, address, phoneNumber, email, employeeID, position);
        this.id = id;
        this.dishes = dishes != null ? dishes : new ArrayList<>();
        this.combos = combos != null ? combos : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Dish> getDishes() {
        return dishes;
    }

    public void setDishes(List<Dish> dishes) {
        this.dishes = dishes;
    }

    public List<Combo> getCombos() {
        return combos;
    }

    public void setCombos(List<Combo> combos) {
        this.combos = combos;
    }
}
