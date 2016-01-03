package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

/**
 * Created by czopo on 1/2/16.
 */
public class Days {

    //FIELDS

    private final static Random r = new Random();
    private final static StringBuilder mainBuilder = new StringBuilder();
    private final static StringBuilder builder = new StringBuilder();
    private final static DateFormat formatconf = new SimpleDateFormat("yyyy-MM-dd");
    private final static Calendar c = Calendar.getInstance();
    private static String dateToAdd;
    private static int currentDay = -1;
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        dateToAdd = Conferences.date;
        for(int i = 0; i <= Conferences.currentConfDays; i++) {
            generateDay(writer);
            Prices.generate(writer);
        }
        writer.newLine();
    }
    
    private static void generateDay(BufferedWriter writer) throws IOException, ParseException {
        currentDay++;
        writer.newLine();
        mainBuilder.delete(0, mainBuilder.length());
        mainBuilder.append("INSERT INTO ConfDays VALUES (" + Conferences.currentConfId + ", " + generateSlots() + 
                ", '" + dateToAdd + "')");

        writer.write(mainBuilder.toString());
        
        c.setTime(formatconf.parse(dateToAdd));
        c.add(Calendar.DATE, 1);
        dateToAdd = formatconf.format(c.getTime());

    }
    
    private static String generateSlots() {
        if(r.nextInt(4) != 0) {
            return Integer.toString(Conferences.currentSlots);
        }
        else {
            if(r.nextInt(2) != 0) {
                return Integer.toString(Conferences.currentSlots+10);
            }
            else {
                return Integer.toString(Conferences.currentSlots-10);
            }
        }
    }
}
