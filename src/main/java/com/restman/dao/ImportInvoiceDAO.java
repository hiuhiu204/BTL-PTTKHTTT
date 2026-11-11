package com.restman.dao;

import com.restman.model.ImportInvoice;
import com.restman.model.Supplier;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DAO phuc vu module 2: lich su nhap hang cua mot nha cung cap.
 */
public class ImportInvoiceDAO extends DAO {

    public ImportInvoiceDAO() {
        super();
    }

    /**
     * Cac lan nhap cua mot nha cung cap trong khoang thoi gian da chon.
     * "totalAmount" duoc TINH tu tong quantity * unitPrice
     * (cot totalAmount da bi loai khoi CSDL theo thiet ke).
     *
     * @param supplier  nha cung cap (dung supplier.getId() lam tham so truy van)
     * @param startDate ngay dau ky (bat buoc khac null; JSP da kiem tra truoc khi goi)
     * @param endDate   ngay cuoi ky (bat buoc khac null; JSP da kiem tra truoc khi goi)
     * @return mang hoa don (khong bao gio null)
     */
    public ImportInvoice[] getInvoicesBySupplier(Supplier supplier, Date startDate, Date endDate) {
        List<ImportInvoice> listInvoice = new ArrayList<>();

        String sql = "SELECT i.id, i.invoiceID, i.createdDate, "
                + "COALESCE(SUM(d.quantity * d.unitPrice), 0) AS totalAmount "
                + "FROM tblImportInvoice i "
                + "LEFT JOIN tblImportDetail d ON d.tblImportInvoiceid = i.id "
                + "WHERE i.tblSupplierid = ? AND i.createdDate BETWEEN ? AND ? "
                + "GROUP BY i.id, i.invoiceID, i.createdDate "
                + "ORDER BY i.createdDate, i.id";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, supplier.getId());
            ps.setDate(2, startDate == null ? null : new java.sql.Date(startDate.getTime()));
            ps.setDate(3, endDate == null ? null : new java.sql.Date(endDate.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImportInvoice invoice = new ImportInvoice();
                    invoice.setId(rs.getInt("id"));
                    invoice.setInvoiceID(rs.getString("invoiceID"));
                    invoice.setCreatedDate(rs.getDate("createdDate"));
                    invoice.setTotalAmount(rs.getFloat("totalAmount"));
                    invoice.setSupplier(supplier);
                    listInvoice.add(invoice);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi truy van lich su nhap hang: " + e.getMessage(), e);
        }

        return listInvoice.toArray(new ImportInvoice[0]);
    }
}
