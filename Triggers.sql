------------------------------------------TRIGGERS-------------------------------------------



--Czy_konf_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia konferencji

CREATE TRIGGER Czy_konf_rez_ok
ON ConfReservation
AFTER INSERT AS
BEGIN
	IF EXISTS (SELECT 'TAK'
		FROM inserted 
		JOIN ConfDays AS cd 
		ON inserted.DayId =cd.DayId
		JOIN ConfReservation AS cr ON cd.DayID = cr.DayID
		WHERE inserted.DayID = cr.DayID AND cr.Cancelled = 0
		GROUP BY cr.DayID, cd.Slots
		HAVING SUM(cr.Slots) > cd.Slots
	)
	BEGIN
	RAISERROR ('Nie mozna wpisac wiecej osob na ta konferencje. Brak miejsc', 16, 1)
	ROLLBACK TRANSACTION
	END
END
GO






--Czy_wars_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia warsztatu

CREATE TRIGGER Czy_wars_rez_ok
ON WorkReservation
AFTER INSERT AS
BEGIN
	IF EXISTS (SELECT 'TAK'
		FROM inserted 
		JOIN Workshops AS w
		ON inserted.WorkshopID = w.WorkshopID
		JOIN WorkReservation AS wr ON wr.WorkshopID = w.WorkshopID
		WHERE inserted.WorkshopID = wr.WorkshopID AND wr.Cancelled = 0
		GROUP BY wr.WorkshopID, w.Slots
		HAVING SUM(wr.Slots) > w.Slots
	)
	BEGIN
	RAISERROR ('Nie mozna wpisac wiecej osob na ten warsztat. Brak miejsc', 16, 1)
	ROLLBACK TRANSACTION
	END
END
GO


--Czy_nie_koliduja_warsztaty - sprawdza czy osoba nie jest jednoczenie na dwoch warsztatach

CREATE TRIGGER Czy_nie_koliduja_warsztaty
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF( SELECT COUNT(*)
	FROM inserted AS iwrd
	JOIN WorkReservation AS wr
	ON wr.WorkResID = iwrd.WorkResID
	JOIN Workshops AS w 
	ON w.WorkshopID = wr.WorkshopID 
	JOIN WorkResDetails AS wrd
	ON iwrd.PersonID = wrd.PersonID
	JOIN WorkReservation AS wr2
	ON wrd.WorkResID = wr2.WorkResID
	JOIN Workshops AS w2
	ON w2.WorkshopID = wr2.WorkshopID
	WHERE (w.StartTime < w2.EndTime AND w.EndTime > w2.StartTime) AND w.Cancelled = 0
)>1
	BEGIN
RAISERROR ('Ta osoba bierze ju¿ udzia³ w innym warsztacie w tych godzinach.', 16, 1)
	ROLLBACK TRANSACTION
	END
END
GO



--Czy_osoba_jest_konf -- sprawdza, czy dodawana osoba nie jest na konferencji (nie chcemy jej dublowac)
CREATE TRIGGER Czy_osoba_jest_konf
ON ConfResDetails
AFTER INSERT,UPDATE AS
BEGIN
	IF (SELECT COUNT(*)
		FROM inserted AS crdi
		JOIN ConfReservation AS cr
		ON cr.ConfResID = crdi.ConfResID
		JOIn ConfReservation AS cr2 ON
		cr2.DayID = cr.DayID
		JOIN ConfResDetails AS crd
		ON crd.ConfResID = cr2.ConfResID
		WHERE crd.PersonID = crdi.PersonID AND cr.Cancelled = 0
	)>1
	BEGIN
		RAISERROR ('Osoba juz jest na konferencji', 16, 1)
		ROLLBACK TRANSACTION
	END
END
GO



--Czy_osoba_wars_jest_konf - sprawdza czy osoba dodawana do warsztatu jest na konferencji (jakos zintegrowac to z confResId bo w sumie stamtad to bierzemy)
CREATE TRIGGER czy_osoba_wars_jest_konf
ON WorkResDetails
AFTER INSERT,UPDATE AS
BEGIN
IF (SELECT COUNT(*)
FROM inserted  AS wrdi
JOIN WorkReservation AS ws
ON wrdi.WorkResID = ws.WorkResID 
JOIN
Workshops AS w ON w.WorkshopID = ws.WorkshopID 
JOIN
ConfReservation AS cr ON cr.ConfResID=ws.ConfResID
JOIN
ConfResDetails AS crd ON cr.ConfResID = crd.ConfResID 
WHERE wrdi.PersonID=crd.PersonID AND cr.Cancelled = 0
)=0
BEGIN
RAISERROR ('Osoba nie jest zapisana na konferencje na ktorej jest ten warsztat.', 16, 1)
ROLLBACK TRANSACTION
END
END
GO


