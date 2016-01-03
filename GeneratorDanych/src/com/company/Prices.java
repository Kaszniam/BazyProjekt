package com.company;

import com.sun.istack.internal.NotNull;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;

/**
 * Created by czopo on 1/2/16.
 */
public class Prices {
    
    //FIELDS

//    private final static Random r = new Random();
//    private final static StringBuilder mainBuilder = new StringBuilder();
//    private final static StringBuilder builder = new StringBuilder();
//    private static float studentDisc = 0.5f;
//    private static float normalDisc = 0.3f;
//    private static float diff;
//    private static int MIN_PRICE = 50;
//    private static int MAX_PRICE = 300;
//    private static int daysBefore;
//    private static int pricePerSlot;
//    public static int currentDayId = 0;
//    public static Record [] tbl; 
//    
//    public static class Record {
//        private int daysBefore;
//        private int price;
//        private float disc;
//        private float studentDisc;
//
//        public int getPrice() {
//            return price;
//        }
//
//        public void setPrice(int price) {
//            this.price = price;
//        }
//
//        public Record(int daysBefore, int price, float disc, float studentDisc) {
//            this.daysBefore = daysBefore;
//            this.price = price;
//            this.disc = disc;
//            this.studentDisc = studentDisc;
//        }
//
//        public int getDaysBefore() {
//            return daysBefore;
//        }
//
//        public void setDaysBefore(int daysBefore) {
//            this.daysBefore = daysBefore;
//        }
//
//        public float getDisc() {
//            return disc;
//        }
//
//        public void setDisc(float disc) {
//            this.disc = disc;
//        }
//
//        public float getStudentDisc() {
//            return studentDisc;
//        }
//
//        public void setStudentDisc(float studentDisc) {
//            this.studentDisc = studentDisc;
//        }
//    }
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.pricesTbl = new Data.Record[3];
        Data.daysBefore = 15;
        Data.currentDayId++;
        Data.diff = 0.02f * (Data.r.nextInt(4) + 1);
        Data.pricePerSlot = generatePrice();
        int i = 0;
        while(Data.daysBefore > 0) {
            generatePrice(writer, i);
            Data.daysBefore -= 5;
            i++;
        }
        writer.newLine();
    }
    
    private static void generatePrice(BufferedWriter writer, int i) throws IOException {
        writer.newLine();
        Data.currentNormalDiscount = generateNormalDiscount(i);
        Data.currentStudentDiscount = generateStudentDiscount(i);
        Data.pricesTbl[i] = new Data.Record(Data.daysBefore, Data.pricePerSlot, Data.currentNormalDiscount, Data.currentStudentDiscount);
        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("      INSERT INTO Prices VALUES (");
        Data.mainBuilder.append(Data.currentDayId);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.daysBefore);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.currentNormalDiscount);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.currentStudentDiscount);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.pricePerSlot);
        Data.mainBuilder.append(")");
        
        writer.write(Data.mainBuilder.toString());
    }
    
    @NotNull
    private static float generateNormalDiscount(int i) {
        return Float.parseFloat(new DecimalFormat("#.##").format(Data.normalDisc - Data.diff*i).toString());        
    }

    @NotNull
    private static float generateStudentDiscount(int i) {
        return Float.parseFloat(new DecimalFormat("#.##").format(Data.studentDisc - Data.diff * i));
    }
    
    private static int generatePrice() {
        return Data.MIN_PRICE+Data.r.nextInt((Data.MAX_PRICE-Data.MIN_PRICE)/5)*5;
    }
}
