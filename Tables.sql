--------------------------------------------TABLES---------------------------------------------

-- Table: Clients
CREATE TABLE Clients (
    ClientID int  NOT NULL IDENTITY(1,1),
    Company tinyint  NOT NULL CHECK(Clients.Company LIKE '[0-1]'),
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

INSERT INTO Clients VALUES (0, 'Ala B', '+48930393748', 'Krakowska1', 'Krakow', '31-552', 'Poland', NULL, NULL)
INSERT INTO Clients VALUES (1, 'Geje', '+48930587748', 'Kraska1', 'Krakow', '31-452', 'Poland', NULL, '3049489032')
INSERT INTO Clients VALUES (0, 'Michasia dwa', '+48272920938', 'Podchorazych2', 'Warszawa' ,'00-123', 'Poland', '239940', NULL)

SELECT * FROM Clients



-- Table: People
CREATE TABLE People (
    PersonID int  NOT NULL IDENTITY(1,1),
    FirstName nvarchar(50)  NOT NULL,
    LastName nvarchar(50)  NOT NULL,
    StudentID nvarchar(50)  NULL,
    CONSTRAINT People_pk PRIMARY KEY  (PersonID)
)
;

INSERT INTO People VALUES ('1p', '1n', NULL)
INSERT INTO People VALUES ('2p', '2n', NULL)
INSERT INTO People VALUES ('3p', '3n', '324432')
INSERT INTO People VALUES ('4p', '4n', NULL)
INSERT INTO People VALUES ('5p', '5n', NULL)
INSERT INTO People VALUES ('6p', '6n', '123432')
INSERT INTO People VALUES ('7p', '7n', NULL)
INSERT INTO People VALUES ('8p', '8n', '345453')
INSERT INTO People VALUES ('9p', '9n', NULL)
INSERT INTO People VALUES ('10p', '10n', NULL)
INSERT INTO People VALUES ('11p', '11n', '240432')
INSERT INTO People VALUES ('12p', '12n', NULL)
INSERT INTO People VALUES ('13p', '13n', NULL)
INSERT INTO People VALUES ('14p', '14n', '123412')
INSERT INTO People VALUES ('51p', '15n', NULL)

SELECT * FROM People ORDER BY PersonID



-- Table: Conferences
CREATE TABLE Conferences (
    ConferenceID int  NOT NULL IDENTITY(1,1),
    Name nvarchar(50)  NOT NULL,
    Description varchar(255)  NULL,
    StartDate date  NOT NULL CHECK (StartDate >  GETDATE()),
    EndDate date  NOT NULL CHECK (EndDate >  GETDATE()),
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT ConferenceID_Unique UNIQUE (ConferenceID), --chyba zbedne przy identity
    CONSTRAINT StartDate_Unique UNIQUE (StartDate),
    CONSTRAINT EndDate_Unique UNIQUE (EndDate),
    CONSTRAINT Conferences_pk PRIMARY KEY  (ConferenceID),	
	CONSTRAINT StartDateEndDate_C CHECK (StartDate < EndDate)
)
;

INSERT INTO Conferences VALUES ('Grube melo', 'Bedzie fajnie', '2016/01/01', '2016/01/03', 0)
INSERT INTO Conferences VALUES ('W dzikich gaszczach', NULL, '2016/01/04', '2016/01/05', 0)
INSERT INTO Conferences VALUES ('Las i ptas', 'No tak', '2016/04/01', '2016/04/04', 0)

SELECT * FROM Conferences



-- Table: ConfDays
CREATE TABLE ConfDays (
    DayID int  NOT NULL IDENTITY(1,1),
    ConferenceID int  NOT NULL,
    Slots int  CHECK (Slots > 0) NOT NULL,
    Date date  NOT NULL,
    CONSTRAINT ConfDays_pk PRIMARY KEY  (DayID)
);

INSERT INTO ConfDays VALUES (1, 20, '2016/01/01')
INSERT INTO ConfDays VALUES (1, 20, '2016/01/02')
INSERT INTO ConfDays VALUES (1, 20, '2016/01/03')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/01')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/02')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/03')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/04')
INSERT INTO ConfDays VALUES (3, 30, '2016/01/04')
INSERT INTO ConfDays VALUES (3, 30, '2016/01/05')

SELECT * FROM ConfDays



-- Table: ConfReservation
CREATE TABLE ConfReservation (
    ConfResID int  NOT NULL IDENTITY(1,1),
    ClientID int  NOT NULL,
    DayID int  NOT NULL,
    ReservationDate DATETIME NOT NULL,
    Slots int CHECK(Slots > 0)  NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT ConfReservation_pk PRIMARY KEY  (ConfResID)
)
;

INSERT INtO ConfReservation VALUES (1,1, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (2,2, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (2,3, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (3,5, '2015/12/31', 10, 0)
INSERT INTO ConfReservation VALUES (3,1, '2015/12/31', 5, 0)

SELECT * FROM ConfReservation



-- Table: ConfResDetails
CREATE TABLE ConfResDetails (
    ConfResID int NOT NULL,
    PersonID int NOT NULL,
    StudentID nvarchar(50) NULL
)
;

SELECT * FROM ConfResDetails

INSERT INTO ConfResDetails VALUES (1,16, NULL)
INSERT INTO ConfResDetails VALUES (1,17, NULL)
INSERT INTO ConfResDetails VALUES (1,18, NULL)
INSERT INTO ConfResDetails VALUES (1,19, '123432')
INSERT INTO ConfResDetails VALUES (1,20, NULL)
INSERT INTO ConfResDetails VALUES (1,21, NULL)
INSERT INTO ConfResDetails VALUES (1,22, '123432')
INSERT INTO ConfResDetails VALUES (1,23, NULL)
INSERT INTO ConfResDetails VALUES (1,24, NULL)
INSERT INTO ConfResDetails VALUES (1,25, '123432')

INSERT INTO ConfResDetails VALUES (2,16, NULL)
INSERT INTO ConfResDetails VALUES (2,17, NULL)
INSERT INTO ConfResDetails VALUES (2,18, NULL)

INSERT INTO ConfResDetails VALUES (5,33,NULL)
INSERT INTO ConfResDetails VALUES (5,34,NULL)

SELECT * FROM ConfResDetails



-- Table: Prices
CREATE TABLE Prices (
    DayID int NOT NULL,
    DaysBefore int  NOT NULL CHECK (DaysBefore >= 0),
    Discount decimal(3,2) CHECK (Discount >= 0) NOT NULL,
    StudentDiscount decimal(3,2) CHECK(StudentDiscount >= 0)  NOT NULL,
    PricePerSlot decimal(15,2) CHECK (PricePerSlot >= 0)  NOT NULL
)
;

INSERT INTO Prices VALUES (1, 6, 0.2, 0.4, 50)
INSERT INTO Prices VALUES (1, 3, 0.15, 0.3, 50)
INSERT INTO Prices VALUES (2, 3, 0.15, 0.3, 60)

SELECT * FROM Prices



-- Table: PaymentDone
CREATE TABLE PaymentDone (
    PaymentID int  NOT NULL IDENTITY(1,1),
    ConfResID int  NOT NULL,
    Amount decimal(15,2) CHECK (PaymentDone.Amount > 0)  NOT NULL,
    Date date  NOT NULL,
    CONSTRAINT PaymentDone_pk PRIMARY KEY  (PaymentID)
)
;

INSERT INTO PaymentDone VALUES (1, 120, GETDATE())
INSERT INTO PaymentDone VALUES (1, 30, GETDATE())

SELECT * FROM PaymentDone



-- Table: Workshops
CREATE TABLE Workshops (
    WorkshopID int  NOT NULL IDENTITY(1,1),
    DayID int  NOT NULL,
    Description varchar(255)  NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
    StartTime datetime  NOT NULL CHECK (StartTime >  GETDATE()),
    EndTime datetime  NOT NULL CHECK (EndTime >  GETDATE()),
    PricePerSlot decimal(15,2) CHECK (PricePerSlot >= 0) NOT NULL,
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT WorkshopID_Unique UNIQUE (WorkshopID), --przy pk zbedne
    CONSTRAINT Workshops_pk PRIMARY KEY  (WorkshopID),
	CONSTRAINT StartTimeEndTime_W CHECK (StartTime < EndTime)
)
;

INSERT INTO Workshops VALUES (1, 'brak', 20, '2016/01/01 15:00', '2016/01/01 17:00', 0, 0)
INSERT INTO Workshops VALUES (1, 'brak', 20, '2016/01/01 16:00', '2016/01/01 19:00', 5, 0)
INSERT INTO Workshops VALUES (2, 'brak', 10, '2016/01/02 15:00', '2016/01/02 17:00', 0, 0)
INSERT INTO Workshops VALUES (2, 'brak', 10, '2016/01/02 15:00', '2016/01/01 17:00', 0, 0)

SELECT * FROM Workshops



-- Table: WorkReservation
CREATE TABLE WorkReservation (
    WorkResID int  NOT NULL IDENTITY(1,1),
    WorkshopID int  NOT NULL,
    ConfResID int  NOT NULL,
    ReservationDate DATETIME NOT NULL,
    Slots int  NOT NULL CHECK (Slots > 0),
    Cancelled tinyint NOT NULL DEFAULT 0,
    CONSTRAINT WorkReservation_pk PRIMARY KEY  (WorkResID)
)
;

INSERT INTO WorkReservation VALUES (2, 2, GETDATE(), 5, 0)
INSERT INTO WorkReservation VALUES (2, 1, GETDATE(), 6, 0)

SELECT * FROM WorkReservation



-- Table: WorkResDetails
CREATE TABLE WorkResDetails (
    WorkResID int  NOT NULL,
    PersonID int  NOT NULL,
    ConfResID int  NOT NULL
)
;

INSERT INTO WorkResDetails VALUES (2, 16, 2)
INSERT INTO WorkResDetails VALUES (2, 17, 2)
INSERT INTO WorkResDetails VALUES (2, 18, 2)

SELECT * FROM WorkResDetails





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

