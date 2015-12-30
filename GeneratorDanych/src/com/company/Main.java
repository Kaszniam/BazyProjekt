package com.company;

import java.util.Random;

public class Main {
    
    final static Random r = new Random();
    final static StringBuilder builder = new StringBuilder();
    final static String FILENAME = "Data.sql";
    final static int DEC = 10;
    final static String COUNTRY = "Poland";
    

    final static String[] NAMES = {"Anna", "Piotr", " Maria", "Krzysztof", "Katarzyna", "Andrzej",
            "Małgorzata", "Jan", "Agnieszka", "Stanisław", "Barbara", "Tomasz", "Krystyna", "Paweł",
            "Ewa", "Marcin", "Elzbieta", "Michal", "Zofia", "Marek", "Teresa", "Grzegorz", "Magdalena",
            "Józef", "Joanna", "Łukasz", "Janina", "Adam", "Monika", "Zbigniew", "Danuta", "Jerzy",
            "Jadwiga", "Tadeusz", "Aleksandra", "Mateusz", "Halina", "Dariusz", "Irena", "Mariusz"
    };

    final static String[] SURNAMES = {"Nowak", "Wojcik", "Wozniak", "Kaczmarek", "Mazur", "Krawczyk",
            "Adamczyk", "Dudek", "Zajac", "Wieczorek", "Wrobel", "Walczak", "Stepien", "Michalak",
            "Baran", "Duda", "Szewczyk", "Pietrzak", "Marciniak", "Bak", "Wlodarczyk", "Kubiak",
            "Wilk", "Lis", "Kazmierczak", "Cieslak", "Kolodziej", "Blaszczyk", "Mroz", "Kaczmarczyk",
            "Kozak", "Kania", "Mucha", "Tomczak", "Koziol", "Kowalik", "Tomczyk", "Jarosz", "Kurek"
    };

    final static String[] CITIES = {"Krakow", "Warszawa", "Poznan", "Szczecin", "Laskowa",
            "Jaworzna", "Niepolomice", "Przemysl", "Wieliczka", "Bydgoszcz", "Kielce",
            "Inowroclaw", "Zakopane", "Czestochowa", "Bukowina Tatrzanska", "Zamosc"
    };

    public static void main(String[] args) {

        
    
        for(int i = 0; i < 3; i++) {
            System.out.println("Person " + i);
            System.out.println(generateName());
            System.out.println(generateAddress());
            System.out.println(generateCity());
            System.out.println(generateCountry());
            System.out.println(generatePostalCode());
            System.out.println(generatePhoneNumber());
            System.out.println(generateNIP());
            System.out.println(generateStudentID());
            System.out.println();
        }
    }
    
    //GENEROWANIE KLIENTOW/LUDZI
    
    public static String generateName() {
        return  "'" + NAMES[r.nextInt(NAMES.length)] + " " + SURNAMES[r.nextInt(SURNAMES.length)] + "'";
    }
    
    public static String generateCompanyName() {
        return "'";
    }
    
    public static String generatePhoneNumber() {
        builder.delete(0, builder.length());
        builder.append("'+48");
        
        for(int i = 0; i < 9; i++) {
            builder.append(r.nextInt(DEC));
        }
        builder.append("'");
        return builder.toString();        
    }
    
    public static String generateAddress() {
        return "";
    }
    
    public static String generateCity() {
        return "'" + CITIES[r.nextInt(CITIES.length)] + "'";
    }
    
    public static String generateCountry() {
        return "'" + COUNTRY + "'";
    }
    
    public static String generatePostalCode() {
        builder.delete(0, builder.length());
        builder.append("'");
        for(int i = 0; i < 2; i++) {
            builder.append(r.nextInt(DEC));
        }
        
        builder.append("-");
        
        for(int i = 0; i < 3; i++) {
            builder.append(r.nextInt(DEC));
        }
        builder.append("'");
        return builder.toString();
    }
    
    public static String generateStudentID() {
        boolean generate = r.nextBoolean();
        if(!generate) {
            return "NULL";
        } else {
            builder.delete(0, builder.length());
            builder.append("'");
            for(int i = 0; i < 6; i++) {
                builder.append(r.nextInt(DEC));
            }
            builder.append("'");
            return builder.toString();
        }
    }
    
    public static String generateNIP() {
        builder.delete(0, builder.length());
        builder.append("'");
        for(int i = 0; i < 10; i++) {
            builder.append(r.nextInt(DEC));
        }
        builder.append("'");
        return builder.toString();
    }
}
