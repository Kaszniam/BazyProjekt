package com.company;

import java.io.BufferedWriter;
import java.io.IOException;

/**
 * Created by czopo on 12/30/15.
 */
public class PeopleAndCustomers {
    
    //FIELDS

//    private final static Random r = new Random();
//    private final static StringBuilder mainBuilder = new StringBuilder();
//    private final static StringBuilder builder = new StringBuilder();
//    private static int companyCounter = -1;
//    private final static int DEC = 10;
//    public final static String COUNTRY = "Polska";
//    public final static int AMOUNT_OF_PEOPLE = 500;
//    public final static int AMOUNT_OF_STUDENTS = 200;
//    public final static int AMOUNT_OF_CLIENTS = 60;
//    
//    private static final String[] NAMES = {"Anna", "Piotr", " Maria", "Krzysztof", "Katarzyna", "Andrzej",
//            "Małgorzata", "Jan", "Agnieszka", "Stanisław", "Barbara", "Tomasz", "Krystyna", "Paweł",
//            "Ewa", "Marcin", "Elzbieta", "Michal", "Zofia", "Marek", "Teresa", "Grzegorz", "Magdalena",
//            "Józef", "Joanna", "Łukasz", "Janina", "Adam", "Monika", "Zbigniew", "Danuta", "Jerzy",
//            "Jadwiga", "Tadeusz", "Aleksandra", "Mateusz", "Halina", "Dariusz", "Irena", "Mariusz", "Beata", 
//            "Wojciech", "Marta", "Ryszard", "Dorota", "Jakub", "Helena", "Henryk", "Karolina", "Robert", "Grażyna",
//            "Rafał", "Jolanta", "Kazimierz", "Iwona", "Jacek", "Marianna", "Maciej", "Natalia", "Kamil"
//    };
//
//    private static final String[] SURNAMES = {"Nowak", "Wojcik", "Wozniak", "Kaczmarek", "Mazur", "Krawczyk",
//            "Adamczyk", "Dudek", "Zajac", "Wieczorek", "Wrobel", "Walczak", "Stepien", "Michalak",
//            "Baran", "Duda", "Szewczyk", "Pietrzak", "Marciniak", "Bak", "Wlodarczyk", "Kubiak",
//            "Wilk", "Lis", "Kazmierczak", "Cieslak", "Kolodziej", "Blaszczyk", "Mroz", "Kaczmarczyk",
//            "Kozak", "Kania", "Mucha", "Tomczak", "Koziol", "Kowalik", "Tomczyk", "Jarosz", "Kurek",
//            "Kopeć", "Żak", "Łuczak", "Dziedzic", "Kot", "Stasiak", "Stankiewicz", "Piątek", "Urban",
//            "Pawlik", "Kruk", "Polak", "Zięba", "Sowa", "Klimek", "Olejniczak", "Bednarek", "Ratajczak",
//            "Czech", "Leśniak", "Czaja", "Świątek", "Pająk", "Małek", "Matysiak", "Przybysz", "Kasprzyk"
//    };
//
//    private static final String[] CITIES = {"Krakow", "Warszawa", "Poznan", "Szczecin", "Laskowa",
//            "Jaworzna", "Niepolomice", "Przemysl", "Wieliczka", "Bydgoszcz", "Kielce",
//            "Inowroclaw", "Zakopane", "Czestochowa", "Bukowina Tatrzanska", "Zamosc",
//            "Ujastek", "Podzamcze", "Piekary", "Kołobrzeg", "Szczecin", "Gdańsk", "Gdynia"
//    };
//    
//    private static final String[] COMPANIES = {"Activmed", "Activity", "Vodafone", "Nokia", "Samsung", "Microsoft",
//            "Audi", "Fiat", "LG", "Nike", "Citroen", "H&M", "LuxMed", "Hp", "Apple", "Siemens", "Orlen",
//            "Shell", "Empik", "Filmweb", "Gazeta", "TVN", "Facebook", "Twitter", "Google", "Rzad RP",
//            "Paramedics", "SPA-Beauty", "Onet.pl", "Groupon", "Tauron", "Orlen", "KGHM", "Lotos", "Volkswagen",
//            "Azoty", "PGE", "PKP", "Grupa Żywiec", "Valeo", "Żabka", "Mostostal", "Cyfrowy Polsat"
//    };
//    
//    
//    private static final String[] ADDRESSES = {"Polna", "Leśna", "Słoneczna", "Krótka", "Długa", "Szkolna",
//            "Ogrodowa", "Lipowa", "Brzozowa", "Łąkowa", "Kwiatowa", "Kościuszki", "Mickiewicza", "Słowackiego",
//            "Kopernika", "Konopnickiej", "Popiełuszki", "Bobrowskiego", "Czarnowiejska", "Bobrowa", "Zamkowa",
//            "Rynek główny", "Szewska", "Spółdzielców", "Reymana", "Dobrowolska", "Słonecznikowa", "Czarnobylska"
//    };
    


    //MAIN METHODS
    
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
        Data.builder.append("'" + Data.ADDRESSES[Data.r.nextInt(Data.ADDRESSES.length)] + " " + Integer.toString(nr) + "'");
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
