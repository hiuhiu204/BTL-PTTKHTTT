package com.restman.model;

/**
 * Chi tiet mot dong trong hoa don nhap hang.
 * Thanh tien = quantity * unitPrice (tinh o JSP, khong them thuoc tinh vao entity).
 */
public class ImportDetail {

    private int id;
    private float quantity;
    private float unitPrice;
    private ImportInvoice invoice;
    private Ingredient ingredient;

    public ImportDetail() {
    }

    public ImportDetail(int id, float quantity, float unitPrice,
                        ImportInvoice invoice, Ingredient ingredient) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.invoice = invoice;
        this.ingredient = ingredient;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public ImportInvoice getInvoice() {
        return invoice;
    }

    public void setInvoice(ImportInvoice invoice) {
        this.invoice = invoice;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }
}
