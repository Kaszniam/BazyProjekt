------------------------------------------PROCEDURES-------------------------------------------

--Najczesciej_korzystajacy_z_uslug (Number) - pokazuje klientów najczesciej korzystaj¹cych z us³ug

CREATE PROCEDURE Najczesciej_korzystajacy_z_uslug
(
	@amount int 
)
AS
	SELECT Name AS [Klient],
	(SELECT COUNT(*)
	FROM ConfReservation
	WHERE (Clients.ClientID = ClientID) AND ConfReservation.Cancelled = 0) AS [Ile]
	FROM Clients
	GROUP BY ClientID, Name
	ORDER BY [Ile] DESC
GO



--Osoby_dzien_konf (DayID) - pokazuje wszystkie osoby zapisane na dany dzien konferencji

CREATE PROCEDURE Osoby_dzien_konf
(
 @dayid int
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation AS cr
	ON cr.ConfResID = crd.ConfResID
	WHERE cr.DayID = @dayid AND cr.Cancelled = 0
GO



--Osoby_warsztat (WorkshopID) - pokazuje wszystkie osoby zapisane na dany warsztat

CREATE PROCEDURE Osoby_warsztat
(
 @workshopid int
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN WorkResDetails AS wrd
	ON crd.ConfResID = wrd.WorkResID
	JOIn WorkReservation as wr
	ON wrd.WorkResID = wr.WorkResID
	WHERE wr.WorkshopID = @workshopid AND wr.Cancelled = 0
GO



--Osoby_klient (ClientID) - wyswietla osoby z firmy 

CREATE PROCEDURE Osoby_firma
(
@clientid int
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p .StudentID
	FROM People as p
	JOIN ConfResDetails as crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation as cr
	ON crd.ConfResID = cr.ConfResID
	JOIN Clients as c
	ON cr.ClientID = c.ClientID
	WHERE c.ClientID = @clientid
GO



--Generuj_id (DayID) - generuje id dla osob na dany dzien konferencji

CREATE PROCEDURE Generuj_id
(
@dayid int
)
AS
	SELECT p.FirstName, p.LastName,
	CAST(cr.DayID as nvarchar(5)) + '-' + CAST(cr.ConfResID as nvarchar(5)) + '-' + CAST(p.PersonID as nvarchar(5)) + SUBSTRING(p.FirstName, 0,5) + SUBSTRING(p.LastName,0,5) + '-' + SUBSTRING(c.Name, 0,4) AS [Identyfikator]
	FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation AS cr
	ON crd.ConfResID = cr.ConfResID
	JOIN Clients AS c
	ON cr.ClientID = c.ClientID
	WHERE cr.DayID = @dayid
GO



--Moje_konferencje (PersonID) - generuje dla osoby liste konferencji w ktorych uczestniczy

CREATE PROCEDURE Moje_konferencje
(
@personid int
)
AS
	SELECT p.FirstName AS [Imie], p.LastName AS [Nazwisko], c.Name AS [Nazwa konferencji]
	FROM People AS p
	JOIN ConfResDetails as crd
	ON p.PersonId= crd.PersonID
	JOIN ConfReservation as cr
	ON crd.ConfResID = cr.ConfResID
	JOIN ConfDays as cd
	ON cr.DayID = cd.DayID
	JOIN Conferences AS c
	ON cd.ConferenceID = c.ConferenceID
	WHERE p.PersonID = @personid
GO



--Moje_warsztaty (PersonID) - generuje dla osoby liste konferencji w ktorych uczestniczy

CREATE PROCEDURE Moje_warsztaty
(
@personid int
)
AS
	SELECT p.FirstName AS [Imie], p.LastName AS [Nazwisko], w.Description AS [Nazwa Warsztatu]
	FROM People AS p
	JOIN WorkResDetails AS wrd
	ON p.PersonID = wrd.PersonID
	JOIN WorkReservation AS wr
	ON wrd.WorkResId = wr.WorkResId
	JOIN Workshops AS w
	ON wr.WorkshopID = w.WorkshopID
	WHERE p.PersonID = @personid
GO



--Platnosci_konferencja(ConferenceID) - wyswietla platnosci dla konferencji

CREATE PROCEDURE Platnosci_konferencja
(
@conferenceid int
)
AS
	SELECT c.Name AS [Nazwa klienta], conf.Name AS [Nazwa konferencji], cd.Date AS [Dzieñ konferencji], SUM(pd.Amount) AS [P³atnoœci Dokonane]
	FROM Conferences AS conf
	JOIN ConfDays AS cd
	ON conf.ConferenceId = cd.ConferenceID
	JOIN ConfReservation AS cr
	ON cd.DayID  = cr.DayID
	JOIN Clients as c
	ON cr.ClientID = c.ClientID
	JOIN PaymentDone as pd
	ON cr.ConfResID = pd.ConfResID
	WHERE conf.ConferenceID = @conferenceid ANd cr.Cancelled = 0
	GROUP BY c.Name, conf.Name, cd.Date
GO



--Platnosci_rezerwacja(ConfResID) - wyswietla platnosci dla rezerwacji

CREATE PROCEDURE Platnosci_rezerwacja
(
@confresid int
)
AS
	SELECT c.Name AS [Nazwa klienta], conf.Name AS [Nazwa konferencji], cd.Date AS [Dzieñ konferencji], SUM(pd.Amount) AS [P³atnoœci Dokonane]
	FROM Conferences AS conf
	JOIN ConfDays AS cd
	ON conf.ConferenceId = cd.ConferenceID
	JOIN ConfReservation AS cr
	ON cd.DayID  = cr.DayID
	JOIN Clients as c
	ON cr.ClientID = c.ClientID
	JOIN PaymentDone as pd
	ON cr.ConfResID = pd.ConfResID
	WHERE cr.ConfResID = @confresid ANd cr.Cancelled = 0
	GROUP BY c.Name, conf.Name, cd.Date
GO



--Progi_cenowe (ConferenceID)- wyswietla progi cenowe dla konferencji 

CREATE PROCEDURE Progi_cenowe
(
@conferenceid int
)
AS
	SELECT pr.DayID, pr.DaysBefore, FORMAT(pr.PricePerSlot*(1-pr.Discount), 'N', 'en-us') AS [Cena normalna],
	 FORMAT(pr.PricePerSlot*(1-pr.StudentDiscount), 'N', 'en-us') AS [Cena studencka] FROM Prices AS pr
	 JOIN ConfDays AS cd
	 ON pr.DayID = cd.DayID
	 WHERE cd.ConferenceID = @conferenceid
GO



--Dodaj_prog_cenowy(DayID, DaysBefore, Discount, StudentDiscount, PricePerSlot) - dodaje prog cenowy do konferencji

CREATE PROCEDURE Dodaj_prog_cenowy
(
@dayid int,
@daysbefore int,
@discount decimal(3,2),
@studentdisc decimal(3,2),
@price money
)
AS
	INSERT INTO Prices VALUES(@dayid, @daysbefore, @discount, @studentdisc, @price)
GO




--Dodaj_klient_prywatny (Name, Phone, Adress, City, PostalCode, Country, StudentID) - dodaje prywatnego klienta 

CREATE PROCEDURE Dodaj_klient_prywatny
(
@name nvarchar(50),
@phone nvarchar(12),
@adress nvarchar(50),
@city nvarchar(50),
@postalcode nvarchar(6),
@country nvarchar(50),
@studentid nvarchar(50)
)
AS
	INSERT INTO Clients VALUES(0, @name, @phone, @adress, @city, @postalcode, @country, @studentid, NULL)
GO



--Dodaj_klient_firma (Name, Phone, Adress, City, PostalCode, Country, NIP) - dodaje nową firmę

CREATE PROCEDURE Dodaj_klient_firma
(
@name nvarchar(50),
@phone nvarchar(12),
@adress nvarchar(50),
@city nvarchar(50),
@postalcode nvarchar(6),
@country nvarchar(50),
@nip nvarchar(50)
)
AS
	INSERT INTO Clients VALUES(1, @name, @phone, @adress, @city, @postalcode, @country, NULL, @nip)
GO



--Zmien_dane_prywatny (ClientID, Data*) - zmienia podane dane klienta prywatnego

CREATE PROCEDURE Zmien_dane_prywatny
(
@clientid int,
@name nvarchar(50)=NULL,
@phone nvarchar(12)=NULL,
@adress nvarchar(50)=NULL,
@city nvarchar(50)=NULL,
@postalcode nvarchar(6)=NULL,
@country nvarchar(50)=NULL,
@studentid nvarchar(50)=NULL
)
AS
	IF @name IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Name = @name
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END

	IF @phone IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Phone = @phone
		WHERE Clients.ClientID = @clientidAND Clients.Company = 0
	END

	IF @adress IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Adress = @adress
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END

	IF @city IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.City = @city
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END

	IF @postalcode IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.PostalCode = @postalcode
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END

	IF @country IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Country = @country
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END

	IF @studentid IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.StudentID = @studentid
		WHERE Clients.ClientID = @clientid AND Clients.Company = 0
	END
GO



--Zmien_dane_firma (ClientID, Data*) - zmienia podane dane firmy

CREATE PROCEDURE Zmien_dane_firma
(
@clientid int,
@name nvarchar(50)=NULL,
@phone nvarchar(12)=NULL,
@adress nvarchar(50)=NULL,
@city nvarchar(50)=NULL,
@postalcode nvarchar(6)=NULL,
@country nvarchar(50)=NULL,
@nip nvarchar(50)=NULL
)
AS
	IF @name IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Name = @name
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @phone IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Phone = @phone
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @adress IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Adress = @adress
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @city IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.City = @city
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @postalcode IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.PostalCode = @postalcode
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @country IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Country = @country
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END

	IF @nip IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.NIP = @nip
		WHERE Clients.ClientID = @clientid AND Clients.Company = 1
	END
GO



--Dodaj_osoba (FirstName, LastName, StudentID) - dodaje osobe 

CREATE PROCEDURE Dodaj_osoba
(
@firstname nvarchar(50),
@lastname nvarchar(50),
@studentid nvarchar(50)
)
AS
	INSERT INTO People VALUES(@firstname, @lastname, @studentid)
GO



--Zmien_student (PersonID, StudentID) - zmienia nr legitymacji danej osobie 

CREATE PROCEDURE Zmien_student
(
@personid int,
@studentid nvarchar(50)
)
AS
	UPDATE People
	SET People.StudentID = @studentid
	WHERE People.PersonID = @personid
GO
	


--Dodaj_konferencje (Name, Description, StartDate, EndDate, Slots) - tworzy nową konferencje

CREATE PROCEDURE Dodaj_konferencje
(
@name nvarchar(50),
@description text,
@startdate date,
@enddate date,
@slots int
)
AS
	INSERT INTO Conferences VALUES (@name, @description, @startdate, @enddate,0);
	DECLARE @days int  = DATEDIFF(DAY, @startdate, @enddate) + 1;
	DECLARE @cnt int = 0;
	DECLARE @currentDate date = @startdate;
	DECLARE @confId int = (SELECT ConferenceID FROM Conferences WHERE Name = @name AND StartDate = @start AND EndDate = @koniec);
	WHILE @cnt < @days
	BEGIN
		INSERT INTO ConfDays VALUES(@confId, @slots, @currentDate);
		SET @currentDate = DATEADD(DAY, 1, @currentDate);
		SET @cnt = @cnt + 1;
	END;
GO



--Zmien_ilosc_miejsc_konf (DayID, Slots) - zmienia ilosc miejsc na konferencje w danym dniu

CREATE PROCEDURE Zmien_ilosc_miejsc_konf
(
@dayid int,
@slots int
)
AS
	UPDATE ConfDays
	SET	ConfDays.Slots = @slots
	WHERE ConfDays.DayID = @dayid
GO



--Anuluj_konferencja (ConferenceID) - anuluje konferencje i wszystko co z nią związane 

CREATE PROCEDURE Anuluj_konferencja 
(
@conferenceid int
)
AS
	--conf
	UPDATE Conferences
	SET Conferences.Cancelled = 1
	WHERE ConferenceID = @conferenceid
	
	--confres
	UPDATE cr
	SET cr.Cancelled =1
	FROM ConfReservation AS cr
		JOIN ConfDays AS cd
		ON cr.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @conferenceid
		
	--work
	UPDATE w
	SET w.Cancelled = 1
	FROM WorkShops AS w
		JOIN ConfDays AS cd
		ON w.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @conferenceid

	--workres
	UPDATE wr
	SET wr.Cancelled = 1
	FROM WorkReservation AS wr
		JOIN ConfReservation AS cr
		ON wr.ConfResID = cr.ConfResID
		JOIN ConfDays AS cd
		ON cr.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @conferenceid
		
GO



--Dodaj_rezerwacja_konf (ClientID, DayID, Slots) - dodaje rezerwacje na konferencje

CREATE PROCEDURE Dodaj_rezerwacja_konf
(
@clientid int,
@dayid int,
@slots int
)
AS
	INSERT INTO ConfReservation VALUES (@clientid, @dayid, GETDATE(), @slots, 0)
GO



--Dodaj_osoba_do_rez_konf (ConfResID, PersonID) - dodaje osobe do rezerwacji na konferencje

CREATE PROCEDURE Dodaj_osoba_do_rez_konf
(
@confresid int,
@personid int
)
AS
	INSERT INTO ConfResDetails VALUES(@confresid, @personid, (SELECT StudentID FROM People WHERE PersonID = @personid))
GO



--Pokaz_rezerwacja_konf (ConfResID) - pokazuje liste osob z danej rezerwacji na konferencje

CREATE PROCEDURE Pokaz_rezerwacja_konf
(
@confresid int
)
AS
	SELECT p.FirstName, p.LastName, p.StudentID, cr.Cancelled
	FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation AS cr
	ON crd.ConfResID = cr.ConfResID
	WHERE cr.ConfResID = @confresid
GO



--Anuluj_rezerwacja_konf (ConfResID) - anuluje dana rezerwacje na konferencje i warsztaty z tej rezerwacji

CREATE PROCEDURE Anuluj_rezerwacja_konf
(
@confresid int
)
AS
	--confres
	UPDATE ConfReservation
	SET ConfReservation.Cancelled = 1
	WHERE ConfResID = @confresid

	--workres
	UPDATE WorkReservation
	SET WorkReservation.Cancelled = 1
	WHERE ConfResID = @confresid
GO



--Dodaj_warsztat (DayID, Description, Slots, StartTime, EndTime, Price) - dodaje warsztat

CREATE PROCEDURE Dodaj_warsztat
(
@dayid int,
@desc text,
@slots int,
@starttime datetime,
@endtime datetime,
@price money
)
AS
	INSERT INTO Workshops VALUES(@dayid, @desc, @slots, @starttime, @endtime, @price, 0)
GO



--Zmien_miejsca_wars ( - zmienia ilosc miejsc na dany warsztat (workshopId, slots)

CREATE PROCEDURE Zmien_miejsca_wars
(
@workid int,
@slots int
)
AS
		UPDATE Workshops
		SET	Workshops.Slots = @slots
		WHERE WorkshopID = @workid
GO



--Anuluj_warsztat (WorkshopID) - anuluje warsztat i wszystkie rezerwacje na niego

CREATE PROCEDURE Anuluj_warsztat
(
@workshopid int
)
AS
	--warsztat
	UPDATE Workshops
	SET Workshops.Cancelled = 1
	WHERE WorkshopID = @workshopid

	--workreservation
	UPDATE WorkReservation
	SET WorkReservation.Cancelled = 1
	WHERE WorkshopID = @workshopid
GO


		
--Dodaj_rezerwacja_wars (WorkshopID, ConfResId, Slots) - dodaje rezerwacje na dany warsztat z danej rezerwacji na konferencje

CREATE PROCEDURE Dodaj_rezerwacja_wars
(
@workid int,
@confresid int,
@slots int
)
AS
	INSERT INTO WorkReservation VALUES (@workid, @confresid, GETDATE(), @slots, 0)
GO



--Dodaj_osoba_do_rez_wars (WorkResID, PersonID) - dodaje osobe do rezerwacji na warsztat

CREATE PROCEDURE Dodaj_osoba_do_rez_wars
(
@workresid int,
@personid int
)
AS
	INSERT INTO WorkResDetails VALUES(@workresid, @personid, (SELECT ConfResID FROM WorkReservation WHERE WorkResId = @workresid))
GO



--Pokaz_rezerwacja_wars (WorkResID) - pokazuje liste osob z danej rezerwacji na warsztat 

CREATE PROCEDURE Pokaz_rezerwacja_wars
(
@workresid int
)
AS
	SELECT p.FirstName, p.LastName, p.StudentID, wr.Cancelled
	FROM People AS p
	JOIN WorkResDetails AS wrd
	ON p.PersonID = wrd.PersonID
	JOIN WorkReservation AS wr
	ON wrd.WorkResID = wr.WorkResID
	WHERE wr.WorkResID = @workresid
GO



--Anuluj_rezerwacja_warsztat (WorkResID) - anuluje rezerwacje na warsztat PRZY REZERWACJACH WARTO UWZGLEDNIC AKTUALIZACJE CEN

CREATE PROCEDURE Anuluj_rezerwacja_warsztat
(
@workresid int
)
AS
		UPDATE WorkReservation
		SET WorkReservation.Cancelled = 1
		WHERE WorkResID = @workresid
GO



--Policz_cena_osoba (PersonID) - liczy cene osoby za jego konferencje i warsztaty



--Policz_cena_rezerwacja (ConfResID) - liczy cene dla danej rezerwacji za konferencje i warsztaty 

