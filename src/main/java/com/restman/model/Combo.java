package com.restman.model;

/**
 * Combo (goi mon). Chi dung de "Manager.combos" hop le; khong co DAO.
 */
public class Combo {

    private int id;
    private String comboID;
    private String comboName;
    private float price;
    private String description;

    public Combo() {
    }

    public Combo(int id, String comboID, String comboName, float price, String description) {
        this.id = id;
        this.comboID = comboID;
        this.comboName = comboName;
        this.price = price;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComboID() {
        return comboID;
    }

    public void setComboID(String comboID) {
        this.comboID = comboID;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
