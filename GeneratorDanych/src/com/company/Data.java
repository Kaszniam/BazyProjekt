package com.company;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

/**
 * Created by czopo on 1/3/16.
 */
public class Data {
    final static Random r = new Random();
    final static StringBuilder builder = new StringBuilder();
    final static StringBuilder mainBuilder = new StringBuilder();
    final static String FILENAME = "Data.sql";
    final static Calendar c = Calendar.getInstance();
    
    //CONFS
    final static int AMOUNT_OF_CONFS = 72;
    final static DateFormat formatconf = new SimpleDateFormat("yyyy-MM-dd");
    public final static int MIN_CONF_SLOTS = 100;
    public final static int MAX_CONF_SLOTS = 300;
    public final static int MIN_DAYS_CONF = 0;
    public final static int MAX_DAYS_CONF = 4;
    public final static int MIN_DIFF_DAYS_CONF = 7;
    public final static int MAX_DIFF_DAYS_CONF = 21;
    public static String startConfDate = "2016-06-06";
    public static int currentConfId = 0;
    public static int currentConfDays;
    public static int currentConfSlots;
    
    
    //DAYS
    public static String currentDate;
    public static int currentDayID = 0;
    public static List<Integer> workshopsIDs;
    
    
    //PEOPLE
    public static int companyCounter = -1;
    public final static int DEC = 10;
    public final static String COUNTRY = "Polska";
    public final static int AMOUNT_OF_PEOPLE = 500;
    public final static int AMOUNT_OF_STUDENTS = 200;
    public final static int AMOUNT_OF_CLIENTS = 60;
    
    
    //PRICES
    public static float studentDisc = 0.5f;
    public static float normalDisc = 0.3f;
    public static float currentStudentDiscount;
    public static float currentNormalDiscount;
    public static float diff;
    public static int MIN_PRICE = 50;
    public static int MAX_PRICE = 300;
    public static int daysBefore;
    public static int pricePerSlot;
    public static int currentDayId = 0;
    public static Record[] pricesTbl;
    
    
    //RESERVATIONS
    public final static DateFormat formatwork = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    public final static int MIN_RES_CONF = 5;
    public final static int MAX_RES_CONF = 15;
    public final static int MIN_ADULT_CONF = 2;
    public final static int MAX_ADULT_CONF = 10;
    public final static int MIN_STUDENT_CONF = 0;
    public final static int MAX_STUDENT_CONF = 4;
    public final static int MIN_DAYS_BEFORE = 20;
    public final static int MAX_DAYS_BEFORE = 40;
    public static int amountOfConfRes;
    public static int confSlotsLeft;
    public static int workSlotsLeft;
    public static int confResSize;
    public static int amountOfAdults;
    public static int amountOfStudents;
    public static int clientID;
    public static int daysBeforeRes;
    public static List<Integer> listOfAdultsId = new LinkedList<>();
    public static List<Integer> listOfStudentsId = new LinkedList<>();
    public static String currentResDate="";
    public static int currentResID = 0;
    
    
    //WORKSHOPS
    public final static int diffTimeWork = 30;           //minutes of interval
    public final static int multiWork = 6;
    public final static int MIN_WORKS = 1;
    public final static int MAX_WORKS = 5;
    public final static int MIN_PRICE_WORK = 0;
    public final static int MAX_PRICE_WORK = 40;
    public static int MIN_SLOTS_WORK = 5;
    public static int MAX_SLOTS_WORK;
    public static int AmountOfWorks;
    public static String startDateWork;
    public static String endDateWork;
    public static String timeWork;
    public static int currentWorkshopID = 0;
    public static int currentSlotsWork;
    public static int currentPriceWork;




    //NAMES



    public final static String [] CONF_NAMES = {"Rozwój osobisty", "Żywienie w sporcie", "Targi pracy",
            "Praca za granicą", "EXPO", "Technologia a zdrowie", "Sztuki walki", "Bezpieczeństwo w życiu",
            "Ogólnopolska burza mózgów", "Nowe technologie", "Targi językowe", "Rozwiń kreatywność!",
            "Akademickie targi pracy", "Religie świata", "Samoobrona", "Rozwój miasta", "Infrastruktura miasta",
            "Targi gier", "Targi ślubne", "Wielcy naukowcy", "Nieznani naukowcy"
    };

    public final static String [] CONF_DESC = {"Prosty opis", "Bardzo prosty opis", "Konferencja rozwijająca", 
            "Konferencja dyskusyjna", "Konferencja dla ambitnych", "Tytuł konferencji już jest wymowny",
            "Dla każdego!", "Spełnij marzenia", "Może masz lepszy pomysł?", "Tylko dla doświadczonych",
            "Gorąco zapraszamy!"
    };


    public static final String[] NAMES = {"Anna", "Piotr", " Maria", "Krzysztof", "Katarzyna", "Andrzej",
            "Małgorzata", "Jan", "Agnieszka", "Stanisław", "Barbara", "Tomasz", "Krystyna", "Paweł",
            "Ewa", "Marcin", "Elzbieta", "Michal", "Zofia", "Marek", "Teresa", "Grzegorz", "Magdalena",
            "Józef", "Joanna", "Łukasz", "Janina", "Adam", "Monika", "Zbigniew", "Danuta", "Jerzy",
            "Jadwiga", "Tadeusz", "Aleksandra", "Mateusz", "Halina", "Dariusz", "Irena", "Mariusz", "Beata",
            "Wojciech", "Marta", "Ryszard", "Dorota", "Jakub", "Helena", "Henryk", "Karolina", "Robert", "Grażyna",
            "Rafał", "Jolanta", "Kazimierz", "Iwona", "Jacek", "Marianna", "Maciej", "Natalia", "Kamil"
    };

    public static final String[] SURNAMES = {"Nowak", "Wojcik", "Wozniak", "Kaczmarek", "Mazur", "Krawczyk",
            "Adamczyk", "Dudek", "Zajac", "Wieczorek", "Wrobel", "Walczak", "Stepien", "Michalak",
            "Baran", "Duda", "Szewczyk", "Pietrzak", "Marciniak", "Bak", "Wlodarczyk", "Kubiak",
            "Wilk", "Lis", "Kazmierczak", "Cieslak", "Kolodziej", "Blaszczyk", "Mroz", "Kaczmarczyk",
            "Kozak", "Kania", "Mucha", "Tomczak", "Koziol", "Kowalik", "Tomczyk", "Jarosz", "Kurek",
            "Kopeć", "Żak", "Łuczak", "Dziedzic", "Kot", "Stasiak", "Stankiewicz", "Piątek", "Urban",
            "Pawlik", "Kruk", "Polak", "Zięba", "Sowa", "Klimek", "Olejniczak", "Bednarek", "Ratajczak",
            "Czech", "Leśniak", "Czaja", "Świątek", "Pająk", "Małek", "Matysiak", "Przybysz", "Kasprzyk"
    };

    public static final String[] CITIES = {"Krakow", "Warszawa", "Poznan", "Szczecin", "Laskowa",
            "Jaworzna", "Niepolomice", "Przemysl", "Wieliczka", "Bydgoszcz", "Kielce",
            "Inowroclaw", "Zakopane", "Czestochowa", "Bukowina Tatrzanska", "Zamosc",
            "Ujastek", "Podzamcze", "Piekary", "Kołobrzeg", "Szczecin", "Gdańsk", "Gdynia"
    };

    public static final String[] COMPANIES = {"Activmed", "Activity", "Vodafone", "Nokia", "Samsung", "Microsoft",
            "Audi", "Fiat", "LG", "Nike", "Citroen", "H&M", "LuxMed", "Hp", "Apple", "Siemens", "Orlen",
            "Shell", "Empik", "Filmweb", "Gazeta", "TVN", "Facebook", "Twitter", "Google", "Rzad RP",
            "Paramedics", "SPA-Beauty", "Onet.pl", "Groupon", "Tauron", "Orlen", "KGHM", "Lotos", "Volkswagen",
            "Azoty", "PGE", "PKP", "Grupa Żywiec", "Valeo", "Żabka", "Mostostal", "Cyfrowy Polsat"
    };


    public static final String[] ADDRESSES = {"Polna", "Leśna", "Słoneczna", "Krótka", "Długa", "Szkolna",
            "Ogrodowa", "Lipowa", "Brzozowa", "Łąkowa", "Kwiatowa", "Kościuszki", "Mickiewicza", "Słowackiego",
            "Kopernika", "Konopnickiej", "Popiełuszki", "Bobrowskiego", "Czarnowiejska", "Bobrowa", "Zamkowa",
            "Rynek główny", "Szewska", "Spółdzielców", "Reymana", "Dobrowolska", "Słonecznikowa", "Czarnobylska"
    };

    public final static String [] WORK_DESC = {"Prosty warsztat", "Warsztat dyskusyjny", "Zrób to sam",
            "Warsztat o prezencji", "Prezentacje", "Szkolenie", "Trening dla zaawansowanych",
            "Trening dla początkujących", "Burza mózgów", "Dyskusje znanych osobistości", "Szkolenie niespodzianka",
            "Warsztat integracyjny"
    };
    
    
    
    
    //ADDITIONAL CLASSES

    public static class Record {
        public int daysBefore;
        public int price;
        public float disc;
        public float studentDisc;

        public int getPrice() {
            return price;
        }

        public void setPrice(int price) {
            this.price = price;
        }

        public Record(int daysBefore, int price, float disc, float studentDisc) {
            this.daysBefore = daysBefore;
            this.price = price;
            this.disc = disc;
            this.studentDisc = studentDisc;
        }

        public int getDaysBefore() {
            return daysBefore;
        }

        public void setDaysBefore(int daysBefore) {
            this.daysBefore = daysBefore;
        }

        public float getDisc() {
            return disc;
        }

        public void setDisc(float disc) {
            this.disc = disc;
        }

        public float getStudentDisc() {
            return studentDisc;
        }

        public void setStudentDisc(float studentDisc) {
            this.studentDisc = studentDisc;
        }
    }
}
