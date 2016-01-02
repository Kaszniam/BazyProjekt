------------------------------------------PROCEDURES-------------------------------------------

--Najczesciej_korzystajacy_z_uslug(ClientID - pokazuje klientów najczesciej korzystaj¹cych z us³ug

Najczesciej_korzystajacy_z_uslug 1
DROP PROCEDURE Najczesciej_korzystajacy_z_uslug

CREATE PROCEDURE 
(
	@param int --ClientID
)
AS
	SELECT Name AS 'Client',
	(SELECT COUNT(*)
	FROM ConfReservation
	WHERE (Clients.ClientID = ClientID) AND ConfReservation.Cancelled = 0) AS 'How many times:'
	FROM Clients
	GROUP BY ClientID, Name
	ORDER BY 'Ile razy wzi¹³ udzia³' DESC
GO

--osoby_dzien_konf(DayID) - pokazuje wszystkie osoby zapisane na dany dzien konferencji

Osoby_dzien_konf 1
DROP PROCEDURE Osoby_dzien_konf

CREATE PROCEDURE Osoby_dzien_konf
(
 @param int --DayID parametr
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN ConfReservation AS cr
	ON cr.ConfResID = crd.ConfResID
	WHERE cr.DayID = @param AND cr.Cancelled = 0
GO



--osoby_warsztat(WorkshopID) - pokazuje wszystkie osoby zapisane na dany warsztat

Osoby_warsztat 1
DROP PROCEDURE Osoby_warsztat

CREATE PROCEDURE Osoby_warsztat
(
 @param int --DayID parametr
)
AS
	SELECT p.PersonID, p.FirstName, p.LastName, p.StudentID FROM People AS p
	JOIN ConfResDetails AS crd
	ON p.PersonID = crd.PersonID
	JOIN WorkResDetails AS wrd
	ON crd.ConfResID = wrd.WorkResID
	JOIn WorkReservation as wr
	ON wrd.WorkResID = wr.WorkResID
	WHERE wr.WorkShopID = @param AND wr.Cancelled = 0
GO



--generuj_id - generuje id dla osob na dany dzien konferencji

generuj_id 1
DROP PROCEDURE generuj_id

CREATE PROCEDURE generuj_id
(
@param int --DayID
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
	WHERE cr.DayID = @param
GO



--moje_konferencje - generuje dla osoby o podanym id liste konferencji w ktorych uczestniczy

moje_konferencje 19
DROP PROCEDURE moje_konferencje

CREATE PROCEDURE moje_konferencje
(
@param int --PersonID
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
	WHERE p.PersonID = @param
GO



--moje_warsztaty - generuje dla osoby o podanym id liste konferencji w ktorych uczestniczy

moje_warsztaty 18
DROP PROCEDURE moje_warsztaty

CREATE PROCEDURE moje_warsztaty
(
@param int --PersonID
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
	WHERE p.PersonID = @param
GO



--platnosci_konferencja - wyswietla platnosci dla danego id konferencji

platnosci_konferencja 2
DROP PROCEDURE platnosci_konferencja

CREATE PROCEDURE platnosci_konferencja
(
@param int --ConferenceID
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
	WHERE conf.ConferenceID = @param ANd cr.Cancelled = 0
	GROUP BY c.Name, conf.Name, cd.Date
GO

--platnosci_rezerwacja - wyswietla platnosci dla danego id rezerwacji

platnosci_rezerwacja 2
DROP PROCEDURE platnosci_rezerwacja

CREATE PROCEDURE platnosci_rezerwacja
(
@param int --ReservationID
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
	WHERE cr.ConfResID = @param ANd cr.Cancelled = 0
	GROUP BY c.Name, conf.Name, cd.Date
GO


--progi_cenowe - wyswietla progi cenowe dla danego id konferencji (ConferenceID)

progi_cenowe 1
SELECT * FROM Prices
DROP PROCEDURE progi_cenowe

CREATE PROCEDURE progi_cenowe
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

--osoby_firma - wyswietla osoby z firmy o podanym id
CREATE PROCEDURE osoby_firma
(
@param int
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
	WHERE c.ClientID = @param
GO


--osoba_prywatny - wyswietl osoby od danej osoby o podanym id (z klientow)



--dodaj_klient_prywatny - dodaje prywatnego klienta (imie, tel, adres, miasto, kod, kraj, studentid)

dodaj_klient_prywatny 'pizderyja Ala', '+48223333000', 'Smieszna ulica', 'Krakow', '00-123', 'Polska', NULL
SELECT * FROM Clients
DROP PROCEDURE dodaj_klient_prywatny

CREATE PROCEDURE dodaj_klient_prywatny
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



--dodaj_klient_firma - dodaje firme (imie,tel, adres, miasto, kod, kraj, nip)

dodaj_klient_firma 'Stink ci', '+48666555333', 'Smieszna ulica 5', 'Krakow', '00-143', 'Polska', '3334445566'
SELECT * FROM Clients
DROP PROCEDURE dodaj_klient_firma

CREATE PROCEDURE dodaj_klient_firma
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



--zmien_dane_prywatny- zmienia dane klienta prywatnego, jesli czegos nie zmienia przekazujemy null

zmien_dane_prywatny 1, 'Alicja Ka', NULL, NULL, NULL, NULL, NULL, NULL
SELECT * FROM Clients
DROP PROCEDURE zmien_dane_prywatny

CREATE PROCEDURE zmien_dane_prywatny
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



--zmien_dane_firma- zmienia dane firmy, jesli czeogs nie zmienia przekazujemy null

zmien_dane_firma 2, NULL, NULL, 'Sliczna3', NULL, NULL, NULL, NULL
SELECT * FROM Clients
DROP PROCEDURE zmien_dane_firma

CREATE PROCEDURE zmien_dane_firma
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



--dodaj_osoba - dodaje osobe (imie, nazwisko, studentid)

dodaj_osoba 'Agnieszka', 'W³odarczyk', NULL
SELECT * FROM People
DROP PROCEDURE dodaj_osoba

CREATE PROCEDURE dodaj_osoba
(
@imie nvarchar(50),
@nazwisko nvarchar(50),
@studentid nvarchar(50)
)
AS
	INSERT INTO People VALUES(@imie, @nazwisko, @studentid)
GO



--zmien_student - zmienia studentid danej osobie (PersonID, studentID)

zmien_student 46, '223344'
SELECT * FROM People
DROP PROCEDURE zmien_student

CREATE PROCEDURE zmien_student
(
@id int,
@studentid nvarchar(50)
)
AS
	UPDATE People
	SET People.StudentID = @studentid
	WHERE People.PersonID = @id
GO
	


--dodaj_konferencje - dodaje konferencje (nazwa, opis, start, koniec, domyslna ilosc miejsc), pododawac confDayitd

dodaj_konferencje 'Zjazd kupy biskupa', 'no taak', '2016/06/08', '2016/06/11', 30
SELECT * FROM Conferences
SELECT * FROM ConfDays
DROP PROCEDURE dodaj_konferencje

CREATE PROCEDURE dodaj_konferencje
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



--zmien_ilosc_miejsc_konf - zmienia ilosc miejsc w dniu o podanym dayid (dayid, slots)

zmien_ilosc_miejsc_konf 2, 40
DROP PROCEDURE zmien_ilosc_miejsc_konf

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

--dodaj_rezerwacja_konf - dodaje rezerwacje klienta na konferencje na ustalona ilosc miejsc (ClientID, DayId, Slots)

dodaj_rezerwacja_konf 2, 2, 20
SELECT * FROM ConfReservation
DROP PROCEDURE dodaj_rezerwacja_konf

CREATE PROCEDURE dodaj_rezerwacja_konf
(
@clientid int,
@dayid int,
@slots int
)
AS
	INSERT INTO ConfReservation VALUES (@clientid, @dayid, GETDATE(), @slots, 0)
GO


--dodaj_osoba_do_rez_konf - dodaje osobe do rezerwacji na konferencje (confResID, PersonID)

dodaj_osoba_do_rez_konf 1, 9
SELECT * FROM ConfResDetails
DROP PROCEDURE dodaj_osoba_do_rez_konf

CREATE PROCEDURE dodaj_osoba_do_rez_konf
(
@confresid int,
@personid int
)
AS
	INSERT INTO ConfResDetails VALUES(@confresid, @personid, (SELECT StudentID FROM People WHERE PersonID = @personid))
GO



--dodaj_prog_cenowy - dodaje prog cenowy do konferencji (dayid, dni przed, znizka, studencka, cena standard)

dodaj_prog_cenowy 1, 10, 0.1, 0.2, 100
SELECT * FROM Prices
DROP PROCEDURE dodaj_prog_cenowy

CREATE PROCEDURE dodaj_prog_cenowy
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



--dodaj_warsztat - dodaje warsztat (dayid, opis, miejsca, start, koniec, cena)

dodaj_warsztat 1, 'Chujowy warsztat', 20, '2016/01/01 12:00', '2016/01/01 14:00', 30
SELECT * FROM Workshops
DROP PROCEDURE dodaj_warsztat

CREATE PROCEDURE dodaj_warsztat
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



--dodaj_rezerwacja_warsztat - dodaje rezerwacje na dany warsztat dla danej rezerwacji z konferencji na okreslona ilosc miejsc (WorkshopID, confResID, Slots)

dodaj_rezerwacja_warsztat 1, 1, 15
SELECT * FROM WorkReservation
DROP PROCEDURE dodaj_rezerwacja_warsztat

CREATE PROCEDURE dodaj_rezerwacja_warsztat
(
@workid int,
@confresid int,
@slots int
)
AS
	INSERT INTO WorkReservation VALUES (@workid, @confresid, GETDATE(), @slots, 0)
GO



--zmien_miejsca_wars - zmienia ilosc miejsc na dany warsztat (workshopId, slots)

zmien_miejsca_wars 1, 18
SELECT * FROM Workshops

CREATE PROCEDURE zmien_miejsca_wars
(
@workid int,
@slots int
)
AS
		UPDATE Workshops
		SET	Workshops.Slots = @slots
		WHERE WorkshopID = @workid
GO

--dodaj_osoba_do_rez_wars - dodaje osobe do rezerwacji na warsztat (WorkResID, PersonID)

dodaj_osoba_do_rez_wars 1, 11
SELECT * FROM WorkResDetails
DROP PROCEDURE dodaj_osoba_do_rez_wars

CREATE PROCEDURE dodaj_osoba_do_rez_wars
(
@workresid int,
@personid int
)
AS
	INSERT INTO WorkResDetails VALUES(@workresid, @personid, (SELECT ConfResID FROM WorkReservation WHERE WorkResId = @workresid))
GO


--policz_cena_osoba - liczy cene osoby za jego konferencje i warsztaty (PersonID)



--policz_cena_rezerwacja - liczy cene dla danej rezerwacji za konferencje i warsztaty (ConfResID)



--anuluj_konferencja - anuluje konferencje (ConferenceID). UWAGA! ANULUJAC KONFERENCJE ANUUJEMY WARSZTATY I WSZYSTKIE REZERWACJE!

anuluj_konferencja 1
SELECT * FROM Conferences
SELECT * FROM Workshops
SELECT * FROM ConfReservation
SELECT * FROM WorkReservation

DROP PROCEDURE anuluj_konferencja 

CREATE PROCEDURE anuluj_konferencja 
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



--anuluj_rezerwacja_konf - anuluje dana rezerwacje na konferencje (ConfResID) UWAGA! REZERWACJA NA WARSZTATY TAKZE IDZIE W ZAPOMNIENIE!

anuluj_rezerwacja_konf 1
SELECT * FROM ConfReservation
SELECT * FROM WorkReservation
DROP PROCEDURE anuluj_rezerwacja_konf

CREATE PROCEDURE anuluj_rezerwacja_konf
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


--anuluj_warsztat - anuluje warsztat (WorkshopID) UWAGA! REZERWACJE NA TEN WARSZTAT TAKZE!

anuluj_warsztat 1
SELECT * FROM Workshops
SELECT * FROM WorkReservation
DROP PROCEDURE anuluj_warsztat

CREATE PROCEDURE anuluj_warsztat
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



--anuluj_rezerwacja_warsztat - anuluje rezerwacje na warsztat (WorkResID) PRZY REZERWACJACH WARTO UWZGLEDNIC AKTUALIZACJE CEN

anuluj_rezerwacja_warsztat 1
SELECT * FROM WorkReservation
DROP PROCEDURE anuluj_rezerwacja_warsztat

CREATE PROCEDURE anuluj_rezerwacja_warsztat
(
@workresid int
)
AS
		UPDATE WorkReservation
		SET WorkReservation.Cancelled = 1
		WHERE WorkResID = @workresid
GO



--pokaz_rezerwacja_konf - pokazuje liste osob z danej rezerwacji na konferencje (ConfResID)

pokaz_rezerwacja_konf 1
DROP PROCEDURE pokaz_rezerwacja_konf

CREATE PROCEDURE pokaz_rezerwacja_konf
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



--pokaz_rezerwacja_wars - pokazuje liste osob z danej rezerwacji na warsztat (WorkResID)

pokaz_rezerwacja_wars 1
DROP PROCEDURE pokaz_rezerwacja_wars

CREATE PROCEDURE pokaz_rezerwacja_wars
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
