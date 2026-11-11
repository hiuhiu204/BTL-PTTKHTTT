package com.restman.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Nha cung cap nguyen lieu cho nha hang.
 */
public class Supplier {

    private int id;
    private String supplierID;
    private String supplierName;
    private String address;
    private String phoneNumber;
    private String note;
    private List<ImportInvoice> importInvoices;

    public Supplier() {
        this.importInvoices = new ArrayList<>();
    }

    public Supplier(int id, String supplierID, String supplierName, String address,
                    String phoneNumber, String note) {
        this.id = id;
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.note = note;
        this.importInvoices = new ArrayList<>();
    }

    public Supplier(int id, String supplierID, String supplierName, String address,
                    String phoneNumber, String note, List<ImportInvoice> importInvoices) {
        this.id = id;
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.note = note;
        this.importInvoices = importInvoices != null ? importInvoices : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(String supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<ImportInvoice> getImportInvoices() {
        return importInvoices;
    }

    public void setImportInvoices(List<ImportInvoice> importInvoices) {
        this.importInvoices = importInvoices;
    }
}
