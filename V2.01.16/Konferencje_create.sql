<<<<<<< HEAD
=======
-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2015-12-23 13:14:46.113



>>>>>>> 340e76865007adbce25ae048430adc4aeec20138

CREATE TABLE Clients (
    ClientID int  NOT NULL IDENTITY(1,1),
    Company tinyint  NOT NULL,
    Name nvarchar(50)  NOT NULL,
    Phone nvarchar(50)  NOT NULL CHECK(Clients.Phone LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    Adress nvarchar(50)  NOT NULL,
    City nvarchar(50)  NOT NULL,
    PostalCode nvarchar(50)  NOT NULL CHECK(Clients.PostalCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
    Country nvarchar(50)  NOT NULL,
    StudentID nvarchar(50)  NULL,
    NIP nvarchar(50)  NULL,
    CONSTRAINT Clients_pk PRIMARY KEY  (ClientID)
)
;





-- Table: ConfDay
CREATE TABLE ConfDay (
    DayID int  NOT NULL IDENTITY(1,1),
    ConferenceID int  NOT NULL,
<<<<<<< HEAD
    Slots int  CHECK (Slots > 0) NOT NULL,
=======
    Slots int  NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    Date date  NOT NULL,
    CONSTRAINT ConfDay_pk PRIMARY KEY  (DayID)
)
;





-- Table: ConfResDetails
CREATE TABLE ConfResDetails (
    ConfResID int  NOT NULL,
    PersonID int  NOT NULL,
    StudentID nvarchar(50)  NOT NULL,
    CONSTRAINT ConfResDetails_pk PRIMARY KEY  (ConfResID,PersonID)
)
;





-- Table: ConfReservation
CREATE TABLE ConfReservation (
    ConfResID int  NOT NULL IDENTITY(1,1),
    ClientID int  NOT NULL,
    DayID int  NOT NULL,
    ReservationDate DATETIME NOT NULL,
<<<<<<< HEAD
    Slots int Check(Slots > 0)  NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
=======
    Slots int  NOT NULL,
    Cancelled tinyint  NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    CONSTRAINT ConfReservation_pk PRIMARY KEY  (ConfResID),
    CONSTRAINT Slots_CR CHECK (Slots > 0)
)
;





-- Table: Conferences
CREATE TABLE Conferences (
    ConferenceID int  NOT NULL IDENTITY(1,1),
    Name nvarchar(50)  NOT NULL,
    Description varchar(255)  NULL,
    StartDate date  NOT NULL CHECK (StartDate >  GETDATE()),
    EndDate date  NOT NULL CHECK (EndDate >  GETDATE()),
<<<<<<< HEAD
    Cancelled tinyint NOT NULL DEFAULT 0,
=======
    Cancelled tinyint  NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    CONSTRAINT ConferenceID_Unique UNIQUE (ConferenceID),
    CONSTRAINT StartDate_Unique UNIQUE (StartDate),
    CONSTRAINT EndDate_Unique UNIQUE (EndDate),
    CONSTRAINT Conferences_pk PRIMARY KEY  (ConferenceID)
)
;





-- Table: PaymentDone
CREATE TABLE PaymentDone (
    PaymentID int  NOT NULL IDENTITY(1,1),
    ConfResID int  NOT NULL,
    Amount decimal(15,2)  NOT NULL,
    Date date  NOT NULL,
    CONSTRAINT PaymentDone_pk PRIMARY KEY  (PaymentID),
	CONSTRAINT Amount_PD CHECK (Amount > 0)
)
;





-- Table: People
CREATE TABLE People (
    PersonID int  NOT NULL IDENTITY(1,1),
    FirstName nvarchar(50)  NOT NULL,
    LastName nvarchar(50)  NOT NULL,
    StudentID nvarchar(50)  NOT NULL,
    CONSTRAINT People_pk PRIMARY KEY  (PersonID)
)
;





-- Table: Prices
CREATE TABLE Prices (
    DayID int  NOT NULL IDENTITY(1,1),
<<<<<<< HEAD
    DaysBefore int  NOT NULL CHECK (DaysBefore >= 0),
    Discount decimal(3,2) CHECK (Discount >= 0) NOT NULL,
    StudentDiscount decimal(3,2) CHECK(StudentDiscount >= 0)  NOT NULL,
    PricePerSlot decimal(15,2) CHECK (PricePerSlot >= 0)  NOT NULL,
=======
    DaysBefore int  NOT NULL CHECK (DaysBefore > 0),
    Discount decimal(3,2)  NOT NULL,
    StudentDiscount decimal(3,2)  NOT NULL,
    PricePerSlot decimal(15,2)  NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    CONSTRAINT Prices_pk PRIMARY KEY  (DayID)
)
;





-- Table: WorkResDetails
CREATE TABLE WorkResDetails (
    WorkResID int  NOT NULL,
    PersonID int  NOT NULL,
    ConfResID int  NOT NULL,
    CONSTRAINT WorkResDetails_pk PRIMARY KEY  (WorkResID)
)
;





-- Table: WorkReservation
CREATE TABLE WorkReservation (
    WorkResID int  NOT NULL IDENTITY(1,1),
    WorkshopID int  NOT NULL,
    ConfResID int  NOT NULL,
    ReservationDate DATETIME NOT NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
<<<<<<< HEAD
    Cancelled tinyint NOT NULL DEFAULT 0,
=======
    Cancelled tinyint DEFAULT 0 NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    CONSTRAINT WorkReservation_pk PRIMARY KEY  (WorkResID)
)
;





-- Table: Workshops
CREATE TABLE Workshops (
    WorkshopID int  NOT NULL IDENTITY(1,1),
    DayID int  NOT NULL,
    Description varchar(255)  NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
    StartTime datetime  NOT NULL CHECK (StartTime >  GETDATE()),
    EndTime datetime  NOT NULL CHECK (EndTime >  GETDATE()),
<<<<<<< HEAD
    PricePerSlot decimal(15,2) CHECK (PricePerSlot >= 0) NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
=======
    PricePerSlot decimal(15,2)  NOT NULL,
    Cancelled tinyint  NOT NULL,
>>>>>>> 340e76865007adbce25ae048430adc4aeec20138
    CONSTRAINT WorkshopID_Unique UNIQUE (WorkshopID),
    CONSTRAINT Workshops_pk PRIMARY KEY  (WorkshopID),
	CONSTRAINT StartTimeEndTime_W CHECK (StartTime < EndTime)
)
;









-- foreign keys
-- Reference:  ConfDay_Conferences (table: ConfDay)

ALTER TABLE ConfDay ADD CONSTRAINT ConfDay_Conferences 
    FOREIGN KEY (ConferenceID)
    REFERENCES Conferences (ConferenceID)
;

-- Reference:  ConfDiscounts_ConfDay (table: Prices)

ALTER TABLE Prices ADD CONSTRAINT ConfDiscounts_ConfDay 
    FOREIGN KEY (DayID)
    REFERENCES ConfDay (DayID)
;

-- Reference:  ConfResDetails_ConfReservation (table: ConfResDetails)

ALTER TABLE ConfResDetails ADD CONSTRAINT ConfResDetails_ConfReservation 
    FOREIGN KEY (ConfResID)
    REFERENCES ConfReservation (ConfResID)
;

-- Reference:  ConfResDetails_People (table: ConfResDetails)

ALTER TABLE ConfResDetails ADD CONSTRAINT ConfResDetails_People 
    FOREIGN KEY (PersonID)
    REFERENCES People (PersonID)
;

-- Reference:  ConfReservation_Clients (table: ConfReservation)

ALTER TABLE ConfReservation ADD CONSTRAINT ConfReservation_Clients 
    FOREIGN KEY (ClientID)
    REFERENCES Clients (ClientID)
;

-- Reference:  ConfReservation_ConfDay (table: ConfReservation)

ALTER TABLE ConfReservation ADD CONSTRAINT ConfReservation_ConfDay 
    FOREIGN KEY (DayID)
    REFERENCES ConfDay (DayID)
;

-- Reference:  PaymentDone_ConfReservation (table: PaymentDone)

ALTER TABLE PaymentDone ADD CONSTRAINT PaymentDone_ConfReservation 
    FOREIGN KEY (ConfResID)
    REFERENCES ConfReservation (ConfResID)
;

-- Reference:  WorkResDetails_ConfResDetails (table: WorkResDetails)

ALTER TABLE WorkResDetails ADD CONSTRAINT WorkResDetails_ConfResDetails 
    FOREIGN KEY (ConfResID,PersonID)
    REFERENCES ConfResDetails (ConfResID,PersonID)
;

-- Reference:  WorkshopResDetails_WorkshopReservation (table: WorkResDetails)

ALTER TABLE WorkResDetails ADD CONSTRAINT WorkshopResDetails_WorkshopReservation 
    FOREIGN KEY (WorkResID)
    REFERENCES WorkReservation (WorkResID)
;

-- Reference:  WorkshopReservation_ConfReservation (table: WorkReservation)

ALTER TABLE WorkReservation ADD CONSTRAINT WorkshopReservation_ConfReservation 
    FOREIGN KEY (ConfResID)
    REFERENCES ConfReservation (ConfResID)
;

-- Reference:  WorkshopReservation_Workshops (table: WorkReservation)

ALTER TABLE WorkReservation ADD CONSTRAINT WorkshopReservation_Workshops 
    FOREIGN KEY (WorkshopID)
    REFERENCES Workshops (WorkshopID)
;

-- Reference:  Workshops_ConfDay (table: Workshops)

ALTER TABLE Workshops ADD CONSTRAINT Workshops_ConfDay 
    FOREIGN KEY (DayID)
    REFERENCES ConfDay (DayID)
;

