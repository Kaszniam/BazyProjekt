------------------------------------------TRIGGERS-------------------------------------------



--czy_konf_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia konferencji



--czy_wars_rez_ok - sprawdza czy ilosc osob w rezerwacji nie zostala 
--przekroczona z calkowita pojemnoscia warsztatu



--czy_rezerwacje_konf_ok - sprawdza czy suma rezerwacji na konferencje nie przekracza pojemnosci



--czy_rezerwacje_wars_ok - sprawdza czy suma rezerwacji na warsztat nie przekracza pojemnosci



--czy_dzien_konf_ok - sprawdza czy dzien konferencji zawiera sie ramach konf
--MOZLIWE, ZE ZAWRZE SIE W FUNKCJI I DO USUNIECIA BEDZIE



--czy_dzien_wars_ok - sprawdza czy dzien warsztatu zawiera sie ramach DayID 
--MOZLIWE, ZE ZAWRZE SIE W FUNKCJI I DO USUNIECIA BEDZIE



--czy_nie_koliduja_warsztaty - sprawdza czy osoba nie jest jednoczenie na dwoch warsztatach



--aktualizuj_cena_rez - aktualizuje cene rezerwacji (po dodaniu osoby jakies gdzies)



--czy_osoba_jest_konf - sprawdza czy osoba dodawana do warsztatu jest na konferencji (jakos zintegrowac to z confResId bo w sumie stamtad to bierzemy)



--czy_oplacone - sprawdza kazdego dnia czy rezerwacje sa juz oplacone (bo jest czas do 2 tyg przed), trigger/procedura na trello