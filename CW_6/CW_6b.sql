Use firma;

--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48) 
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48) ', telefon)
WHERE telefon IS NOT NULL;

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’ 
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(
    SUBSTRING(telefon, 1, 3), '-', 
    SUBSTRING(telefon, 4, 3), '-', 
    SUBSTRING(telefon, 7, 3)
)
WHERE telefon IS NOT NULL;


--c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter

SELECT TOP 1 *
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;


--d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5

SELECT 
    imie, 
    nazwisko, 
    telefon, 
    CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONCAT(imie, nazwisko, CAST(kwota AS VARCHAR(10))))) AS zakodowane_pensje
FROM 
    ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie w ON pr.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja pn ON pn.id_pensji = pr.id_pracownika



--f) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.

SELECT p.imie, p.nazwisko, pn.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premia pr ON p.id_pracownika = pr.id_premii
LEFT JOIN ksiegowosc.pensja pn ON pn.id_pensji = p.id_pracownika


--g) wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg poni¿szego szablonu:
USE firma
SELECT CONCAT(
    'Pracownik ', p.imie, ' ', p.nazwisko,
    ', w dniu ', FORMAT(w.data, '%d.%m.%y'),
    ' otrzyma³ pensjê ca³kowit¹ na kwotê ', pn.kwota + pr.kwota,
    ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pn.kwota,
    ' z³, premia: ', pr.kwota,
    ' z³, nadgodziny: ', (g.liczba_godzin - 160) * 50, ' z³'
) AS raport
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premia pr ON p.id_pracownika = pr.id_premii
LEFT JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON p.id_pracownika = pn.id_pensji
ORDER BY w.data DESC;
