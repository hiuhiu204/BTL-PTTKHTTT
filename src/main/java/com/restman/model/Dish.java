package com.restman.model;

/**
 * Mon an trong thuc don.
 */
public class Dish {

    private int id;
    private String dishID;
    private String dishName;
    private String category;
    private float price;
    private String description;
    private String image;

    public Dish() {
    }

    public Dish(int id, String dishID, String dishName, String category, float price,
                String description, String image) {
        this.id = id;
        this.dishID = dishID;
        this.dishName = dishName;
        this.category = category;
        this.price = price;
        this.description = description;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDishID() {
        return dishID;
    }

    public void setDishID(String dishID) {
        this.dishID = dishID;
    }

    public String getDishName() {
        return dishName;
    }

    public void setDishName(String dishName) {
        this.dishName = dishName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
