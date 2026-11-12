package com.restman.dao;

import com.restman.model.StatSupplier;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DAO phuc vu module 2: thong ke nha cung cap theo tong luong nhap.
 */
public class StatSupplierDAO extends DAO {

    public StatSupplierDAO() {
        super();
    }

    /**
     * Tong luong nhap (SUM(quantity)) cua tung nha cung cap CO PHAT SINH NHAP
     * trong khoang [startDate, endDate] (bao gom ca hai dau mut).
     * Nha cung cap khong co lan nhap nao trong ky khong xuat hien (INNER JOIN).
     * Ket qua duoc sap xep theo tong luong nhap tu cao xuong thap; khi bang nhau
     * thi sap theo supplierID tang dan de thu tu o dinh.
     *
     * @param startDate ngay dau ky (bat buoc khac null; JSP da kiem tra truoc khi goi)
     * @param endDate   ngay cuoi ky (bat buoc khac null; JSP da kiem tra truoc khi goi)
     * @return mang thong ke (khong bao gio null)
     */
    public StatSupplier[] getSupplierStat(Date startDate, Date endDate) {
        List<StatSupplier> listStat = new ArrayList<>();

        String sql = "SELECT s.id, s.supplierID, s.supplierName, s.address, s.phoneNumber, s.note, "
                + "SUM(d.quantity) AS totalImportAmount "
                + "FROM tblSupplier s "
                + "JOIN tblImportInvoice i ON i.tblSupplierid = s.id "
                + "JOIN tblImportDetail  d ON d.tblImportInvoiceid = i.id "
                + "WHERE i.createdDate BETWEEN ? AND ? "
                + "GROUP BY s.id, s.supplierID, s.supplierName, s.address, s.phoneNumber, s.note "
                + "ORDER BY totalImportAmount DESC, s.supplierID";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate == null ? null : new java.sql.Date(startDate.getTime()));
            ps.setDate(2, endDate == null ? null : new java.sql.Date(endDate.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StatSupplier stat = new StatSupplier();
                    stat.setId(rs.getInt("id"));
                    stat.setSupplierID(rs.getString("supplierID"));
                    stat.setSupplierName(rs.getString("supplierName"));
                    stat.setAddress(rs.getString("address"));
                    stat.setPhoneNumber(rs.getString("phoneNumber"));
                    stat.setNote(rs.getString("note"));
                    stat.setTotalImportAmount(rs.getFloat("totalImportAmount"));
                    stat.setStartDate(startDate);
                    stat.setEndDate(endDate);
                    listStat.add(stat);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi truy van thong ke nha cung cap: " + e.getMessage(), e);
        }

        return listStat.toArray(new StatSupplier[0]);
    }
}
