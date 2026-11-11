package com.restman.dao;

import com.restman.model.ImportDetail;
import com.restman.model.ImportInvoice;
import com.restman.model.Ingredient;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO phuc vu module 2: chi tiet hoa don nhap hang.
 */
public class ImportDetailDAO extends DAO {

    public ImportDetailDAO() {
        super();
    }

    /**
     * Cac dong chi tiet cua mot hoa don nhap hang, kem thong tin nguyen lieu tuong ung.
     * "importDetails" cua hoa don duoc nap o buoc sau boi ImportInvoiceDAO.
     *
     * @param invoice hoa don can xem chi tiet
     * @return mang chi tiet (khong bao gio null)
     */
    public ImportDetail[] getDetailsByInvoice(ImportInvoice invoice) {
        List<ImportDetail> listDetail = new ArrayList<>();

        String sql = "SELECT d.id, d.quantity, d.unitPrice, "
                + "g.id AS gid, g.ingredientID, g.ingredientName, g.unit "
                + "FROM tblImportDetail d "
                + "JOIN tblIngredient g ON g.id = d.tblIngredientid "
                + "WHERE d.tblImportInvoiceid = ? "
                + "ORDER BY d.id";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, invoice.getId());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ingredient ingredient = new Ingredient();
                    ingredient.setId(rs.getInt("gid"));
                    ingredient.setIngredientID(rs.getString("ingredientID"));
                    ingredient.setIngredientName(rs.getString("ingredientName"));
                    ingredient.setUnit(rs.getString("unit"));

                    ImportDetail detail = new ImportDetail();
                    detail.setId(rs.getInt("id"));
                    detail.setQuantity(rs.getFloat("quantity"));
                    detail.setUnitPrice(rs.getFloat("unitPrice"));
                    detail.setInvoice(invoice);
                    detail.setIngredient(ingredient);
                    listDetail.add(detail);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi truy van chi tiet hoa don: " + e.getMessage(), e);
        }

        return listDetail.toArray(new ImportDetail[0]);
    }
}
