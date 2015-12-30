package com.company;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.Random;

/**
 * Created by czopo on 12/30/15.
 */
public class PeopleAndCustomers {
    
    //FIELDS

    private final static Random r = new Random();
    private final static StringBuilder mainBuilder = new StringBuilder();
    private final static StringBuilder builder = new StringBuilder();
    private static int companyCounter = -1;
    private final static int DEC = 10;
    private final static String COUNTRY = "Polska";
    private final static int AMOUNT_OF_PEOPLE = 700;
    private final static int AMOUNT_OF_CLIENTS = 60;
    
    private static final String[] NAMES = {"Anna", "Piotr", " Maria", "Krzysztof", "Katarzyna", "Andrzej",
            "Małgorzata", "Jan", "Agnieszka", "Stanisław", "Barbara", "Tomasz", "Krystyna", "Paweł",
            "Ewa", "Marcin", "Elzbieta", "Michal", "Zofia", "Marek", "Teresa", "Grzegorz", "Magdalena",
            "Józef", "Joanna", "Łukasz", "Janina", "Adam", "Monika", "Zbigniew", "Danuta", "Jerzy",
            "Jadwiga", "Tadeusz", "Aleksandra", "Mateusz", "Halina", "Dariusz", "Irena", "Mariusz", "Beata", 
            "Wojciech", "Marta", "Ryszard", "Dorota", "Jakub", "Helena", "Henryk", "Karolina", "Robert", "Grażyna",
            "Rafał", "Jolanta", "Kazimierz", "Iwona", "Jacek", "Marianna", "Maciej", "Natalia", "Kamil"
    };

    private static final String[] SURNAMES = {"Nowak", "Wojcik", "Wozniak", "Kaczmarek", "Mazur", "Krawczyk",
            "Adamczyk", "Dudek", "Zajac", "Wieczorek", "Wrobel", "Walczak", "Stepien", "Michalak",
            "Baran", "Duda", "Szewczyk", "Pietrzak", "Marciniak", "Bak", "Wlodarczyk", "Kubiak",
            "Wilk", "Lis", "Kazmierczak", "Cieslak", "Kolodziej", "Blaszczyk", "Mroz", "Kaczmarczyk",
            "Kozak", "Kania", "Mucha", "Tomczak", "Koziol", "Kowalik", "Tomczyk", "Jarosz", "Kurek",
            "Kopeć", "Żak", "Łuczak", "Dziedzic", "Kot", "Stasiak", "Stankiewicz", "Piątek", "Urban",
            "Pawlik", "Kruk", "Polak", "Zięba", "Sowa", "Klimek", "Olejniczak", "Bednarek", "Ratajczak",
            "Czech", "Leśniak", "Czaja", "Świątek", "Pająk", "Małek", "Matysiak", "Przybysz", "Kasprzyk"
    };

    private static final String[] CITIES = {"Krakow", "Warszawa", "Poznan", "Szczecin", "Laskowa",
            "Jaworzna", "Niepolomice", "Przemysl", "Wieliczka", "Bydgoszcz", "Kielce",
            "Inowroclaw", "Zakopane", "Czestochowa", "Bukowina Tatrzanska", "Zamosc",
            "Ujastek", "Podzamcze", "Piekary", "Kołobrzeg", "Szczecin", "Gdańsk", "Gdynia"
    };
    
    private static final String[] COMPANIES = {"Activmed", "Activity", "Vodafone", "Nokia", "Samsung", "Microsoft",
            "Audi", "Fiat", "LG", "Nike", "Citroen", "H&M", "LuxMed", "Hp", "Apple", "Siemens", "Orlen",
            "Shell", "Empik", "Filmweb", "Gazeta", "TVN", "Facebook", "Twitter", "Google", "Rzad RP",
            "Paramedics", "SPA-Beauty", "Onet.pl", "Groupon"};
    
    
    private static final String[] ADDRESSES = {"Polna", "Leśna", "Słoneczna", "Krótka", "Długa", "Szkolna",
            "Ogrodowa", "Lipowa", "Brzozowa", "Łąkowa", "Kwiatowa", "Kościuszki", "Mickiewicza", "Słowackiego",
            "Kopernika", "Konopnickiej", "Popiełuszki", "Bobrowskiego", "Czarnowiejska", "Bobrowa", "Zamkowa",
            "Rynek główny", "Szewska", "Spółdzielców", "Reymana", "Dobrowolska", "Słonecznikowa", "Czarnobylska"
    };
    


    //MAIN METHODS
    
    public static void generate(BufferedWriter writer) throws IOException {
        generateClients(writer);
        generatePeople(writer);
    }
    
    private static void generateClients(BufferedWriter writer) throws IOException {
        
        writer.newLine();
        writer.write("--GENERATED CLIENTS:");
        writer.newLine();
        writer.newLine();

        for(int i = 0; i < AMOUNT_OF_CLIENTS; i++) {
            mainBuilder.delete(0, mainBuilder.length());
            if(r.nextInt(2) == 0) {
                mainBuilder.append("dodaj_klient_prywatny " + generatePrivateCustomerName() + ", " +generatePhoneNumber()
                    + ", " + generateAddress() + ", " + generateCity() + ", " +generatePostalCode() + ", " +
                COUNTRY + ", " + generateStudentID());
                writer.write(mainBuilder.toString());
                writer.newLine();
            } else {
                mainBuilder.append("dodaj_klient_firma " + generateCompanyName() + ", " +generatePhoneNumber()
                        + ", " + generateAddress() + ", " + generateCity() + ", " +generatePostalCode() + ", " +
                        COUNTRY + ", " + generateNIP());
                writer.write(mainBuilder.toString());
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
        
        
        for(int i = 0; i < AMOUNT_OF_PEOPLE; i++) {
            mainBuilder.delete(0, mainBuilder.length());
            mainBuilder.append("dodaj_osoba " + generateName() + "', '" + generateSurname() + ", " + generateStudentID());
            writer.write(mainBuilder.toString());
            writer.newLine();
        }
        
        writer.newLine();

    }
    
    
    //SUBMETHODS

    private static String generateName() {
        return "'" + NAMES[r.nextInt(NAMES.length)];
    }

    private static String generateSurname() {
        return SURNAMES[r.nextInt(SURNAMES.length)] + "'";
    }


    private static String generateCompanyName() {
        if(companyCounter < COMPANIES.length) { companyCounter++; }
        return "'" + COMPANIES[companyCounter] + "'";
    }
    
    private static String generatePrivateCustomerName() {
        return generateName() + " " + generateSurname();
    }

    private static String generatePhoneNumber() {
        builder.delete(0, builder.length());
        builder.append("'+48");

        for(int i = 0; i < 9; i++) {
            builder.append(r.nextInt(DEC));
        }
        builder.append("'");
        return builder.toString();
    }

    private static String generateAddress() {
        builder.delete(0, builder.length());
        int nr = r.nextInt(120);
        builder.append("'" + ADDRESSES[r.nextInt(ADDRESSES.length)] + " " + Integer.toString(nr) + "'");
        return builder.toString();
    }

    private static String generateCity() {
        return "'" + CITIES[r.nextInt(CITIES.length)] + "'";
    }

    private static String generateCountry() {
        return "'" + COUNTRY + "'";
    }

    private static String generatePostalCode() {
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

    private static String generateStudentID() {
        int generate = r.nextInt(3);
        if(generate == 0) {
            builder.delete(0, builder.length());
            builder.append("'");
            for(int i = 0; i < 6; i++) {
                builder.append(r.nextInt(DEC));
            }
            builder.append("'");
            return builder.toString();
        } else {
            return "NULL";    
        }
    }

    private static String generateNIP() {
        builder.delete(0, builder.length());
        builder.append("'");
        for(int i = 0; i < 10; i++) {
            builder.append(r.nextInt(DEC));
        }
        builder.append("'");
        return builder.toString();
    }
}
