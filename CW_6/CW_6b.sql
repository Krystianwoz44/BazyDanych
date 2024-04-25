Use firma;

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48) 
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon)
WHERE telefon IS NOT NULL;

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(
    SUBSTRING(telefon, 1, 3), '-', 
    SUBSTRING(telefon, 4, 3), '-', 
    SUBSTRING(telefon, 7, 3)
)
WHERE telefon IS NOT NULL;


--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter

SELECT TOP 1 *
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;


--d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5

SELECT 
    imie, 
    nazwisko, 
    telefon, 
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT(imie, nazwisko, CAST(kwota AS VARCHAR(10))))) AS zakodowane_pensje
FROM 
    ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja pn ON pn.id_pensji = pr.id_pracownika



--f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.

SELECT p.imie, p.nazwisko, pn.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premia pr ON p.id_pracownika = pr.id_premii
LEFT JOIN ksiegowosc.pensja pn ON pn.id_pensji = p.id_pracownika


--g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu:
USE firma
SELECT CONCAT(
    'Pracownik ', p.imie, ' ', p.nazwisko,
    ', w dniu ', FORMAT(w.data, '%d.%m.%y'),
    ' otrzyma� pensj� ca�kowit� na kwot� ', pn.kwota + pr.kwota,
    ' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ', pn.kwota,
    ' z�, premia: ', pr.kwota,
    ' z�, nadgodziny: ', (g.liczba_godzin - 160) * 50, ' z�'
) AS raport
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premia pr ON p.id_pracownika = pr.id_premii
LEFT JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON p.id_pracownika = pn.id_pensji
ORDER BY w.data DESC;
