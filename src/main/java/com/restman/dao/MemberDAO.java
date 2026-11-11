package com.restman.dao;

import com.restman.model.Customer;
import com.restman.model.Manager;
import com.restman.model.Member;
import com.restman.model.MembershipCard;
import com.restman.util.PasswordUtil;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * DAO phuc vu dang nhap / dang xuat (ho tro cho ca 2 module).
 */
public class MemberDAO extends DAO {

    public MemberDAO() {
        super();
    }

    /**
     * Dang nhap bang ten dang nhap va mat khau.
     * Mat khau duoc bam SHA-256 truoc khi so sanh voi cot "password" trong CSDL.
     * Vai tro duoc suy ra tu cot "role": CUSTOMER tra ve Customer, MANAGER tra ve Manager,
     * cac vai tro khac tra ve null (khong ho tro trong phien ban nay).
     *
     * @param username ten dang nhap
     * @param password mat khau (duoc bam truoc khi truy van)
     * @return doi tuong Member tuong ung vai tro, hoac null neu dang nhap that bai
     */
    public Member login(String username, String password) {
        if (username == null || password == null) {
            return null;
        }

        String hashedPassword = PasswordUtil.sha256Hex(password);

        String sql = "SELECT id, username, password, fullName, dateOfBirth, address, phoneNumber, email, role "
                + "FROM tblMember "
                + "WHERE username = ? AND password = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                String role = rs.getString("role");
                String fullName = rs.getString("fullName");
                Date dateOfBirth = rs.getDate("dateOfBirth");
                String address = rs.getString("address");
                String phoneNumber = rs.getString("phoneNumber");
                String email = rs.getString("email");

                if ("CUSTOMER".equals(role)) {
                    return loadCustomer(rs.getInt("id"), rs.getString("username"), hashedPassword,
                            fullName, dateOfBirth, address, phoneNumber, email);
                }
                if ("MANAGER".equals(role)) {
                    return loadManager(rs.getInt("id"), rs.getString("username"), hashedPassword,
                            fullName, dateOfBirth, address, phoneNumber, email);
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi dang nhap: " + e.getMessage(), e);
        }
    }

    /**
     * Nap thong tin khach hang kem the thanh vien (the thanh vien co the null).
     */
    private Customer loadCustomer(int memberId, String username, String password, String fullName,
                                  Date dateOfBirth, String address, String phoneNumber, String email) {
        String sql = "SELECT c.id AS cid, "
                + "k.id AS kid, k.cardID, k.tier, k.points "
                + "FROM tblCustomer c "
                + "LEFT JOIN tblMembershipCard k ON k.id = c.tblMembershipCardid "
                + "WHERE c.tblMemberid = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                MembershipCard membershipCard = null;
                int cardId = rs.getInt("kid");
                if (!rs.wasNull()) {
                    membershipCard = new MembershipCard();
                    membershipCard.setId(cardId);
                    membershipCard.setCardID(rs.getString("cardID"));
                    membershipCard.setTier(rs.getString("tier"));
                    membershipCard.setPoints(rs.getInt("points"));
                }

                Customer customer = new Customer();
                customer.setId(rs.getInt("cid"));
                customer.setUsername(username);
                customer.setPassword(password);
                customer.setFullName(fullName);
                customer.setDateOfBirth(dateOfBirth);
                customer.setAddress(address);
                customer.setPhoneNumber(phoneNumber);
                customer.setEmail(email);
                customer.setMembershipCard(membershipCard);
                return customer;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi tai thong tin khach hang: " + e.getMessage(), e);
        }
    }

    /**
     * Nap thong tin nhan vien quan ly.
     */
    private Manager loadManager(int memberId, String username, String password, String fullName,
                                Date dateOfBirth, String address, String phoneNumber, String email) {
        String sql = "SELECT id, employeeID, position "
                + "FROM tblManager "
                + "WHERE tblMemberid = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Manager manager = new Manager();
                manager.setId(rs.getInt("id"));
                manager.setEmployeeID(rs.getString("employeeID"));
                manager.setPosition(rs.getString("position"));
                manager.setUsername(username);
                manager.setPassword(password);
                manager.setFullName(fullName);
                manager.setDateOfBirth(dateOfBirth);
                manager.setAddress(address);
                manager.setPhoneNumber(phoneNumber);
                manager.setEmail(email);
                return manager;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Loi tai thong tin quan ly: " + e.getMessage(), e);
        }
    }
}
