package com.czopekartur;

import com.sun.istack.internal.NotNull;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;

/**
 * Created by czopo on 1/2/16.
 */
public class Prices {
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.pricesTbl = new Data.Record[3];
        Data.daysBefore = 30;
        Data.currentDayId++;
        Data.DIFF = 0.02f * (Data.r.nextInt(4) + 1);
        Data.pricePerSlot = generatePrice();
        int i = 0;
        while(Data.daysBefore > 0) {
            generatePrice(writer, i);
            Data.daysBefore -= Data.PRICE_DAY_DIFF;
            i++;
        }
        writer.newLine();
    }
    
    private static void generatePrice(BufferedWriter writer, int i) throws IOException {
        writer.newLine();
        Data.currentNormalDiscount = generateNormalDiscount(i);
        Data.currentStudentDiscount = generateStudentDiscount(i);
        Data.pricesTbl[i] = new Data.Record(Data.daysBefore,
                Float.parseFloat(new DecimalFormat("#.##").format(Data.pricePerSlot*(1-Data.currentNormalDiscount))), 
                Float.parseFloat(new DecimalFormat("#.##").format(Data.pricePerSlot*(1-Data.currentStudentDiscount))));
        
//        System.out.println("Dni przed: " + Data.pricesTbl[i].getDaysBefore() + " cena normal "  + Data.pricesTbl[i].getAdultPrice() + " cena student " + Data.pricesTbl[i].getStudentPrice());
//        
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
        return Float.parseFloat(new DecimalFormat("#.##").format(Data.normalDisc - Data.DIFF *i).toString());        
    }

    @NotNull
    private static float generateStudentDiscount(int i) {
        return Float.parseFloat(new DecimalFormat("#.##").format(Data.studentDisc - Data.DIFF * i));
    }
    
    private static int generatePrice() {
        return Data.MIN_PRICE+Data.r.nextInt((Data.MAX_PRICE-Data.MIN_PRICE)/5)*5;
    }
}
