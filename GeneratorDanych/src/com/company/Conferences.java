package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Calendar;

/**
 * Created by czopo on 12/31/15.
 */
public class Conferences {

    //FIELDS
//    
//    private final static Random r = new Random();
//    private final static StringBuilder mainBuilder = new StringBuilder();
//    private final static StringBuilder builder = new StringBuilder();
//    private final static int AMOUNT_OF_CONFS = 72;
//    public static String startConfDate = "2016-06-06";
//    private final static DateFormat formatconf = new SimpleDateFormat("yyyy-MM-dd");
//    private final static Calendar c = Calendar.getInstance();
//    public final static int MIN_CONF_SLOTS = 100;
//    public final static int MAX_CONF_SLOTS = 300;
//    public final static int MIN_DAYS_CONF = 0;
//    public final static int MAX_DAYS_CONF = 4;
//    public final static int MIN_DIFF_DAYS_CONF = 7;
//    public final static int MAX_DIFF_DAYS_CONF = 21;
//    public static int currentConfId = 0;
//    public static int currentConfDays;
//    public static int currentConfSlots;
//    
//
//    private final static String [] CONF_NAMES = {"Rozwój osobisty", "Żywienie w sporcie", "Targi pracy",
//            "Praca za granicą", "EXPO", "Technologia a zdrowie", "Sztuki walki", "Bezpieczeństwo w życiu",
//            "Ogólnopolska burza mózgów", "Nowe technologie", "Targi językowe", "Rozwiń kreatywność!", 
//            "Akademickie targi pracy", "Religie świata", "Samoobrona", "Rozwój miasta", "Infrastruktura miasta",
//            "Targi gier", "Targi ślubne", "Wielcy naukowcy", "Nieznani naukowcy"
//    };
//    
//    private final static String [] CONF_DESC = {"Prosty opis", "Bardzo prosty opis", "Konferencja rozwijająca",
//            "Konferencja dyskusyjna", "Konferencja dla ambitnych", "Tytuł konferencji już jest wymowny",
//            "Dla każdego!", "Spełnij marzenia", "Może masz lepszy pomysł?", "Tylko dla doświadczonych",
//            "Gorąco zapraszamy!"
//    };
    
    //MAIN METHODS
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
                
            for(int i = 0; i < Data.AMOUNT_OF_CONFS; i++) {
                generateConf(writer);
                updateDate();
            }
        
    }
    
    private static void generateConf(BufferedWriter writer) throws IOException, ParseException {
        Data.currentConfId++;
        Data.currentConfDays = Data.r.nextInt(Data.MAX_DAYS_CONF - Data.MIN_DAYS_CONF) + Data.MIN_DAYS_CONF;
        Data.currentConfSlots = Data.r.nextInt(Data.MAX_CONF_SLOTS - Data.MIN_CONF_SLOTS) + Data.MIN_CONF_SLOTS;
        String endDate = Data.startConfDate;
        Data.c.setTime(Data.formatconf.parse(endDate));
        Data.c.add(Calendar.DATE, Data.currentConfDays);
        endDate = Data.formatconf.format(Data.c.getTime());
        
        
        writer.newLine();
        writer.write("--CONFERENCE " + Data.currentConfId + ":");
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
        Data.c.setTime(Data.formatconf.parse(Data.startConfDate));
        Data.c.add(Calendar.DATE, diff);
        Data.startConfDate = Data.formatconf.format(Data.c.getTime());
    }
}

