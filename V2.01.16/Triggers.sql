------------------------------------------TRIGGERS-------------------------------------------



--Czy_konf_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia konferencji

CREATE TRIGGER Czy_konf_rez_ok
ON ConfReservation
AFTER INSERT,UPDATE AS
BEGIN
	IF EXISTS (SELECT 'TAK'
		FROM inserted 
		JOIN ConfDays AS cd 
		ON inserted.DayId =cd.DayId
		JOIN ConfReservation AS cr ON cd.DayID = cr.DayID
		WHERE inserted.DayID = cr.DayID
		GROUP BY cr.DayID, cd.Slots
		HAVING SUM(cr.Slots) > cd.Slots
	)
	BEGIN
	RAISERROR ('Nie mozna wpisac wiecej osob na ta konferencje. Brak miejsc', 16, 1)
	ROLLBACK TRANSACTION
	END
END




--Czy_wars_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia warsztatu

CREATE TRIGGER Czy_wars_rez_ok
ON WorkReservation
AFTER INSERT,UPDATE AS
BEGIN
	IF EXISTS (SELECT 'TAK'
		FROM inserted 
		JOIN Workshops AS w
		ON inserted.WorkshopID = w.WorkshopID
		JOIN WorkReservation AS wr ON wr.WorkshopID = w.WorkshopID
		WHERE inserted.WorkshopID = wr.WorkshopID
		GROUP BY wr.WorkshopID, w.Slots
		HAVING SUM(wr.Slots) > w.Slots
	)
	BEGIN
	RAISERROR ('Nie mozna wpisac wiecej osob na ten warsztat. Brak miejsc', 16, 1)
	ROLLBACK TRANSACTION
	END
END


--Czy_rezerwacje_konf_ok - sprawdza czy suma rezerwacji na konferencje nie przekracza pojemnosci

--POWYZSZE 2 TRIGGERY OBSLUGUJA TE 

--Czy_rezerwacje_wars_ok - sprawdza czy suma rezerwacji na warsztat nie przekracza pojemnosci

--JW

--Czy_dzien_konf_ok - sprawdza czy dzien konferencji zawiera sie ramach konf
--MOZLIWE, ZE ZAWRZE SIE W FUNKCJI I DO USUNIECIA BEDZIE



--Czy_dzien_wars_ok - sprawdza czy dzien warsztatu zawiera sie ramach DayID 
--MOZLIWE, ZE ZAWRZE SIE W FUNKCJI I DO USUNIECIA BEDZIE




--Czy_nie_koliduja_warsztaty - sprawdza czy osoba nie jest jednoczenie na dwoch warsztatach
--NIE DZIALA!!!
CREATE TRIGGER Czy_nie_koliduja_warsztaty
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF( SELECT COUNT(*)
	FROM inserted as wrd
	INNER JOIN WorkReservation AS wr
	ON wr.WorkResID = wrd.WorkResID
	INNER JOIN Workshops AS w 
	ON w.WorkshopID = wr.WorkshopID 
	INNER JOIN ConfDays AS cd
	ON cd.DayID = w.DayID 
	INNER JOIN ConfResDetails AS crd 
	ON wrd.ConfResID = crd.ConfResID 
	INNER JOIN ConfDays AS cd2 
	ON cd.DayID = cd2.DayID 
	INNER JOIN Workshops AS w2 
	ON w2.DayID = cd2.DayID
	WHERE (w.StartTime < w2.EndTime AND w.EndTime > w2.StartTime)
)>1
	BEGIN
	RAISERROR ('Ta osoba bierze ju¿ udzia³ w innym warsztacie w tych godzinach.', 16, 1)
	ROLLBACK TRANSACTION
	END
END


--Czy_osoba_jest_konf -- sprawdza, czy dodawana osoba nie jest na konferencji (nie chcemy jej dublowac)
--DO ZROBIENIA 

CREATE TRIGGER Czy_osoba_jest_konf
ON ConfResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF EXISTS (SELECT *
		FROM inserted 
		JOIN ConfReservation AS cr
		ON inserted.ConfResID = cr.ConfResID
		JOIN ConfReservation AS cr2
		ON cr.DayID = cr2.DayID
		JOIN ConfResDetails AS crd
		ON crd.ConfResID = cr2.ConfResID
		WHERE inserted.PersonID = crd.PersonID
	)
	BEGIN
	RAISERROR ('Osoba juz jest na konferencji', 16, 1)
	ROLLBACK TRANSACTION
	END
END



--Aktualizuj_cena_rez - aktualizuje cene rezerwacji (po dodaniu osoby jakies gdzies)



--Czy_osoba_jest_konf - sprawdza czy osoba dodawana do warsztatu jest na konferencji (jakos zintegrowac to z confResId bo w sumie stamtad to bierzemy)
--Chyba dziala
CREATE TRIGGER czy_osoba_wars_jest_konf
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
IF EXISTS (SELECT *
FROM inserted  as WorkResDetails 
INNER JOIN WorkReservation ON
WorkReservation.WorkResID = WorkResDetails.WorkResID 
INNER JOIN
Workshops ON Workshops.WorkshopID = WorkReservation.WorkshopID 
INNER JOIN
ConfReservation ON ConfReservation.ConfResID=WorkReservation.ConfResID
INNER JOIN
ConfResDetails ON WorkResDetails.ConfResID = ConfResDetails.ConfResID 

WHERE Workshops.DayID!=ConfReservation.DayID
)
BEGIN
RAISERROR ('Osoba nie jest zapisana na konferencje na ktorej jest ten warsztat.', 16, 1)
ROLLBACK TRANSACTION
END
END
GO


--Czy_oplacone - sprawdza kazdego dnia czy rezerwacje sa juz oplacone (bo jest czas do 2 tyg przed), trigger/procedura na trello
