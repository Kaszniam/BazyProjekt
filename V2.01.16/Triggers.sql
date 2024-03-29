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

--Czy_nie_koliduja_warsztaty - sprawdza czy osoba nie jest jednoczenie na dwoch warsztatach

CREATE TRIGGER Czy_nie_koliduja_warsztaty
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF( SELECT COUNT(*)
	FROM inserted as iwrd
	INNER JOIN WorkReservation AS wr
	ON wr.WorkResID = iwrd.WorkResID
	INNER JOIN Workshops AS w 
	ON w.WorkshopID = wr.WorkshopID 
	INNER JOIN WorkResDetails AS wrd
	ON iwrd.PersonID = wrd.PersonID
	INNER JOIN WorkReservation AS wr2
	ON wrd.WorkResID = wr2.WorkResID
	INNER JOIN Workshops AS w2
	ON w2.WorkshopID = wr2.WorkshopID
	WHERE (w.StartTime < w2.EndTime AND w.EndTime > w2.StartTime)
)>1
	BEGIN
	RAISERROR ('Ta osoba bierze ju� udzia� w innym warsztacie w tych godzinach.', 16, 1)
	ROLLBACK TRANSACTION
	END
END


--Czy_osoba_jest_konf -- sprawdza, czy dodawana osoba nie jest na konferencji (nie chcemy jej dublowac)
CREATE TRIGGER Czy_osoba_jest_konf
ON ConfResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF (SELECT COUNT(*)
		FROM inserted 
		JOIN ConfReservation AS cr
		ON inserted.ConfResID = cr.ConfResID
		JOIN ConfResDetails AS crd
		ON crd.ConfResID = cr.ConfResID
		WHERE inserted.PersonID = crd.PersonID
	)>1
	BEGIN
		RAISERROR ('Osoba juz jest na konferencji', 16, 1)
		ROLLBACK TRANSACTION
	END
END


--Czy_osoba_wars_jest_konf - sprawdza czy osoba dodawana do warsztatu jest na konferencji (jakos zintegrowac to z confResId bo w sumie stamtad to bierzemy)
CREATE TRIGGER czy_osoba_wars_jest_konf
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF (SELECT COUNT(*)
	FROM inserted  as wrdi
	INNER JOIN WorkReservation as ws
	ON wrdi.WorkResID = ws.WorkResID 
	INNER JOIN
	Workshops as w ON w.WorkshopID = ws.WorkshopID 
	INNER JOIN
	ConfReservation as cr ON cr.ConfResID=ws.ConfResID
	INNER JOIN
	ConfResDetails as crd ON cr.ConfResID = crd.ConfResID 
	WHERE wrdi.PersonID=crd.PersonID
	)=0
BEGIN
RAISERROR ('Osoba nie jest zapisana na konferencje na ktorej jest ten warsztat.', 16, 1)
ROLLBACK TRANSACTION
END
END
GO

