--------------------------------------------VIEWS---------------------------------------------


--Niepelne_zgloszenia -  pokazuje zgloszenia, ktore jeszcze nie sa wypelnione

CREATE VIEW Niepelne_zgloszenia
 AS
	SELECT cr.ConfResID, c.Name AS 'Nazwa klienta', c.Phone, 
		conf.Name AS 'Nazwa Konferencji', cd.Date AS 'Data Konferencji', cr.Slots AS 'Ile powinno byc', 
			cr.Slots - (SELECT COUNT(*) FROM ConfResDetails AS crd WHERE crd.ConfResID = cr.ConfResID) AS 'Ilu brakuje'

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

GO



--Najczestsi_klienci - wyswietla klientow najczesciej korzystajacych z us³ug (z tym ze podajac ile przechodzi to na procedure)

CREATE VIEW najczesciej_korzystajacy_z_uslug
AS
	SELECT Name AS 'Client',
	(SELECT COUNT(*)
	FROM ConfReservation
	WHERE (Clients.ClientID = ClientID) AND ConfReservation.Cancelled = 0) AS 'How many times:'
	FROM Clients
	GROUP BY ClientID, Name
	
GO








--Anulowane_konferencje - wyswietla anulowane konferencje
CREATE VIEW anulowane_konferencje
AS
	SELECT *
	FROM Conferences as c
	WHERE c.Cancelled=1
	
GO


--Anulowane_konf_rezerwacje - wyswietla anulowane rezerwacje konferencje
CREATE VIEW anulowane_konf_rezerwacje
AS
	SELECT *
	FROM ConfReservation as cr
	WHERE cr.Cancelled=1
	
GO


--Anulowane_warsztaty - wyswietla anulowane warsztaty
CREATE VIEW anulowane_warsztaty
AS
	SELECT *
	FROM Workshops as w
	WHERE w.Cancelled=1
	
GO


--Anulowane_wars_rezerwacje - wyswietla anulowane rezerwacje na warsztaty
CREATE VIEW anulowane_wars_rezerwacje
AS
	SELECT *
	FROM WorkReservation as wr
	WHERE wr.Cancelled=1
	
GO


--Klienci_prywatni - wyswietla klientow prywatnych
CREATE VIEW klienci_prywatni
AS
	SELECT *
	FROM Clients as c
	WHERE c.Company=0
	
GO



--Klienci_firmowi - wyswietla firmy, ktore sa klientami
CREATE VIEW klienci_firmowi
AS
	SELECT *
	FROM Clients as c
	WHERE c.Company=1
	
GO



--Nie_zaplacili - wyswietla zaleglosci w finansach dla klientów, jeœli konferencja odbywa siê za mniej ni¿ 2 tyg

