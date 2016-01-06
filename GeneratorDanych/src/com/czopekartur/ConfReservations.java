package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.HashSet;

/**
 * Created by czopo on 1/2/16.
 */
public class ConfReservations {
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.confSlotsLeft = Data.currentConfSlots;
        Data.workSlotsLeft = Data.currentSlotsWork;
        Data.amountOfConfRes = Data.MIN_RES_CONF + Data.r.nextInt(Data.MAX_RES_CONF - Data.MIN_RES_CONF);


        Data.listOfAdultsOnThisConf = new HashSet<>();
        Data.listOfStudentsOnThisConf = new HashSet<>();
        
        
        for(int i = 0; i < Data.amountOfConfRes; i++) {
            generateConfRes(writer);
        }
        writer.newLine();
    }
    
    
    private static void generateConfRes(BufferedWriter writer) throws IOException, ParseException {
        
        generateConfResSize();
        generateReservationDate();
        Data.confSlotsLeft -= Data.confResSize;
        Data.listOfClients = new HashSet<>();
        
        do {
            Data.clientID = 1 + Data.r.nextInt(Data.AMOUNT_OF_CLIENTS);
        } while(Data.listOfClients.contains(Integer.valueOf(Data.clientID)));
        
        if(Data.confSlotsLeft >= 0) {
            Data.listOfClients.add(Data.clientID);
            Data.confResID++;
            writer.newLine();
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("      INSERT INTO ConfReservation VALUES (");
            Data.mainBuilder.append(Data.clientID);
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(Data.dayId);
            Data.mainBuilder.append(", '");
            Data.mainBuilder.append(Data.currentConfResDate);
            Data.mainBuilder.append("', ");
            Data.mainBuilder.append(Data.confResSize);
            Data.mainBuilder.append(", 0)");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();

            if(Data.r.nextInt(5) != 0) {
                Data.makeWorkshopRes = true;
                WorkReservations.generate(writer);
            } else {
                Data.makeWorkshopRes = false;
            }
            ResDetails.generate(writer);
            Payments.generate(writer);
            
            
        }
    }
    
    private static void generateConfResSize() {
        generateAdults();
        generateStudents();
        Data.confResSize = Data.amountOfStudents + Data.amountOfAdults;
    }
    
    private static void generateAdults(){ Data.amountOfAdults = Data.MIN_ADULT_CONF + Data.r.nextInt(Data.MAX_ADULT_CONF-Data.MIN_ADULT_CONF); }
    
    private static void generateStudents() { Data.amountOfStudents = Data.MIN_STUDENT_CONF + Data.r.nextInt(Data.MAX_STUDENT_CONF-Data.MIN_STUDENT_CONF);}
    
    private static void generateReservationDate() throws ParseException {
        generateDaysBefore();
        Data.c.setTime(Data.FORMAT_CONF.parse(Data.currentDate));
        Data.c.add(Calendar.DATE, - Data.daysBeforeRes);
        Data.currentConfResDate = Data.FORMAT_CONF.format(Data.c.getTime());
    }
    
    private static void generateDaysBefore() { Data.daysBeforeRes = Data.MIN_DAYS_BEFORE + Data.r.nextInt(Data.MAX_DAYS_BEFORE-Data.MIN_DAYS_BEFORE); }
    
}