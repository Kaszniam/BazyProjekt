package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;

/**
 * Created by czopo on 1/2/16.
 */
public class Reservations {
//
//    private final static Random r = new Random();
//    private final static StringBuilder mainBuilder = new StringBuilder();
//    private final static StringBuilder builder = new StringBuilder();
//    private final static DateFormat formatwork = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//    private final static DateFormat formatconf = new SimpleDateFormat("yyyy-MM-dd");
//    private final static Calendar c = Calendar.getInstance();
//    private final static int MIN_RES_CONF = 5;
//    private final static int MAX_RES_CONF = 15;
//    private final static int MIN_ADULT_CONF = 2;
//    private final static int MAX_ADULT_CONF = 10;
//    private final static int MIN_STUDENT_CONF = 0;
//    private final static int MAX_STUDENT_CONF = 4;
//    private final static int MIN_DAYS_BEFORE = 20;
//    private final static int MAX_DAYS_BEFORE = 40;
//    private static int amountOfConfRes;
//    private static int confSlotsLeft;
//    private static int workSlotsLeft;
//    private static int confResSize;
//    private static int amountOfAdults;
//    private static int amountOfStudents;
//    private static int clientID;
//    private static int daysBefore;
//    private static List<Integer> listOfAdultsId = new LinkedList<>();
//    private static List<Integer> listOfStudentsId = new LinkedList<>();
//    public static String currentResDate="";
//    public static int currentResID = 0;
    
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.confSlotsLeft = Data.currentConfSlots;
        Data.workSlotsLeft = Data.currentSlotsWork;
        Data.amountOfConfRes = Data.MIN_RES_CONF + Data.r.nextInt(Data.MAX_RES_CONF - Data.MIN_RES_CONF);
        
        
        for(int i = 0; i < Data.amountOfConfRes; i++) {
            generateConfRes(writer);
        }
        writer.newLine();
    }
    
    
    private static void generateConfRes(BufferedWriter writer) throws IOException, ParseException {
        
        generateConfResSize();
        generateClientID();
        generateReservationDate();
        Data.confSlotsLeft -= Data.confResSize;
        if(Data.confSlotsLeft >= 0) {
            Data.currentResID++;
            writer.newLine();
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("      INSERT INTO ConfReservation VALUES (");
            Data.mainBuilder.append(Data.clientID);
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(Data.currentDayID);
            Data.mainBuilder.append(", '");
            Data.mainBuilder.append(Data.currentResDate);
            Data.mainBuilder.append("', ");
            Data.mainBuilder.append(Data.confResSize);
            Data.mainBuilder.append(", 0)");
            writer.write(Data.mainBuilder.toString());
        }
    }
    
    private static void generateConfResSize() {
        generateAdults();
        generateStudents();
        Data.confResSize = Data.amountOfStudents + Data.amountOfAdults;
    }
    
    private static void generateAdults(){ Data.amountOfAdults = Data.MIN_ADULT_CONF + Data.r.nextInt(Data.MAX_ADULT_CONF-Data.MIN_ADULT_CONF); }
    
    private static void generateStudents() { Data.amountOfStudents = Data.MIN_STUDENT_CONF + Data.r.nextInt(Data.MAX_STUDENT_CONF-Data.MIN_STUDENT_CONF);}

    private static void generateClientID() { Data.clientID = 1 + Data.r.nextInt(Data.AMOUNT_OF_CLIENTS); }

    private static void generateReservationDate() throws ParseException {
        generateDaysBefore();
        Data.c.setTime(Data.formatconf.parse(Data.currentDate));
        Data.c.add(Calendar.DATE, - Data.daysBeforeRes);
        Data.currentResDate = Data.formatconf.format(Data.c.getTime());
    }
    
    private static void generateDaysBefore() { Data.daysBeforeRes = Data.MIN_DAYS_BEFORE + Data.r.nextInt(Data.MAX_DAYS_BEFORE-Data.MIN_DAYS_BEFORE); }
    
}