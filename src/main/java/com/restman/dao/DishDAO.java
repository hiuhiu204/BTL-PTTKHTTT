package com.restman.dao;

import com.restman.model.Dish;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO phuc vu module 1: tim kiem thong tin mon an.
 */
public class DishDAO extends DAO {

    public DishDAO() {
        super();
    }

    /**
     * Tim cac mon an co TEN CHUA tu khoa.
     * Khong phan biet hoa/thuong nhung co phan biet dau (vi du "Ca" khong tim thay "Ca hoi").
     *
     * @param keyword tu khoa tim kiem
     * @return mang mon an (khong bao gio null; rong thi mang do dai 0)
     */
    public Dish[] searchDishByName(String keyword) {
        List<Dish> listDish = new ArrayList<>();

        String sql = "SELECT id, dishID, dishName, category, price, image, description "
                + "FROM tblDish "
                + "WHERE dishName COLLATE utf8mb4_0900_as_ci LIKE ? ESCAPE '!' "
                + "ORDER BY id";

        String pattern = "%" + escapeLike(keyword == null ? "" : keyword.trim()) + "%";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Dish dish = new Dish();
                    dish.setId(rs.getInt("id"));
                    dish.setDishID(rs.getString("dishID"));
                    dish.setDishName(rs.getString("dishName"));
                    dish.setCategory(rs.getString("category"));
                    dish.setPrice(rs.getFloat("price"));
                    dish.setImage(rs.getString("image"));
                    dish.setDescription(rs.getString("description"));
                    listDish.add(dish);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi truy van tim kiem mon an: " + e.getMessage(), e);
        }

        return listDish.toArray(new Dish[0]);
    }

    /**
     * Lay thong tin chi tiet cua 1 mon an theo khoa chinh "id".
     *
     * @param id khoa chinh cua mon an
     * @return mon an, hoac null neu khong tim thay
     */
    public Dish getDishDetail(int id) {
        String sql = "SELECT id, dishID, dishName, category, price, image, description "
                + "FROM tblDish "
                + "WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Dish dish = new Dish();
                    dish.setId(rs.getInt("id"));
                    dish.setDishID(rs.getString("dishID"));
                    dish.setDishName(rs.getString("dishName"));
                    dish.setCategory(rs.getString("category"));
                    dish.setPrice(rs.getFloat("price"));
                    dish.setImage(rs.getString("image"));
                    dish.setDescription(rs.getString("description"));
                    return dish;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi truy van chi tiet mon an: " + e.getMessage(), e);
        }

        return null;
    }

    /**
     * Escape cac ky tu dac biet cua LIKE ( %, _ ) bang dau ESCAPE '!'.
     */
    private String escapeLike(String value) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            if (c == '!' || c == '%' || c == '_') {
                sb.append('!');
            }
            sb.append(c);
        }
        return sb.toString();
    }
}
