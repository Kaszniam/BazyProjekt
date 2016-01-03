SELECT * FROM Clients
SELECT * FROM People
SELECT * FROM Conferences
SELECT * FROM ConfDays
SELECT * FROM Workshops
SELECT * FROM ConfReservation
SELECT * FROM ConfResDetails
SELECT * FROM WorkReservation
SELECT * FROM WorkResDetails
SELECT * FROM PaymentDone
SELECT * FROM Prices



INSERT INTO Clients VALUES (0, 'Ala B', '+48930393748', 'Krakowska1', 'Krakow', '31-552', 'Poland', NULL, NULL)
INSERT INTO Clients VALUES (1, 'Geje', '+48930587748', 'Kraska1', 'Krakow', '31-452', 'Poland', NULL, '3049489032')
INSERT INTO Clients VALUES (0, 'Michasia dwa', '+48272920938', 'Podchorazych2', 'Warszawa' ,'00-123', 'Poland', '239940', NULL)




INSERT INTO People VALUES ('1p', '1n', NULL)
INSERT INTO People VALUES ('2p', '2n', NULL)
INSERT INTO People VALUES ('3p', '3n', '324432')
INSERT INTO People VALUES ('4p', '4n', NULL)
INSERT INTO People VALUES ('5p', '5n', NULL)
INSERT INTO People VALUES ('6p', '6n', '123432')
INSERT INTO People VALUES ('7p', '7n', NULL)
INSERT INTO People VALUES ('8p', '8n', '345453')
INSERT INTO People VALUES ('9p', '9n', NULL)
INSERT INTO People VALUES ('10p', '10n', NULL)
INSERT INTO People VALUES ('11p', '11n', '240432')
INSERT INTO People VALUES ('12p', '12n', NULL)
INSERT INTO People VALUES ('13p', '13n', NULL)
INSERT INTO People VALUES ('14p', '14n', '123412')
INSERT INTO People VALUES ('51p', '15n', NULL)



INSERT INTO Conferences VALUES ('Grube melo', 'Bedzie fajnie', '2016/01/01', '2016/01/03', 0)
INSERT INTO Conferences VALUES ('W dzikich gaszczach', NULL, '2016/01/04', '2016/01/05', 0)
INSERT INTO Conferences VALUES ('Las i ptas', 'No tak', '2016/04/01', '2016/04/04', 0)




INSERT INTO ConfDays VALUES (1, 20, '2016/01/01')
INSERT INTO ConfDays VALUES (1, 20, '2016/01/02')
INSERT INTO ConfDays VALUES (1, 20, '2016/01/03')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/01')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/02')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/03')
INSERT INTO ConfDays VALUES (2, 40, '2016/04/04')
INSERT INTO ConfDays VALUES (3, 30, '2016/01/04')
INSERT INTO ConfDays VALUES (3, 30, '2016/01/05')




INSERT INtO ConfReservation VALUES (1,1, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (2,2, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (2,3, '2015/12/31', 10, 0)
INSERT INtO ConfReservation VALUES (1,5, '2016/01/31', 10, 0)
INSERT INTO ConfReservation VALUES (3,1, '2015/12/31', 5, 0)



INSERT INTO ConfResDetails VALUES (1,11, NULL)
INSERT INTO ConfResDetails VALUES (1,17, NULL)
INSERT INTO ConfResDetails VALUES (1,18, NULL)
INSERT INTO ConfResDetails VALUES (1,19, '123432')
INSERT INTO ConfResDetails VALUES (1,20, NULL)
INSERT INTO ConfResDetails VALUES (1,21, NULL)
INSERT INTO ConfResDetails VALUES (1,22, '123432')
INSERT INTO ConfResDetails VALUES (1,23, NULL)
INSERT INTO ConfResDetails VALUES (1,24, NULL)
INSERT INTO ConfResDetails VALUES (1,25, '123432')

INSERT INTO ConfResDetails VALUES (2,16, NULL)
INSERT INTO ConfResDetails VALUES (2,17, NULL)
INSERT INTO ConfResDetails VALUES (2,18, NULL)

INSERT INTO ConfResDetails VALUES (5,33,NULL)
INSERT INTO ConfResDetails VALUES (5,34,NULL)



INSERT INTO Prices VALUES (1, 6, 0.2, 0.4, 50)
INSERT INTO Prices VALUES (1, 3, 0.15, 0.3, 50)
INSERT INTO Prices VALUES (2, 3, 0.15, 0.3, 60)



INSERT INTO PaymentDone VALUES (1, 120, GETDATE())
INSERT INTO PaymentDone VALUES (1, 30, GETDATE())

SELECT * FROM Conferences

INSERT INTO Workshops VALUES (1, 'brak', 20, '2016/04/01 15:00', '2016/01/01 17:00', 0, 0)
INSERT INTO Workshops VALUES (1, 'brak', 20, '2016/04/01 16:00', '2016/01/01 19:00', 5, 0)
INSERT INTO Workshops VALUES (2, 'brak', 10, '2016/01/02 15:00', '2016/01/02 17:00', 0, 0)
INSERT INTO Workshops VALUES (2, 'brak', 10, '2016/01/02 15:00', '2016/01/01 17:00', 0, 0)



INSERT INTO WorkReservation VALUES (2, 2, GETDATE(), 5, 0)
INSERT INTO WorkReservation VALUES (2, 1, GETDATE(), 6, 0)




INSERT INTO WorkResDetails VALUES (2, 16, 2)
INSERT INTO WorkResDetails VALUES (2, 17, 2)
INSERT INTO WorkResDetails VALUES (2, 18, 2)





---------------------------------------PROCEDURES-----------------------------------------------

Najczesciej_korzystajacy_z_uslug 1
Osoby_dzien_konf 1
Osoby_warsztat 1
Generuj_id 1
Moje_konferencje 19
Moje_warsztaty 18
Platnosci_konferencja 2
Platnosci_rezerwacja 2
Progi_cenowe 1
Osoby_klient 5
Dodaj_klient_prywatny 'pizderyja Ala', '+48223333000', 'Smieszna ulica', 'Krakow', '00-123', 'Polska', NULL
Dodaj_klient_firma 'Stink ci', '+48666555333', 'Smieszna ulica 5', 'Krakow', '00-143', 'Polska', '3334445566'
Zmien_dane_prywatny 1, 'Alicja Ka', NULL, NULL, NULL, NULL, NULL, NULL
Zmien_dane_firma 2, NULL, NULL, 'Sliczna3', NULL, NULL, NULL, NULL
Dodaj_osoba 'Agnieszka', 'W³odarczyk', NULL
Zmien_student 46, '223344'
Dodaj_konferencje 'Zjazd kupy biskupa', 'no taak', '2016/06/08', '2016/06/11', 30
Zmien_ilosc_miejsc_konf 2, 40
Dodaj_rezerwacja_konf 2, 7, 20
Dodaj_osoba_do_rez_konf 1, 9
Dodaj_prog_cenowy 1, 10, 0.1, 0.2, 100
Dodaj_warsztat 7, 'Chujowy warszta2t', 10, '2016/06/08 13:00', '2016/06/08 15:00', 10
Dodaj_rezerwacja_warsztat 4, 1, 5
Zmien_miejsca_wars 1, 18
Dodaj_osoba_do_rez_wars 1, 11
Anuluj_konferencja 1
Anuluj_rezerwacja_konf 1
Anuluj_warsztat 1
Anuluj_rezerwacja_warsztat 1
Pokaz_rezerwacja_konf 1
Pokaz_rezerwacja_wars 1

------------------------------------------VIEWS--------------------------------------------
SELECT * FROM Niepelne_zgloszenia
SELECT * FROM Najpopularniejsze_konferencje
SELECT * FROM Najpopularniejsze_warsztaty
SELECT * FROM Anulowane_konferencje
SELECT * FROM Anulowane_konf_rezerwacje
SELECT * FROM Anulowane_warsztaty
SELECT * FROM Anulowane_wars_rezerwacje
SELECT * FROM Klienci_prywatni
SELECT * FROM Klienci_firma



-------------------------------------TRIGGERS------------------------------------------------

--Czy_konf_rez_ok
Dodaj_konferencje 'Zjazd kupy biskupa', 'no taak', '2016/06/08', '2016/06/11', 30
Dodaj_rezerwacja_konf 1, 1, 29
Dodaj_rezerwacja_konf 2, 1, 1
SELECT * FROM ConfReservation

--Czy_wars_rez_ok
Dodaj_warsztat 1, 'Chujowy warsztat', 20, '2016/06/08 12:00', '2016/06/08 14:00', 30
SELECT * FROM Workshops
INSERT INTO WorkReservation VALUES (1,2, GETDATE(), 21, 0)
SELECT * FROM WorkReservation

--Czy_nie_koliduja_warsztaty

INSERT INTO ConfResDetails VALUES (1,10,null)


SELECT *
		FROM ConfResDetails as crd2
		JOIN ConfReservation AS cr
		ON crd2.ConfResID = cr.ConfResID
		JOIN ConfReservation AS cr2
		ON cr.DayID = cr2.DayID
		JOIN ConfResDetails AS crd
		ON crd.ConfResID = cr2.ConfResID
		WHERE crd2.PersonID = crd.PersonID
