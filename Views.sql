--------------------------------------------VIEWS---------------------------------------------


--Niepelne_zgloszenia -  pokazuje zgloszenia, ktore jeszcze nie sa wypelnione
--mozna ulepszyc bo poki co wyswietla zgloszenia jeszcze niepelne

CREATE VIEW Niepelne_zgloszenia
 AS
	SELECT cr.ConfResID, c.Name AS [Nazwa klienta], c.Phone, 
		conf.Name AS [Nazwa Konferencji], cd.Date AS [Data Konferencji], cr.Slots AS [Ile powinno byc], 
			cr.Slots - (SELECT COUNT(*) FROM ConfResDetails AS crd WHERE crd.ConfResID = cr.ConfResID) AS [Ilu brakuje]

	FROM ConfReservation AS cr
	JOIN Clients as c
	ON cr.ClientID = c.ClientID
	JOIN ConfDays as cd
	ON cr.DayID = cd.DayID
	JOIN Conferences as conf
	ON cd.ConferenceID = conf.ConferenceID

	WHERE cr.Slots - (SELECT COUNT(*) FROM ConfResDetails AS crd WHERE crd.ConfResID = cr.ConfResID) >0
	AND cr.Cancelled = 0
GO


	
--Najpopularniejsze_konferencje - podlicza ilosc chetnych zgloszonych na konferencje i porzadkuje po ilosci osob

CREATE VIEW Najpopularniejsze_konferencje
AS
	SELECT conf.ConferenceID, conf.Name, COUNT(*) AS [Ilosc chetnych]
	FROM Conferences AS conf
	LEFT JOIN ConfDays AS cd
	ON conf.ConferenceID = cd.ConferenceID
	LEFT JOIN ConfReservation AS cr
	ON cr.DayID = cd.DayID
	JOIN ConfResDetails AS crd
	ON crd.ConfResID = cr.ConfResID
	GROUP BY conf.ConferenceID, conf.Name
	--ORDER BY [Ilosc chetnych] DESC

GO



--Najpopularniejsze_warsztaty - podlicza ilosc chetnych zgloszonych na warsztaty i porzadkuje po ilosci osob

CREATE VIEW Najpopularniejsze_warsztaty
AS
	SELECT work.WorkshopID, work.Description, work.StartTime, work.EndTime, COUNT(*) AS [Ilosc chetnych]
	FROM Workshops AS work
	LEFT JOIN WorkReservation AS wr
	ON work.WorkshopID = wr.WorkshopID
	JOIN WorkResDetails as wrd
	ON wr.WorkResID = wrd.WorkResID
	GROUP BY work.WorkshopID, work.Description, work.StartTime, work.EndTime
	--ORDER BY [Ilosc chetnych] DESC

GO



--Najczestsi_klienci - wyswietla klientow najczesciej korzystajacych z us³ug (z tym ze podajac ile przechodzi to na procedure)









--Anulowane_konferencje - wyswietla anulowane konferencje

CREATE VIEW Anulowane_konferencje
AS
	SELECT Name AS [Nazwa konferencji], StartDate AS [Start konferencji], EndDate AS [Koniec konferencji]
	FROM Conferences AS conf
	WHERE Cancelled = 1
GO


--Anulowane_konf_rezerwacje - wyswietla anulowane rezerwacje konferencje

CREATE VIEW Anulowane_konf_rezerwacje
AS
	SELECT c.Name AS [Klient], cr.ReservationDate AS [Data rezerwacji], cd.Date AS [Data konferencji], cr.Slots AS [Miejsca]
	FROM ConfReservation AS cr
	JOIN Clients AS c
	ON cr.ClientID = c.ClientID
	JOIN ConfDays AS cd
	ON cr.DayID = cd.DayID
	WHERE  cr.Cancelled = 1
GO


--Anulowane_warsztaty - wyswietla anulowane warsztaty

CREATE VIEW Anulowane_warsztaty
AS
	SELECT Description AS [Nazwa warsztatu], Slots AS [Miejsca], StartTime AS [Start warsztatu], EndTime AS [KoniecWarsztatu] 
	FROM Workshops
	WHERE Cancelled = 1
GO



--Anulowane_wars_rezerwacje - wyswietla anulowane rezerwacje na warsztaty

CREATE VIEW Anulowane_wars_rezerwacje
AS
	SELECT c.Name AS [Klient], wr.ReservationDate AS [Data rezerwacji], cd.Date AS [Data warsztatu], wr.Slots AS [Miejsca]
	FROM WorkReservation AS wr
	JOIN ConfReservation AS cr
	ON wr.ConfResID = cr.ConfResID
	JOIN Clients AS c
	ON cr.ClientID = c.ClientID
	JOIN ConfDays AS cd
	ON cr.DayID = cd.DayID
	WHERE wr.Cancelled = 1
GO



--Klienci_prywatni - wyswietla klientow, którzy nie s¹ firm¹

CREATE VIEW Klienci_prywatni
AS
	SELECT * FROM Clients WHERE Company = 0
GO



--Klienci_firma - wyswietla klientów, którzy s¹ firmami

CREATE VIEW Klienci_firma
AS
	SELECT * FROM Clients WHERE Company = 1
GO



--Nie_zaplacili - wyswietla zaleglosci w finansach dla klientw
