package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;

/**
 * Created by czopo on 12/31/15.
 */
public class Conferences {

    public static void generate(BufferedWriter writer) throws IOException, ParseException {
                
            for(int i = 0; i < Data.AMOUNT_OF_CONFS; i++) {
                generateConf(writer);
                updateDate();
            }
        
    }
    
    private static void generateConf(BufferedWriter writer) throws IOException, ParseException {
        Data.conferenceId++;
        Data.currentConfDays = Data.r.nextInt(Data.MAX_DAYS_CONF - Data.MIN_DAYS_CONF) + Data.MIN_DAYS_CONF;
        Data.currentConfSlots = Data.r.nextInt(Data.MAX_CONF_SLOTS - Data.MIN_CONF_SLOTS) + Data.MIN_CONF_SLOTS;
        String endDate = Data.startConfDate;
        Data.c.setTime(Data.FORMAT_CONF.parse(endDate));
        Data.c.add(Calendar.DATE, Data.currentConfDays);
        endDate = Data.FORMAT_CONF.format(Data.c.getTime());
        
        
        writer.newLine();
        writer.write("--CONFERENCE " + Data.conferenceId + ":");
        writer.newLine();
        writer.newLine();

        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("INSERT INTO Conferences VALUES (");
        Data.mainBuilder.append(generateConfName());
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(generateConfDesc());
        Data.mainBuilder.append(", '");
        Data.mainBuilder.append(Data.startConfDate);
        Data.mainBuilder.append("', '");
        Data.mainBuilder.append(endDate);
        Data.mainBuilder.append("', 0)");
        
        writer.write(Data.mainBuilder.toString());
        writer.newLine();
        
        Days.generate(writer);

    }
    
    private static String generateConfName() {
        return "'" + Data.CONF_NAMES[Data.r.nextInt(Data.CONF_NAMES.length)] + "'";
    }
    
    private static String generateConfDesc() {
        if(Data.r.nextInt(2) == 0) {
            return "NULL";
        } else {
            return "'" + Data.CONF_DESC[Data.r.nextInt(Data.CONF_DESC.length)] + "'";
        }
    }
    
    private static void updateDate() throws ParseException {
        int diff = Data.r.nextInt(Data.MAX_DIFF_DAYS_CONF - Data.MIN_DIFF_DAYS_CONF) + Data.MIN_DIFF_DAYS_CONF;
        Data.c.setTime(Data.FORMAT_CONF.parse(Data.startConfDate));
        Data.c.add(Calendar.DATE, diff);
        Data.startConfDate = Data.FORMAT_CONF.format(Data.c.getTime());
    }
}

