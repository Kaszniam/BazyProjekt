package com.czopekartur;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;

public class Main {
    
//    final static Random r = new Random();
//    final static StringBuilder builder = new StringBuilder();
//    final static String FILENAME = "Data.sql";
    

    public static void main(String[] args) {


        try (
                BufferedWriter writer = new BufferedWriter(new FileWriter(Data.FILENAME, false));
        ) {
            PeopleAndCustomers.generate(writer);
            Conferences.generate(writer);
        } catch (IOException e) {
            System.err.println("Błąd zapisu do pliku");
        } catch (ParseException e) {
            System.err.println("Błąd parsowania");
        }


    }
}
