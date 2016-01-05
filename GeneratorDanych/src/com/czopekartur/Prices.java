package com.czopekartur;

import com.sun.istack.internal.NotNull;

import java.io.BufferedWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;

/**
 * Created by czopo on 1/2/16.
 */
public class Prices {
    
    public static void generate(BufferedWriter writer) throws IOException, ParseException {
        Data.pricesTbl = new Data.Record[3];
        Data.daysBefore = 30;
        //Data.currentDayId++;
        Data.DIFF = BigDecimal.valueOf(0.02);
        Data.DIFF = Data.DIFF.multiply(BigDecimal.valueOf(Data.r.nextInt(4) + 1));
        Data.pricePerSlot = generatePricePerSlot();
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
                BigDecimal.valueOf(Data.pricePerSlot).multiply(BigDecimal.valueOf(1).subtract(Data.currentNormalDiscount)), 
                        BigDecimal.valueOf(Data.pricePerSlot).multiply(BigDecimal.valueOf(1).subtract(Data.currentStudentDiscount))
                        );
                
//        System.out.println("Dni przed: " + Data.pricesTbl[i].getDaysBefore() + " cena normal "  + Data.pricesTbl[i].getAdultPrice() + " cena student " + Data.pricesTbl[i].getStudentPrice());
//        
        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("      INSERT INTO Prices VALUES (");
        //Data.mainBuilder.append(Data.currentDayId);
        Data.mainBuilder.append(Data.dayId);
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
    private static BigDecimal generateNormalDiscount(int i) {
        BigDecimal tmp = Data.DIFF;
        tmp = tmp.multiply(BigDecimal.valueOf(i));
        return Data.normalDisc.subtract(tmp);
    }

    @NotNull
    private static BigDecimal generateStudentDiscount(int i) {
        BigDecimal tmp = Data.DIFF;
        tmp = tmp.multiply(BigDecimal.valueOf(i));
        return Data.studentDisc.subtract(tmp);
    }
    
    private static int generatePricePerSlot() {
        return Data.MIN_PRICE+Data.r.nextInt((Data.MAX_PRICE-Data.MIN_PRICE)/5)*5;
    }
}
