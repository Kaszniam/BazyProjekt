package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by czopo on 1/2/16.
 */
public class Workshops {

    public static void generate(BufferedWriter writer) throws ParseException, IOException {
        Data.MAX_SLOTS_WORK = Data.currentConfSlots / 3;
        Data.AmountOfWorks = Data.MIN_WORKS + Data.r.nextInt(Data.MAX_WORKS-Data.MIN_WORKS);
        Data.timeWork = "01:00";
        generateStartDate();
        Data.listOfWorkshops = new ArrayList<Integer>();
        Data.listOfWorkshopSlots = new ArrayList<Integer>();
        
        for(int i = 0; i < Data.AmountOfWorks; i++) {
            generateWorkshop(writer);
        }
        
        writer.newLine();
    }
    
    private static void generateWorkshop(BufferedWriter writer) throws ParseException, IOException {
        Data.workshopId++;
        Data.listOfWorkshops.add(Data.workshopId);
        
        generateSlots();
        Data.listOfWorkshopSlots.add(Data.currentSlotsWork);
        
        
        generateTimes();
        generatePrice();

        writer.newLine();

        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("      INSERT INTO Workshops VALUES (");
        Data.mainBuilder.append(Data.dayId);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(generateDescription());
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.currentSlotsWork);
        Data.mainBuilder.append(", '");
        Data.mainBuilder.append(Data.startDateWork);
        Data.mainBuilder.append("', '");
        Data.mainBuilder.append(Data.endDateWork);
        Data.mainBuilder.append("', ");
        Data.mainBuilder.append(Data.currentPriceWork);
        Data.mainBuilder.append(", 0)");

        Data.workshopsIDs.add(Data.workshopId);
        
        Data.workPrices.put(Data.workshopId, Data.currentPriceWork);
        
        writer.write(Data.mainBuilder.toString());
    }
    
    private static void generateStartDate() {
        Data.builder.delete(0, Data.builder.length());
        Data.builder.append(Data.currentDate);
        Data.builder.append(" ");
        Data.builder.append(Data.timeWork);
        Data.startDateWork = Data.builder.toString();
    }
    
    private static void generateTimes() throws ParseException {

        Data.c.setTime(Data.formatwork.parse(Data.startDateWork));
        Data.c.add(Calendar.MINUTE, Data.DIFF_TIME_WORK * (Data.r.nextInt(Data.MULTI_WORK) + 1));
        Data.startDateWork = Data.formatwork.format(Data.c.getTime());
        Data.startDateWork = Data.startDateWork.replace("12:", "00:");

        Data.c.setTime(Data.formatwork.parse(Data.startDateWork));
        Data.c.add(Calendar.MINUTE, Data.DIFF_TIME_WORK * (Data.r.nextInt(Data.MULTI_WORK) + 1));
        if (Data.startDateWork.contains("10:") || Data.startDateWork.contains("11:")) {
            Data.endDateWork = Data.FORMAT_CONF.format(Data.c.getTime());
            Data.endDateWork = Data.endDateWork + " 12:00";
        }else{
            Data.endDateWork = Data.formatwork.format(Data.c.getTime());
        }
    }
    
    private static String generateDescription() {
        if(Data.r.nextInt(2) == 0) return "NULL";
        else return "'" + Data.WORK_DESC[Data.r.nextInt(Data.WORK_DESC.length)] + "'";
    }
    
    private static void generateSlots() {
        Data.currentSlotsWork = Data.MIN_SLOTS_WORK + Data.r.nextInt(Data.MAX_SLOTS_WORK-Data.MIN_SLOTS_WORK);
    }
    
    
    private static void generatePrice() {
        Data.currentPriceWork = Data.MIN_PRICE + Data.r.nextInt(Data.MAX_PRICE_WORK-Data.MIN_PRICE_WORK);
    }
}
