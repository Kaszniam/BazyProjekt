package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;

/**
 * Created by czopo on 1/2/16.
 */
public class Workshops {

    //FIELDS

//    private final static Random r = new Random();
//    private final static StringBuilder mainBuilder = new StringBuilder();
//    private final static StringBuilder builder = new StringBuilder();
//    private final static DateFormat formatwork = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//    private final static Calendar c = Calendar.getInstance();
//    private final static int diffTimeWork = 30;           //minutes of interval
//    private final static int multiWork = 6;
//    private final static int MIN_WORKS = 1;
//    private final static int MAX_WORKS = 5;
//    private final static int MIN_PRICE_WORK = 0;
//    private final static int MAX_PRICE_WORK = 40;
//    private static int MIN_SLOTS_WORK = 5;
//    private static int MAX_SLOTS_WORK;
//    private static int AmountOfWorks;
//    private static String startDateWork;
//    private static String endDateWork;
//    private static String time;
//    public static int currentWorkshopID = 0;
//    public static int currentSlotsWork;
//    public static int currentPriceWork;

//    private final static String [] WORK_DESC = {"Prosty warsztat", "Warsztat dyskusyjny", "Zrób to sam",
//            "Warsztat o prezencji", "Prezentacje", "Szkolenie", "Trening dla zaawansowanych",
//            "Trening dla początkujących", "Burza mózgów", "Dyskusje znanych osobistości", "Szkolenie niespodzianka",
//            "Warsztat integracyjny"
//    };
        
    
    public static void generate(BufferedWriter writer) throws ParseException, IOException {
        Data.MAX_SLOTS_WORK = Data.currentConfSlots;
        Data.AmountOfWorks = Data.MIN_WORKS + Data.r.nextInt(Data.MAX_WORKS-Data.MIN_WORKS);
        Data.timeWork = "13:00";
        generateStartDate();
        for(int i = 0; i < Data.AmountOfWorks; i++) {
            generateWorkshop(writer);
        }
        writer.newLine();
    }
    
    private static void generateWorkshop(BufferedWriter writer) throws ParseException, IOException {
        Data.currentWorkshopID++;
        generateSlots();
        generateTimes();
        generatePrice();

        writer.newLine();

        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("      INSERT INTO Workshops VALUES (");
        Data.mainBuilder.append(Data.currentDayID);
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

        Data.workshopsIDs.add(Data.currentWorkshopID);
        
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
        Data.c.add(Calendar.MINUTE, Data.diffTimeWork * (Data.r.nextInt(Data.multiWork) + 1));
        Data.startDateWork = Data.formatwork.format(Data.c.getTime());

        Data.c.setTime(Data.formatwork.parse(Data.startDateWork));
        Data.c.add(Calendar.MINUTE, Data.diffTimeWork * (Data.r.nextInt(Data.multiWork)+1));
        Data.endDateWork = Data.formatwork.format(Data.c.getTime());
        
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
