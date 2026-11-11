package com.restman.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Hoa don nhap hang tu nha cung cap.
 * "totalAmount" duoc TINH o DAO (cot nay da bi loai khoi CSDL).
 */
public class ImportInvoice {

    private int id;
    private String invoiceID;
    private Date createdDate;
    private float totalAmount;
    private Supplier supplier;
    private List<ImportDetail> importDetails;

    public ImportInvoice() {
        this.importDetails = new ArrayList<>();
    }

    public ImportInvoice(int id, String invoiceID, Date createdDate, float totalAmount,
                         Supplier supplier) {
        this.id = id;
        this.invoiceID = invoiceID;
        this.createdDate = createdDate;
        this.totalAmount = totalAmount;
        this.supplier = supplier;
        this.importDetails = new ArrayList<>();
    }

    public ImportInvoice(int id, String invoiceID, Date createdDate, float totalAmount,
                         Supplier supplier, List<ImportDetail> importDetails) {
        this.id = id;
        this.invoiceID = invoiceID;
        this.createdDate = createdDate;
        this.totalAmount = totalAmount;
        this.supplier = supplier;
        this.importInvoicesInit(importDetails);
    }

    private void importInvoicesInit(List<ImportDetail> importDetails) {
        this.importDetails = importDetails != null ? importDetails : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public List<ImportDetail> getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(List<ImportDetail> importDetails) {
        this.importDetails = importDetails;
    }
}
