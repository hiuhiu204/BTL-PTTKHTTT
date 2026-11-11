package com.restman.model;

/**
 * The thanh vien cua khach hang.
 */
public class MembershipCard {

    private int id;
    private String cardID;
    private String tier;
    private int points;

    public MembershipCard() {
    }

    public MembershipCard(int id, String cardID, String tier, int points) {
        this.id = id;
        this.cardID = cardID;
        this.tier = tier;
        this.points = points;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardID() {
        return cardID;
    }

    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    public String getTier() {
        return tier;
    }

    public void setTier(String tier) {
        this.tier = tier;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
