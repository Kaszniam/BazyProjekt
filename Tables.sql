--------------------------------------------TABLES---------------------------------------------

-- Table: Clients
CREATE TABLE Clients (
    ClientID int  NOT NULL IDENTITY(1,1),
    Company tinyint  NOT NULL CHECK(Clients.Company LIKE '[0-1]'),
    Name nvarchar(50)  NOT NULL,
    Phone nvarchar(12)  NOT NULL CHECK(Clients.Phone LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    Adress nvarchar(50)  NOT NULL,
    City nvarchar(50)  NOT NULL,
    PostalCode nvarchar(6)  NOT NULL CHECK(Clients.PostalCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
    Country nvarchar(50)  NOT NULL,
    StudentID nvarchar(50)  NULL,
    NIP nvarchar(50)  NULL,
    CONSTRAINT Clients_pk PRIMARY KEY  (ClientID)
)
;



-- Table: People
CREATE TABLE People (
    PersonID int  NOT NULL IDENTITY(1,1),
    FirstName nvarchar(50)  NOT NULL,
    LastName nvarchar(50)  NOT NULL,
    StudentID nvarchar(50)  NULL,
    CONSTRAINT People_pk PRIMARY KEY  (PersonID)
)
;



-- Table: Conferences
CREATE TABLE Conferences (
    ConferenceID int  NOT NULL IDENTITY(1,1),
    Name nvarchar(50)  NOT NULL,
    Description nvarchar(255)  NULL,
    StartDate date  NOT NULL CHECK (StartDate >  GETDATE()),
    EndDate date  NOT NULL CHECK (EndDate >  GETDATE()),
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT ConferenceID_Unique UNIQUE (ConferenceID), --chyba zbedne przy identity
    CONSTRAINT StartDate_Unique UNIQUE (StartDate),
    CONSTRAINT EndDate_Unique UNIQUE (EndDate),
    CONSTRAINT Conferences_pk PRIMARY KEY  (ConferenceID),	
	CONSTRAINT StartDateEndDate_C CHECK (StartDate <= EndDate)
)
;



-- Table: ConfDays
CREATE TABLE ConfDays (
    DayID int  NOT NULL IDENTITY(1,1),
    ConferenceID int  NOT NULL,
    Slots int  CHECK (Slots > 0) NOT NULL,
    Date date  NOT NULL,
    CONSTRAINT ConfDays_pk PRIMARY KEY  (DayID)
);



-- Table: ConfReservation
CREATE TABLE ConfReservation (
    ConfResID int  NOT NULL IDENTITY(1,1),
    ClientID int  NOT NULL,
    DayID int  NOT NULL,
    ReservationDate DATE NOT NULL,
    Slots int CHECK(Slots > 0)  NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT ConfReservation_pk PRIMARY KEY  (ConfResID)
)
;



-- Table: ConfResDetails
CREATE TABLE ConfResDetails (
    ConfResID int NOT NULL,
    PersonID int NOT NULL,
    StudentID nvarchar(50) NULL
)
;



-- Table: Prices
CREATE TABLE Prices (
    DayID int NOT NULL,
    DaysBefore int  NOT NULL CHECK (DaysBefore >= 0),
    Discount decimal(3,2) CHECK (Discount >= 0) NOT NULL,
    StudentDiscount decimal(3,2) CHECK(StudentDiscount >= 0)  NOT NULL,
    PricePerSlot money CHECK (PricePerSlot >= 0)  NOT NULL
)
;



-- Table: PaymentDone
CREATE TABLE PaymentDone (
    PaymentID int  NOT NULL IDENTITY(1,1),
    ConfResID int  NOT NULL,
    Amount money CHECK (PaymentDone.Amount > 0)  NOT NULL,
    Date date  NOT NULL,
    CONSTRAINT PaymentDone_pk PRIMARY KEY  (PaymentID)
)
;



-- Table: Workshops
CREATE TABLE Workshops (
    WorkshopID int  NOT NULL IDENTITY(1,1),
    DayID int  NOT NULL,
    Description nvarchar(255)  NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
    StartTime datetime  NOT NULL CHECK (StartTime >  GETDATE()),
    EndTime datetime  NOT NULL CHECK (EndTime >  GETDATE()),
    PricePerSlot money CHECK (PricePerSlot >= 0) NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT WorkshopID_Unique UNIQUE (WorkshopID), --przy pk zbedne
    CONSTRAINT Workshops_pk PRIMARY KEY  (WorkshopID),
	CONSTRAINT StartTimeEndTime_W CHECK (StartTime < EndTime)
)
;



-- Table: WorkReservation
CREATE TABLE WorkReservation (
    WorkResID int  NOT NULL IDENTITY(1,1),
    WorkshopID int  NOT NULL,
    ConfResID int  NOT NULL,
    ReservationDate date NOT NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT WorkReservation_pk PRIMARY KEY  (WorkResID)
)
;




-- Table: WorkResDetails
CREATE TABLE WorkResDetails (
    WorkResID int  NOT NULL,
    PersonID int  NOT NULL,
    ConfResID int  NOT NULL
)
;




-- foreign keys
-- Reference:  ConfDays_Conferences (table: ConfDay)

ALTER TABLE ConfDays ADD CONSTRAINT ConfDays_Conferences 
    FOREIGN KEY (ConferenceID)
    REFERENCES Conferences (ConferenceID)
;

-- Reference:  ConfDiscounts_ConfDays (table: Prices)

ALTER TABLE Prices ADD CONSTRAINT ConfDiscounts_ConfDays 
    FOREIGN KEY (DayID)
    REFERENCES ConfDays (DayID)
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

-- Reference:  ConfReservation_ConfDays (table: ConfReservation)

ALTER TABLE ConfReservation ADD CONSTRAINT ConfReservation_ConfDays 
    FOREIGN KEY (DayID)
    REFERENCES ConfDays (DayID)
;

-- Reference:  PaymentDone_ConfReservation (table: PaymentDone)

ALTER TABLE PaymentDone ADD CONSTRAINT PaymentDone_ConfReservation 
    FOREIGN KEY (ConfResID)
    REFERENCES ConfReservation (ConfResID)
;

-- Reference:  WorkResDetails_ConfResDetails (table: WorkResDetails)

--ALTER TABLE WorkResDetails ADD CONSTRAINT WorkResDetails_ConfResDetails 
--  FOREIGN KEY (ConfResID,PersonID)
--  REFERENCES ConfResDetails (ConfResID,PersonID)
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

-- Reference:  Workshops_ConfDays (table: Workshops)

ALTER TABLE Workshops ADD CONSTRAINT Workshops_ConfDays 
    FOREIGN KEY (DayID)
    REFERENCES ConfDays (DayID)
;
