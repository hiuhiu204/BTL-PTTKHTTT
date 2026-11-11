package com.restman.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Tien ich bam mat khau SHA-256 (hex lowercase).
 * Mat khau trong CSDL duoc luu dang SHA-256 hex 64 ky tu.
 */
public final class PasswordUtil {

    private PasswordUtil() {
    }

    /**
     * Bam chuoi mat khau thanh chuoi hex 64 ky tu cua SHA-256.
     */
    public static String sha256Hex(String password) {
        if (password == null) {
            throw new IllegalArgumentException("Mat khau khong duoc rong.");
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(hash.length * 2);
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    sb.append('0');
                }
                sb.append(hex);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Khong ho tro thuat toan SHA-256: " + e.getMessage(), e);
        }
    }
}
