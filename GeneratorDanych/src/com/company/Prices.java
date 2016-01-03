package com.company;

import com.sun.istack.internal.NotNull;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Random;

/**
 * Created by czopo on 1/2/16.
 */
public class Prices {
    
    //FIELDS

    private final static Random r = new Random();
    private final static StringBuilder mainBuilder = new StringBuilder();
    private final static StringBuilder builder = new StringBuilder();
    private static float studentDisc = 0.5f;
    private static float normalDisc = 0.3f;
    private static float diff;
    private static int MIN_PRICE = 50;
    private static int MAX_PRICE = 300;
    private static int daysBefore;
    private static int pricePerSlot;
    public static int currentDayId = 0;
    
    public static void generate(BufferedWriter writer) throws IOException {
        daysBefore = 15;
        currentDayId++;
        diff = 0.02f * (r.nextInt(4) + 1);
        pricePerSlot = generatePrice();
        int i = 0;
        while(daysBefore > 0) {
            generatePrice(writer, i);
            daysBefore -= 5;
            i++;
        }
        writer.newLine();
    }
    
    private static void generatePrice(BufferedWriter writer, int i) throws IOException {
        writer.newLine();
        mainBuilder.delete(0, mainBuilder.length());
        mainBuilder.append("INSERT INTO Prices VALUES (" + currentDayId + ", " +
                daysBefore + ", " + generateDiscount(i) + ", " + generateStudentDiscount(i) + ", " 
                + pricePerSlot +")");
        
        writer.write(mainBuilder.toString());
    }
    
    @NotNull
    private static String generateDiscount(int i) {
        return new DecimalFormat("#.##").format(normalDisc - diff*i);        
    }

    @NotNull
    private static String generateStudentDiscount(int i) {
        return new DecimalFormat("#.##").format(studentDisc - diff * i);
    }
    
    private static int generatePrice() {
        return MIN_PRICE+r.nextInt((MAX_PRICE-MIN_PRICE)/5)*5;
    }
}
