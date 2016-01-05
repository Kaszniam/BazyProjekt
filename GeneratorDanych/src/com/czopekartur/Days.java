package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.LinkedList;

/**
 * Created by czopo on 1/2/16.
 */
public class Days {
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.currentDate = Data.startConfDate;
        Data.workshopsIDs = new LinkedList<Integer>();
        for(int i = 0; i <= Data.currentConfDays; i++) {
            generateDay(writer);
            Prices.generate(writer);
            Workshops.generate(writer);
            ConfReservations.generate(writer);
            updateDate();
        }
        writer.newLine();
    }
    
    private static void generateDay(BufferedWriter writer) throws IOException, ParseException {
        Data.dayId++;
        writer.newLine();
        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("   INSERT INTO ConfDays VALUES (");
        Data.mainBuilder.append(Data.conferenceId);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(generateSlots());
        Data.mainBuilder.append(", '");
        Data.mainBuilder.append(Data.currentDate);
        Data.mainBuilder.append("')");

        writer.write(Data.mainBuilder.toString());
        writer.newLine();
        
    }
    
    private static String generateSlots() {
        if(Data.r.nextInt(4) != 0) { }
        else {
            if(Data.r.nextInt(2) != 0) {
                Data.currentConfSlots += 10;
            }
            else {
                Data.currentConfSlots -= 10;
            }
        }
        return Integer.toString(Data.currentConfSlots);
    }
    
    private static void updateDate() throws ParseException {
        Data.c.setTime(Data.FORMAT_CONF.parse(Data.currentDate));
        Data.c.add(Calendar.DATE, 1);
        Data.currentDate = Data.FORMAT_CONF.format(Data.c.getTime());
    }
}
