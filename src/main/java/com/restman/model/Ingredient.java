package com.restman.model;

import java.util.Date;

/**
 * Nguyen lieu duoc nhap ve tu nha cung cap.
 */
public class Ingredient {

    private int id;
    private String ingredientID;
    private String ingredientName;
    private float stockQuantity;
    private String unit;
    private Date expiryDate;

    public Ingredient() {
    }

    public Ingredient(int id, String ingredientID, String ingredientName,
                      float stockQuantity, String unit, Date expiryDate) {
        this.id = id;
        this.ingredientID = ingredientID;
        this.ingredientName = ingredientName;
        this.stockQuantity = stockQuantity;
        this.unit = unit;
        this.expiryDate = expiryDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(String ingredientID) {
        this.ingredientID = ingredientID;
    }

    public String getIngredientName() {
        return ingredientName;
    }

    public void setIngredientName(String ingredientName) {
        this.ingredientName = ingredientName;
    }

    public float getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(float stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}
