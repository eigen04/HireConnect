package com.entity;

import java.security.Timestamp;

public class Payment {
	private int paymentId;
    private int recruiterId;
    private double amount;
    private String paymentStatus;
    private Timestamp createdAt;

    public Payment() {}

    public Payment(int paymentId, int recruiterId, double amount, String paymentStatus, Timestamp createdAt) {
        this.paymentId = paymentId;
        this.recruiterId = recruiterId;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getRecruiterId() { return recruiterId; }
    public void setRecruiterId(int recruiterId) { this.recruiterId = recruiterId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Payment [paymentId=" + paymentId + ", amount=" + amount + ", status=" + paymentStatus + "]";
    }

}
