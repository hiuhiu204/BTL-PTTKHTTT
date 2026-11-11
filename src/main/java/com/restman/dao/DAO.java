package com.restman.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Lop co so cho tat ca DAO. Doc cau hinh ket noi tu db.properties (classpath),
 * mo ket toi MySQL qua JDBC va cung cap ket noi qua thuoc tinh "con".
 */
public class DAO implements AutoCloseable {

    protected Connection con;

    public DAO() {
        Properties props = new Properties();
        try (InputStream in = DAO.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (IOException e) {
            throw new RuntimeException("Khong doc duoc cau hinh db.properties: " + e.getMessage(), e);
        }

        String driver = props.getProperty("db.driver");
        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        if (driver == null || url == null) {
            throw new RuntimeException("Cau hinh db.properties khong hop le (thieu db.driver hoac db.url).");
        }

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Khong tim thay JDBC driver: " + e.getMessage(), e);
        } catch (SQLException e) {
            throw new RuntimeException("Khong ket noi duoc CSDL: " + e.getMessage(), e);
        }
    }

    /**
     * Dong ket noi. Loi SQLException duoc nuot de khong lam anh huong viec ket thuc trang.
     */
    @Override
    public void close() {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                // Bo qua loi khi dong ket noi.
            }
        }
    }
}
