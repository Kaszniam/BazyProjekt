package com.czopekartur;

import java.io.BufferedWriter;
import java.io.IOException;

/**
 * Created by czopo on 12/30/15.
 */
public class PeopleAndCustomers {

    public static void generate(BufferedWriter writer) throws IOException {
        generateClients(writer);
        generatePeople(writer);
        generateStudents(writer);
    }
    
    private static void generateClients(BufferedWriter writer) throws IOException {
        
        writer.newLine();
        writer.write("--GENERATED CLIENTS:");
        writer.newLine();
        writer.newLine();

        for(int i = 0; i < Data.AMOUNT_OF_CLIENTS; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            if(Data.r.nextInt(2) == 0) {
                Data.mainBuilder.append("INSERT INTO Clients VALUES (0,");
                Data.mainBuilder.append(generatePrivateCustomerName());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generatePhoneNumber());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateAddress());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateCity());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generatePostalCode());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateCountry());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateStudentID());
                Data.mainBuilder.append(", NULL)");
                writer.write(Data.mainBuilder.toString());
                writer.newLine();
            } else {
                Data.mainBuilder.append("INSERT INTO Clients VALUES (1,");
                Data.mainBuilder.append(generateCompanyName());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generatePhoneNumber());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateAddress());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateCity());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generatePostalCode());
                Data.mainBuilder.append(", ");
                Data.mainBuilder.append(generateCountry());
                Data.mainBuilder.append(", NULL, ");
                Data.mainBuilder.append(generateNIP());
                Data.mainBuilder.append(")");
                writer.write(Data.mainBuilder.toString());
                writer.newLine();
            }
        }
        writer.newLine();
    }
    
    private static void generatePeople(BufferedWriter writer) throws IOException {

        writer.newLine();
        writer.write("--GENERATED PEOPLE:");
        writer.newLine();
        writer.newLine();
        
        
        for(int i = 0; i < Data.AMOUNT_OF_PEOPLE; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("INSERT INTO People VALUES (");
            Data.mainBuilder.append(generateName());
            Data.mainBuilder.append("', '");
            Data.mainBuilder.append(generateSurname());
            Data.mainBuilder.append(", NULL)");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }
        
        writer.newLine();

    }
    
    private static void generateStudents(BufferedWriter writer) throws IOException {

        writer.newLine();
        writer.write("--GENERATED STUDENTS:");
        writer.newLine();
        writer.newLine();

        for(int i = 0; i < Data.AMOUNT_OF_STUDENTS; i++) {
            Data.mainBuilder.delete(0, Data.mainBuilder.length());
            Data.mainBuilder.append("INSERT INTO People VALUES (");
            Data.mainBuilder.append(generateName());
            Data.mainBuilder.append("', '");
            Data.mainBuilder.append(generateSurname());
            Data.mainBuilder.append(", ");
            Data.mainBuilder.append(generateStudentID());
            Data.mainBuilder.append(")");
            writer.write(Data.mainBuilder.toString());
            writer.newLine();
        }

        writer.newLine();
    }
    
    
    //SUBMETHODS

    private static String generateName() {
        return "'" + Data.NAMES[Data.r.nextInt(Data.NAMES.length)];
    }

    private static String generateSurname() {
        return Data.SURNAMES[Data.r.nextInt(Data.SURNAMES.length)] + "'";
    }


    private static String generateCompanyName() {
        if(Data.companyCounter+1 < Data.COMPANIES.length) { Data.companyCounter++; }
        return "'" + Data.COMPANIES[Data.companyCounter] + "'";
    }
    
    private static String generatePrivateCustomerName() {
        return generateName() + " " + generateSurname();
    }

    private static String generatePhoneNumber() {
        Data.builder.delete(0, Data.builder.length());
        Data.builder.append("'+48");

        for(int i = 0; i < 9; i++) {
            Data.builder.append(Data.r.nextInt(Data.DEC));
        }
        Data.builder.append("'");
        return Data.builder.toString();
    }

    private static String generateAddress() {
        Data.builder.delete(0, Data.builder.length());
        int nr = Data.r.nextInt(120)+1;
        Data.builder.append("'");
        Data.builder.append(Data.ADDRESSES[Data.r.nextInt(Data.ADDRESSES.length)]);
        Data.builder.append(" ");
        Data.builder.append(Integer.toString(nr));
        Data.builder.append("'");
        return Data.builder.toString();
    }

    private static String generateCity() {
        return "'" + Data.CITIES[Data.r.nextInt(Data.CITIES.length)] + "'";
    }

    private static String generateCountry() {
        return "'" + Data.COUNTRY + "'";
    }

    private static String generatePostalCode() {
        Data.builder.delete(0, Data.builder.length());
        Data.builder.append("'");
        for(int i = 0; i < 2; i++) {
            Data.builder.append(Data.r.nextInt(Data.DEC));
        }

        Data.builder.append("-");

        for(int i = 0; i < 3; i++) {
            Data.builder.append(Data.r.nextInt(Data.DEC));
        }
        Data.builder.append("'");
        return Data.builder.toString();
    }

    private static String generateStudentID() {
        Data.builder.delete(0, Data.builder.length());
        Data.builder.append("'");
        for(int i = 0; i < 6; i++) {
            Data.builder.append(Data.r.nextInt(Data.DEC));
        }
        Data.builder.append("'");
        return Data.builder.toString();
    }

    private static String generateNIP() {
        Data.builder.delete(0, Data.builder.length());
        Data.builder.append("'");
        for(int i = 0; i < 10; i++) {
            Data.builder.append(Data.r.nextInt(Data.DEC));
        }
        Data.builder.append("'");
        return Data.builder.toString();
    }
}
