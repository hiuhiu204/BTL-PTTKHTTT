package com.restman.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Khach hang cua nha hang. Module 1 (tim kiem thong tin mon an).
 */
public class Customer extends Member {

    private int id;
    private MembershipCard membershipCard;

    public Customer() {
    }

    public Customer(int id, MembershipCard membershipCard) {
        this.id = id;
        this.membershipCard = membershipCard;
    }

    public Customer(int id, String username, String password, String fullName, java.util.Date dateOfBirth,
                    String address, String phoneNumber, String email, MembershipCard membershipCard) {
        super(username, password, fullName, dateOfBirth, address, phoneNumber, email);
        this.id = id;
        this.membershipCard = membershipCard;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public MembershipCard getMembershipCard() {
        return membershipCard;
    }

    public void setMembershipCard(MembershipCard membershipCard) {
        this.membershipCard = membershipCard;
    }
}
