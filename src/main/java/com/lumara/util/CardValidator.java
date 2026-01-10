package com.lumara.util;

import java.time.YearMonth;
import java.util.regex.Pattern;

public class CardValidator {

    private static final Pattern DIGITS_ONLY = Pattern.compile("\\d+");
    private static final Pattern EXPIRY_FORMAT = Pattern.compile("\\d{2}/\\d{2}");

    public static String validate(String cardNumber, String expiryDate, String cvv) {

        if (cardNumber == null || expiryDate == null || cvv == null) {
            return "All card fields are required";
        }

        // ---- CARD NUMBER ----
        cardNumber = cardNumber.replaceAll("\\s+", "");

        if (!DIGITS_ONLY.matcher(cardNumber).matches()) {
            return "Card number must contain only digits";
        }

        if (cardNumber.length() < 12) {
            return "Card number is too short";
        }

        // ---- EXPIRY DATE ----
        if (!EXPIRY_FORMAT.matcher(expiryDate).matches()) {
            return "Expiry date must be in MM/YY format";
        }

        int expiryMonth = Integer.parseInt(expiryDate.substring(0, 2));
        int expiryYear = Integer.parseInt("20" + expiryDate.substring(3, 5));

        if (expiryMonth < 1 || expiryMonth > 12) {
            return "Invalid expiry month";
        }

        java.time.YearMonth now = java.time.YearMonth.now();
        java.time.YearMonth expiry = java.time.YearMonth.of(expiryYear, expiryMonth);

        // ❗ EXACT LOGIC YOU ASKED FOR
        if (expiryYear < now.getYear()) {
            return "Card has expired";
        }

        if (expiryYear == now.getYear() && expiryMonth < now.getMonthValue()) {
            return "Card has expired";
        }

        // ---- CVV ----
        if (!DIGITS_ONLY.matcher(cvv).matches()) {
            return "CVV must contain only digits";
        }

        if (cvv.length() < 3 || cvv.length() > 4) {
            return "Invalid CVV length";
        }

        return null; // ✅ VALID
    }
}
