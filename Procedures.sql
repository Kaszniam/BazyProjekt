------------------------------------------PROCEDURES-------------------------------------------


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

--platnosci_rezerwacja - wyswietla platnosci dla podanego id rezerwacji



--progi_cenowe - wyswietla progi cenowe dla danego id konferencji



--osoby_firma - wyswietla osoby z firmy o podanym id



--osoba_prywatny - wyswietl osoby od danej osoby o podanym id (z klientow)



--dodaj_klient_prywatny - dodaje prywatnego klienta (imie, tel, adres, miasto, kod, kraj, studentid)



--dodaj_klient_firma - dodaje firme (imie,tel, adres, miasto, kod, kraj, nip)



--zmien_dane_prywatny- zmienia dane klienta prywatnego, jesli czeogs nie zmienia przekazujemy null



--zmien_dane_firma- zmienia dane firmy, jesli czeogs nie zmienia przekazujemy null




--dodaj_osoba - dodaje osobe (imie, nazwisko, studentid)



--zmien_student - zmienia studentid danej osobie (PersonID, studentID)




--dodaj_konferencje - dodaje konferencje (nazwa, opis, start, koniec, domyslna ilosc miejsc), pododawac confDayitd



--zmien_ilosc_miejsc - zmienia ilosc miejsc w dniu o podanym dayid (dayid, slots)



--dodaj_rezerwacja_konf - dodaje rezerwacje klienta na konferencje na ustalona ilosc miejsc (ClientID, DayId, Slots)



--dodaj_osoba_do_rez_konf - dodaje osobe do rezerwacji na konferencje (confResID, PersonId, StudentId)




--dodaj_prog_cenowy - dodaje prog cenowy do konferencji (dni przed, znizka, studencka, cena standard)




--dodaj_warsztat - dodaje warsztat (dzien, opis, miejsca, start, koniec, cena)



--dodaj_rezerwacja_warsztat - dodaje rezerwacje na dany warsztat dla danej rezerwacji z konferencji na okreslona ilosc miejsc (WorkshopID, confResID, Slots)



--dodaj_osoba_do_rez_warsztat - dodaje osobe do rezerwacji na warsztat (WorkResID, PersonID, ConfResID)



--policz_cena_osoba - liczy cene osoby za jego konferencje i warsztaty (PersonID)



--policz_cena_rezerwacja - liczy cene dla danej rezerwacji za konferencje i warsztaty (ConfResID)



--anuluj_konferencja - anuluje konferencje (ConferenceID). UWAGA! ANULUJAC KONFERENCJE ANUUJEMY WARSZTATY I WSZYSTKIE REZERWACJE!



--anuluj_rezerwacja_konf - anuluje dana rezerwacje na konferencje (ConfResID) UWAGA! REZERWACJA NA WARSZTATY TAKZE IDZIE W ZAPOMNIENIE!



--anuluj_warsztat - anuluje warsztat (WorkshopID) UWAGA! REZERWACJE NA TEN WARSZTAT TAKZE!



--anuluj_rezerwacja_warsztat - anuluje rezerwacje na warsztat (WorkResID) PRZY REZERWACJACH WARTO UWZGLEDNIC AKTUALIZACJE CEN




