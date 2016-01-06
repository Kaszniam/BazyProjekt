package com.czopekartur;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by czopo on 1/3/16.
 */
public class Data {
    
    public final static Random r = new Random();
    public final static StringBuilder builder = new StringBuilder();
    public final static StringBuilder mainBuilder = new StringBuilder();
    public final static String FILENAME = "Data.sql";
    public final static Calendar c = Calendar.getInstance();
    
    
    //CANCEL
    public final static int CONF_CANCEL = 13;
    public final static int CONF_RES_CANCEL = 31;
    public final static int WORK_CANCEL = 37;
    public final static int WORK_RES_CANCEL = 47;
    public static int confsToCancel;
    public static int confRessToCancel;
    public static int worksToCancel;
    public static int workRessToCancel;
    
    
    
    //CONFS
    public final static int AMOUNT_OF_CONFS = 72;
    public final static DateFormat FORMAT_CONF = new SimpleDateFormat("yyyy-MM-dd");
    public final static int MIN_CONF_SLOTS = 100;
    public final static int MAX_CONF_SLOTS = 300;
    public final static int MIN_DAYS_CONF = 0;
    public final static int MAX_DAYS_CONF = 4;
    public final static int MIN_DIFF_DAYS_CONF = 7;
    public final static int MAX_DIFF_DAYS_CONF = 21;
    public static String startConfDate = "2016-06-06";
    public static int conferenceId = 0;
    public static int currentConfDays;
    public static int currentConfSlots;


    //CONFRESERVATIONS
    public final static DateFormat formatwork = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    public final static int MIN_RES_CONF = 5;
    public final static int MAX_RES_CONF = 40;
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
    public static int confResID = 0;
    public static String currentConfResDate ="";
    public static Set<Integer> listOfClients;
    public static Set<Integer> listOfAdultsOnThisConf;
    public static Set<Integer> listOfStudentsOnThisConf;
    
    
    //CONFRESDETAILS    
    public static Set<Integer> listOfAdultsInThisRes;
    public static Set<Integer> listOfStudentsInThisRes;
    public static int adultID;
    public static int studentID;
    public static boolean makeWorkshopRes;
    
    
    //DAYS
    public static String currentDate;
    public static int dayId = 0;
    public static List<Integer> workshopsIDs;
    
    
    //PEOPLE
    public final static int DEC = 10;
    public final static String COUNTRY = "Polska";
    public final static int AMOUNT_OF_PEOPLE = 800;
    public final static int AMOUNT_OF_STUDENTS = 400;
    public final static int AMOUNT_OF_CLIENTS = 100;
    public static int companyCounter = -1;
    
    
    //PRICES
    public final static int PRICE_DAY_DIFF = 10;
    public static BigDecimal studentDisc = BigDecimal.valueOf(0.5);
    public static BigDecimal normalDisc = BigDecimal.valueOf(0.3);
    public static BigDecimal currentStudentDiscount;
    public static BigDecimal currentNormalDiscount;
    public static BigDecimal DIFF = BigDecimal.valueOf(0.02);
    public static int MIN_PRICE = 20;
    public static int MAX_PRICE = 300;
    public static int daysBefore = 30;
    public static int pricePerSlot;
    public static Record[] pricesTbl;
    public static Map<Integer, Integer> workPrices = new HashMap<>();
    public static BigDecimal onePaymentPrice;
    
    
    //PAYMENTS
    public final static int MAX_DELAY = 7;
    public static int amountOfPrices = 1;
    public static String dateOfPayment;
    public static int daysToConf;
    public static int delay;
    public static BigDecimal priceForReservation;
 
    
    
    //WORKSHOPS
    public final static int DIFF_TIME_WORK = 30;           //minutes of interval
    public final static int MULTI_WORK = 5;
    public final static int MIN_WORKS = 2;
    public final static int MAX_WORKS = 6;
    public final static int MIN_PRICE_WORK = 0;
    public final static int MAX_PRICE_WORK = 40;
    public final static int MIN_SLOTS_WORK = 5;
    public static int MAX_SLOTS_WORK;
    public static int AmountOfWorks;
    public static int workshopId = 0;
    public static int currentSlotsWork;
    public static int currentPriceWork;
    public static String startDateWork;
    public static String endDateWork;
    public static String timeWork;
    public static List<Integer> listOfWorkshops;
    public static List<Integer> listOfWorkshopSlots;
    
    //WORKRESERVATION
    public static int workResId = 0;
    public static int workResWorkId;
    public static int workResWorkSlots;




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
            "Azoty", "PGE", "PKP", "Grupa Żywiec", "Valeo", "Żabka", "Mostostal", "Cyfrowy Polsat",
            "Helion", "Polimex", "Gaspol", "PK", "Coursera", "PWN", "FreshMarket", "Medicover",
            "Transient", "Comarch", "UdaCity", "SoundCloud", "MarketDevs", "Disney", "Pixar", "Chevrolet", "EA"
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
        public BigDecimal adultPrice;
        public BigDecimal studentPrice;


        public Record(int daysBefore, BigDecimal adultPrice, BigDecimal studentPrice) {
            this.daysBefore = daysBefore;
            this.adultPrice = adultPrice;
            this.studentPrice = studentPrice;
        }

        public int getDaysBefore() {
            return daysBefore;
        }

        public void setDaysBefore(int daysBefore) {
            this.daysBefore = daysBefore;
        }

        public BigDecimal getAdultPrice() {
            return adultPrice;
        }

        public void setAdultPrice(BigDecimal adultPrice) {
            this.adultPrice = adultPrice;
        }

        public BigDecimal getStudentPrice() {
            return studentPrice;
        }

        public void setStudentPrice(BigDecimal studentPrice) {
            this.studentPrice = studentPrice;
        }
    }
}
