package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

/**
 * Created by czopo on 12/31/15.
 */
public class Conferences {

    //FIELDS
    
    private final static Random r = new Random();
    private final static StringBuilder mainBuilder = new StringBuilder();
    private final static StringBuilder builder = new StringBuilder();
    private final static int AMOUNT_OF_CONFS = 72;
    public static String date = "2016-06-06";
    private final static DateFormat formatconf = new SimpleDateFormat("yyyy-MM-dd");
    private final static Calendar c = Calendar.getInstance();
    public final static int MIN_CONF_SLOTS = 100;
    public final static int MAX_CONF_SLOTS = 300;
    public final static int MIN_DAYS_CONF = 0;
    public final static int MAX_DAYS_CONF = 4;
    public final static int MIN_DIFF_DAYS_CONF = 7;
    public final static int MAX_DIFF_DAYS_CONF = 21;
    public static int currentConfId = 0;
    public static int currentConfDays;
    public static int currentSlots;
    

    private final static String [] CONF_NAMES = {"Rozwój osobisty", "Żywienie w sporcie", "Targi pracy",
            "Praca za granicą", "EXPO", "Technologia a zdrowie", "Sztuki walki", "Bezpieczeństwo w życiu",
            "Ogólnopolska burza mózgów", "Nowe technologie", "Targi językowe", "Rozwiń kreatywność!", 
            "Akademickie targi pracy", "Religie świata", "Samoobrona", "Rozwój miasta", "Infrastruktura miasta",
            "Targi gier", "Targi ślubne", "Wielcy naukowcy", "Nieznani naukowcy"
    };
    
    private final static String [] CONF_DESC = {"Prosty opis", "Bardzo prosty opis", "Konferencja rozwijająca",
            "Konferencja dyskusyjna", "Konferencja dla ambitnych", "Tytuł konferencji już jest wymowny",
            "Dla każdego!", "Spełnij marzenia", "Może masz lepszy pomysł?", "Tylko dla doświadczonych",
            "Gorąco zapraszamy!"
    };
    
    //MAIN METHODS
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
                
            for(int i = 0; i < AMOUNT_OF_CONFS; i++) {
                generateConf(writer);
                updateDate();
            }
    }
    
    private static void generateConf(BufferedWriter writer) throws IOException, ParseException {
        currentConfId++;
        currentConfDays = r.nextInt(MAX_DAYS_CONF - MIN_DAYS_CONF) + MIN_DAYS_CONF;           
        currentSlots = r.nextInt(MAX_CONF_SLOTS - MIN_CONF_SLOTS) + MIN_CONF_SLOTS;
        String endDate = date;
        c.setTime(formatconf.parse(endDate));
        c.add(Calendar.DATE, currentConfDays);
        endDate = formatconf.format(c.getTime());
        
        
        writer.newLine();
        writer.write("--CONFERENCE " +currentConfId + ":");
        writer.newLine();
        writer.newLine();
        
        mainBuilder.delete(0, mainBuilder.length());
        mainBuilder.append("INSERT INTO Conferences VALUES (" + generateConfName() + ", " + generateConfDesc() + ", '"
                + date + "', '" + endDate + "', 0)");
        
        writer.write(mainBuilder.toString());
        writer.newLine();
        
        Days.generate(writer);

    }
    
    private static String generateConfName() {
        return "'" + CONF_NAMES[r.nextInt(CONF_NAMES.length)] + "'";
    }
    
    private static String generateConfDesc() {
        if(r.nextInt(2) == 0) {
            return "NULL";
        } else {
            return "'" + CONF_DESC[r.nextInt(CONF_DESC.length)] + "'";
        }
    }
    
    private static void updateDate() throws ParseException {
        int diff = r.nextInt(MAX_DIFF_DAYS_CONF - MIN_DIFF_DAYS_CONF) + MIN_DIFF_DAYS_CONF;
        c.setTime(formatconf.parse(date));
        c.add(Calendar.DATE, diff);
        date = formatconf.format(c.getTime());
    }
}

