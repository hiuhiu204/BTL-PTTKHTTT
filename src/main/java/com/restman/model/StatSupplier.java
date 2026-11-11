package com.restman.model;

import java.util.Date;

/**
 * Ket qua thong ke mot nha cung cap trong mot khoang thoi gian.
 * Ke thua Supplier: doi tuong duoc chon trong "listStat" chinh la mot Supplier.
 * "totalImportAmount" la TONG LUONG NHAP (SUM(quantity)), khong phai tien.
 */
public class StatSupplier extends Supplier {

    private float totalImportAmount;
    private Date startDate;
    private Date endDate;

    public StatSupplier() {
        super();
    }

    public StatSupplier(int id, String supplierID, String supplierName, String address,
                        String phoneNumber, String note, float totalImportAmount,
                        Date startDate, Date endDate) {
        super(id, supplierID, supplierName, address, phoneNumber, note);
        this.totalImportAmount = totalImportAmount;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public float getTotalImportAmount() {
        return totalImportAmount;
    }

    public void setTotalImportAmount(float totalImportAmount) {
        this.totalImportAmount = totalImportAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
