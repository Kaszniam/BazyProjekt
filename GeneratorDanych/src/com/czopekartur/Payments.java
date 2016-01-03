package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Calendar;

/**
 * Created by czopo on 1/2/16.
 */
public class Payments {
    
    public static void generate(BufferedWriter writer, boolean workshop) throws ParseException, IOException {
        
        boolean generatedPrice = false;
        Data.priceForReservation = 0f;
        
        for(int i = 0; i < Data.amountOfPrices; i++) {
            generateDate();
            generateDaysToConf();
            
            if(!generatedPrice) {
                generateAmountOfPrices();
                generatePrice(workshop);
                Data.onePaymentPrice = Float.parseFloat(new DecimalFormat("#.##").format(Data.priceForReservation / Data.amountOfPrices));
                generatedPrice = true;
            }

            generatePayment(writer);
        }
        
        writer.newLine();
    }
    
    private static void generatePayment(BufferedWriter writer) throws IOException {
        
        Data.mainBuilder.delete(0, Data.mainBuilder.length());
        Data.mainBuilder.append("          INSERT INTO PaymentDone VALUES (");
        Data.mainBuilder.append(Data.currentResID);
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.onePaymentPrice);
        Data.mainBuilder.append(", '");
        Data.mainBuilder.append(Data.dateOfPayment);
        Data.mainBuilder.append("')");
        
        writer.write(Data.mainBuilder.toString());
        writer.newLine();
    }

    private static void generatePrice(boolean workshop) {

            if(Data.daysToConf >= 30) {
                Data.priceForReservation += (Data.amountOfAdults * Data.pricesTbl[0].getAdultPrice());
                Data.priceForReservation += (Data.amountOfStudents * Data.pricesTbl[0].getStudentPrice());
//                System.out.println("30 Dorosly: " + Data.amountOfAdults * Data.pricesTbl[0].getAdultPrice() +
//                        " Student: " +Data.amountOfStudents * Data.pricesTbl[0].getStudentPrice());
            } else if(Data.daysToConf < 30 && Data.daysToConf >= 20) {
                Data.priceForReservation += (Data.amountOfAdults *  Data.pricesTbl[1].getAdultPrice());
                Data.priceForReservation += (Data.amountOfStudents * Data.pricesTbl[1].getStudentPrice());
//                System.out.println("20 Dorosly: " + Data.amountOfAdults * Data.pricesTbl[1].getAdultPrice() +
//                        " Student: " +Data.amountOfStudents * Data.pricesTbl[1].getStudentPrice());
            } else if(Data.daysToConf < 20 && Data.daysToConf >= 10) {
                Data.priceForReservation += (Data.amountOfAdults *  Data.pricesTbl[2].getAdultPrice());
                Data.priceForReservation += (Data.amountOfStudents * Data.pricesTbl[2].getStudentPrice());
//                System.out.println("10 Dorosly: " + Data.amountOfAdults * Data.pricesTbl[2].getAdultPrice() +
//                        " Student: " +Data.amountOfStudents * Data.pricesTbl[2].getStudentPrice());
            } else {
//                System.out.println("0 Dorosly: " + Data.confResSize *  Data.pricePerSlot +
//                        " Student: " +Data.confResSize *  Data.pricePerSlot);
                Data.priceForReservation += (Data.confResSize *  Data.pricePerSlot);
            }
        
        if(workshop) Data.priceForReservation += (Data.confResSize * Data.workPrices.get(Data.workResWorkId));

    }
    
    private static void generateAmountOfPrices() {
        Data.amountOfPrices = 1 + Data.r.nextInt(7)/4;
    }
    
    private static void generateDate() throws ParseException {
        Data.dateOfPayment = Data.currentResDate;
        Data.delay = Data.r.nextInt(Data.MAX_DELAY);

        Data.c.setTime(Data.FORMAT_CONF.parse(Data.dateOfPayment));
        Data.c.add(Calendar.DATE, Data.delay);
        Data.dateOfPayment = Data.FORMAT_CONF.format(Data.c.getTime());
    }
    
    public static void generateDaysToConf() {
        Data.daysToConf = Data.daysBeforeRes - Data.delay;
    }
}
