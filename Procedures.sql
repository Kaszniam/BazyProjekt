------------------------------------------PROCEDURES-------------------------------------------





--Osoby_dzien_konf(DayID) - pokazuje wszystkie osoby zapisane na dany dzien konferencji

CREATE PROCEDURE Osoby_dzien_konf
(
 @dayid int --DayID
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation AS cr
	ON cr.ConfResID = crd.ConfResID
	WHERE cr.DayID = @dayid AND cr.Cancelled = 0
GO



--Osoby_warsztat(WorkshopID) - pokazuje wszystkie osoby zapisane na dany warsztat

CREATE PROCEDURE Osoby_warsztat
(
 @workshopid int --DayID parametr
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN WorkResDetails AS wrd
	ON crd.ConfResID = wrd.WorkResID
	JOIn WorkReservation as wr
	ON wrd.WorkResID = wr.WorkResID
	WHERE wr.WorkShopID = @workshopid AND wr.Cancelled = 0
GO



--Generuj_id - generuje id dla osob na dany dzien konferencji

CREATE PROCEDURE Generuj_id
(
@dayid int --DayID
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



--Moje_konferencje - generuje dla osoby o podanym id liste konferencji w ktorych uczestniczy

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



--Moje_warsztaty - generuje dla osoby o podanym id liste konferencji w ktorych uczestniczy

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



--Platnosci_konferencja - wyswietla platnosci dla danego id konferencji

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



--Platnosci_rezerwacja - wyswietla platnosci dla danego id rezerwacji

CREATE PROCEDURE Platnosci_rezerwacja
(
@reservationid int 
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
	WHERE cr.ConfResID = @reservationid ANd cr.Cancelled = 0
	GROUP BY c.Name, conf.Name, cd.Date
GO



--Progi_cenowe - wyswietla progi cenowe dla danego id konferencji (ConferenceID)

CREATE PROCEDURE Progi_cenowe
(
@confid int
)
AS
	SELECT pr.DayID, pr.DaysBefore, FORMAT(pr.PricePerSlot*(1-pr.Discount), 'N', 'en-us') AS [Cena normalna],
	 FORMAT(pr.PricePerSlot*(1-pr.StudentDiscount), 'N', 'en-us') AS [Cena studencka] FROM Prices AS pr
	 JOIN ConfDays AS cd
	 ON pr.DayID = cd.DayID
	 WHERE cd.ConferenceID = @confid
GO



--Osoby_firma - wyswietla osoby z firmy o podanym id

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


--Dodaj_klient_prywatny - dodaje prywatnego klienta (imie, tel, adres, miasto, kod, kraj, studentid)

CREATE PROCEDURE Dodaj_klient_prywatny
(
@imie nvarchar(50),
@tel nvarchar(12),
@adres nvarchar(50),
@miasto nvarchar(50),
@kod nvarchar(6),
@kraj nvarchar(50),
@studentid nvarchar(50)
)
AS
	INSERT INTO Clients VALUES(0, @imie, @tel, @adres, @miasto, @kod, @kraj, @studentid, NULL)
GO



--Dodaj_klient_firma - dodaje firme (imie,tel, adres, miasto, kod, kraj, nip)

CREATE PROCEDURE Dodaj_klient_firma
(
@imie nvarchar(50),
@tel nvarchar(12),
@adres nvarchar(50),
@miasto nvarchar(50),
@kod nvarchar(6),
@kraj nvarchar(50),
@nip nvarchar(50)
)
AS
	INSERT INTO Clients VALUES(1, @imie, @tel, @adres, @miasto, @kod, @kraj, NULL, @nip)
GO



--Zmien_dane_prywatny- zmienia dane klienta prywatnego, jesli czegos nie zmienia przekazujemy null

CREATE PROCEDURE Zmien_dane_prywatny
(
@id int,
@imie nvarchar(50)=NULL,
@tel nvarchar(12)=NULL,
@adres nvarchar(50)=NULL,
@miasto nvarchar(50)=NULL,
@kod nvarchar(6)=NULL,
@kraj nvarchar(50)=NULL,
@studentid nvarchar(50)=NULL
)
AS
	IF @imie IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Name = @imie
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @tel IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Phone = @tel
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @adres IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Adress = @adres
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @miasto IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.City = @miasto
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @kod IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.PostalCode = @kod
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @kraj IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Country = @kraj
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END

	IF @studentid IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.StudentID = @studentid
		WHERE Clients.ClientID = @id AND Clients.Company = 0
	END
GO



--Zmien_dane_firma- zmienia dane firmy, jesli czeogs nie zmienia przekazujemy null

CREATE PROCEDURE Zmien_dane_firma
(
@id int,
@imie nvarchar(50)=NULL,
@tel nvarchar(12)=NULL,
@adres nvarchar(50)=NULL,
@miasto nvarchar(50)=NULL,
@kod nvarchar(6)=NULL,
@kraj nvarchar(50)=NULL,
@nip nvarchar(50)=NULL
)
AS
	IF @imie IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Name = @imie
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @tel IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Phone = @tel
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @adres IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Adress = @adres
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @miasto IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.City = @miasto
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @kod IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.PostalCode = @kod
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @kraj IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.Country = @kraj
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END

	IF @nip IS NOT NULL
	BEGIN
		UPDATE Clients
		SET Clients.NIP = @nip
		WHERE Clients.ClientID = @id AND Clients.Company = 1
	END
GO



--Dodaj_osoba - dodaje osobe (imie, nazwisko, studentid)

CREATE PROCEDURE Dodaj_osoba
(
@imie nvarchar(50),
@nazwisko nvarchar(50),
@studentid nvarchar(50)
)
AS
	INSERT INTO People VALUES(@imie, @nazwisko, @studentid)
GO



--Zmien_student - zmienia studentid danej osobie (PersonID, studentID)

CREATE PROCEDURE Zmien_student
(
@id int,
@studentid nvarchar(50)
)
AS
	UPDATE People
	SET People.StudentID = @studentid
	WHERE People.PersonID = @id
GO
	


--Dodaj_konferencje - dodaje konferencje (nazwa, opis, start, koniec, domyslna ilosc miejsc), pododawac confDayitd

CREATE PROCEDURE Dodaj_konferencje
(
@nazwa nvarchar(50),
@opis text,
@start date,
@koniec date,
@slots int
)
AS
	INSERT INTO Conferences VALUES (@nazwa, @opis, @start, @koniec,0);
	DECLARE @days int  = DATEDIFF(DAY, @start, @koniec) + 1;
	DECLARE @cnt int = 0;
	DECLARE @currentDate date = @start;
	DECLARE @confId int = (SELECT ConferenceID FROM Conferences WHERE Name = @nazwa AND StartDate = @start AND EndDate = @koniec);
	WHILE @cnt < @days
	BEGIN
		INSERT INTO ConfDays VALUES(@confId, @slots, @currentDate);
		SET @currentDate = DATEADD(DAY, 1, @currentDate);
		SET @cnt = @cnt + 1;
	END;
GO



--Zmien_ilosc_miejsc_konf - zmienia ilosc miejsc w dniu o podanym dayid (dayid, slots)

CREATE PROCEDURE zmien_ilosc_miejsc_konf
(
@dayid int,
@slots int
)
AS
	UPDATE ConfDays
	SET	ConfDays.Slots = @slots
	WHERE ConfDays.DayID = @dayid
GO



--Dodaj_rezerwacja_konf - dodaje rezerwacje klienta na konferencje na ustalona ilosc miejsc (ClientID, DayId, Slots)

CREATE PROCEDURE Dodaj_rezerwacja_konf
(
@clientid int,
@dayid int,
@slots int
)
AS
	INSERT INTO ConfReservation VALUES (@clientid, @dayid, GETDATE(), @slots, 0)
GO



--Dodaj_osoba_do_rez_konf - dodaje osobe do rezerwacji na konferencje (confResID, PersonID)

CREATE PROCEDURE Dodaj_osoba_do_rez_konf
(
@confresid int,
@personid int
)
AS
	INSERT INTO ConfResDetails VALUES(@confresid, @personid, (SELECT StudentID FROM People WHERE PersonID = @personid))
GO



--Dodaj_prog_cenowy - dodaje prog cenowy do konferencji (dayid, dni przed, znizka, studencka, cena standard)

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



--Dodaj_warsztat - dodaje warsztat (dayid, opis, miejsca, start, koniec, cena)

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



--Dodaj_rezerwacja_wars - dodaje rezerwacje na dany warsztat dla danej rezerwacji z konferencji na okreslona ilosc miejsc (WorkshopID, confResID, Slots)

CREATE PROCEDURE Dodaj_rezerwacja_wars
(
@workid int,
@confresid int,
@slots int
)
AS
	INSERT INTO WorkReservation VALUES (@workid, @confresid, GETDATE(), @slots, 0)
GO



--Zmien_miejsca_wars - zmienia ilosc miejsc na dany warsztat (workshopId, slots)

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

--Dodaj_osoba_do_rez_wars - dodaje osobe do rezerwacji na warsztat (WorkResID, PersonID)

CREATE PROCEDURE Dodaj_osoba_do_rez_wars
(
@workresid int,
@personid int
)
AS
	INSERT INTO WorkResDetails VALUES(@workresid, @personid, (SELECT ConfResID FROM WorkReservation WHERE WorkResId = @workresid))
GO


--Anuluj_konferencja - anuluje konferencje (ConferenceID). UWAGA! ANULUJAC KONFERENCJE ANUUJEMY WARSZTATY I WSZYSTKIE REZERWACJE!

CREATE PROCEDURE Anuluj_konferencja 
(
@confid int
)
AS
	--konferencja
	UPDATE Conferences
	SET Conferences.Cancelled = 1
	WHERE ConferenceID = @confid
	
	--rezerwacje konferencja
	UPDATE cr
	SET cr.Cancelled =1
	FROM ConfReservation AS cr
		JOIN ConfDays AS cd
		ON cr.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @confid
		
	--warsztaty
	UPDATE w
	SET w.Cancelled = 1
	FROM WorkShops AS w
		JOIN ConfDays AS cd
		ON w.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @confid

	--rezerwacje warsztaty
	UPDATE wr
	SET wr.Cancelled = 1
	FROM WorkReservation AS wr
		JOIN ConfReservation AS cr
		ON wr.ConfResID = cr.ConfResID
		JOIN ConfDays AS cd
		ON cr.DayID = cd.DayID
		JOIN Conferences AS c
		ON cd.ConferenceID = c.ConferenceID 
		WHERE c.ConferenceID = @confid
		
GO



--Anuluj_rezerwacja_konf - anuluje dana rezerwacje na konferencje (ConfResID) UWAGA! REZERWACJA NA WARSZTATY TAKZE IDZIE W ZAPOMNIENIE!

CREATE PROCEDURE Anuluj_rezerwacja_konf
(
@confresid int
)
AS
	--konferencja rezerwacja
	UPDATE ConfReservation
	SET ConfReservation.Cancelled = 1
	WHERE ConfResID = @confresid

	--warsztat rezerwacja
	UPDATE WorkReservation
	SET WorkReservation.Cancelled = 1
	WHERE ConfResID = @confresid
GO



--Anuluj_warsztat - anuluje warsztat (WorkshopID) UWAGA! REZERWACJE NA TEN WARSZTAT TAKZE!

CREATE PROCEDURE Anuluj_warsztat
(
@workid int
)
AS
	--warsztat
	UPDATE Workshops
	SET Workshops.Cancelled = 1
	WHERE WorkshopID = @workid

	--workreservation
	UPDATE WorkReservation
	SET WorkReservation.Cancelled = 1
	WHERE WorkshopID = @workid
GO



--Anuluj_rezerwacja_warsztat - anuluje rezerwacje na warsztat (WorkResID) PRZY REZERWACJACH WARTO UWZGLEDNIC AKTUALIZACJE CEN

CREATE PROCEDURE Anuluj_rezerwacja_warsztat
(
@workresid int
)
AS
		UPDATE WorkReservation
		SET WorkReservation.Cancelled = 1
		WHERE WorkResID = @workresid
GO



--pokaz_rezerwacja_konf - pokazuje liste osob z danej rezerwacji na konferencje (ConfResID)

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



--Pokaz_rezerwacja_wars - pokazuje liste osob z danej rezerwacji na warsztat (WorkResID)

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
