--------------------------------------------VIEWS---------------------------------------------


--niepelne_zgloszenia -  pokazuje zgloszenia, ktore jeszcze nie sa wypelnione
--mozna ulepszyc

SELECT * FROM niepelne_zgloszenia
DROP VIEW niepelne_zgloszenia

CREATE VIEW niepelne_zgloszenia
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


	
--najpopularniejsze_konferencje - podlicza ilosc chetnych zgloszonych na konferencje i porzadkuje po ilosci osob

SELECT * FROM najpopularniejsze_konferencje
DROP VIEW najpopularniejsze_konferencje

CREATE VIEW najpopularniejsze_konferencje
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



--najpopularniejsze_warsztaty - podlicza ilosc chetnych zgloszonych na warsztaty i porzadkuje po ilosci osob

SELECT * FROM najpopularniejsze_warsztaty
DROP VIEW najpopularniejsze_warsztaty

CREATE VIEW najpopularniejsze_warsztaty
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



--najczestsi_klienci - wyswietla klientow najczesciej korzystajacych z us³ug









--anulowane_konferencje - wyswietla anulowane konferencje



--anulowane_konf_rezerwacje - wyswietla anulowane rezerwacje konferencje



--anulowane_warsztaty - wyswietla anulowane warsztaty



--anulowane_wars_rezerwacje - wyswietla anulowane rezerwacje na warsztaty



--klienci_prywatni - wyswietla klientow prywatnych




--klienci_firmowi - wyswietla firmy, ktore sa klientami



--nie_zaplacili - wyswietla zaleglosci w finansach dla klientw