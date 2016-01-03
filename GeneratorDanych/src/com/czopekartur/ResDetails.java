package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by czopo on 1/3/16.
 */
public class ResDetails {

    public static void generate(BufferedWriter writer, boolean workshop) throws IOException {

        Data.listOfAdults = new ArrayList<Integer>();
        Data.listOfStudents = new ArrayList<Integer>();

        for (int i = 0; i < Data.amountOfAdults; i++) {
            generateAdult(writer);

            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("          INSERT INTO ConfResDetails VALUES (");
            Data.mainBuilder.append(Data.currentResID);
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(Data.adultID);
            Data.mainBuilder.append(", NULL)");

            writer.write(Data.mainBuilder.toString());
            writer.newLine();

            if (workshop) addToWork(writer, "ADULT");
        }


        for (int i = 0; i < Data.amountOfStudents; i++) {
            generateStudent(writer);

            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("          INSERT INTO ConfResDetails VALUES (");
            Data.mainBuilder.append(Data.currentResID);
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(Data.studentID);
            Data.mainBuilder.append(", (SELECT StudentID FROM People WHERE PersonID = ");
            Data.mainBuilder.append(Data.studentID);
            Data.mainBuilder.append("))");

            writer.write(Data.mainBuilder.toString());
            writer.newLine();

            if (workshop) addToWork(writer, "STUDENT");
        }

        writer.newLine();
    }

    private static void addToWork(BufferedWriter writer, String type) throws IOException {
        
        Data.mainBuilder.delete(0,Data.mainBuilder.length());
        Data.mainBuilder.append("          INSERT INTO WorkResDetails VALUES (");
        Data.mainBuilder.append(Data.workResId);
        Data.mainBuilder.append(", ");
        if(type.equals("ADULT")) {
            Data.mainBuilder.append(Data.adultID);
        }
        else if(type.equals("STUDENT")) {
            Data.mainBuilder.append(Data.studentID);
        }
        Data.mainBuilder.append(", ");
        Data.mainBuilder.append(Data.currentResID);
        Data.mainBuilder.append(")");

        writer.write(Data.mainBuilder.toString());
        writer.newLine();
    }
    
    private static void generateAdult (BufferedWriter writer) throws IOException {
        
        do {
            Data.adultID = 1 + Data.r.nextInt(Data.AMOUNT_OF_PEOPLE);
        } while(Data.listOfAdults.contains(Data.adultID));
        
        Data.listOfAdults.add(Data.adultID);
    }
        
    private static void generateStudent(BufferedWriter writer) throws IOException {
           
        do {
            Data.studentID = 1 + Data.AMOUNT_OF_PEOPLE + Data.r.nextInt(Data.AMOUNT_OF_STUDENTS);
        } while(Data.listOfStudents.contains(Data.studentID));
        
        Data.listOfStudents.add(Data.studentID);
        }
}
