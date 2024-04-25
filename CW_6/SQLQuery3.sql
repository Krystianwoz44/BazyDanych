USE firma;

-- a)

SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

-- b)

SELECT p.id_pracownika
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
WHERE pen.kwota > 1000;

-- C)

--SELECT p.id_pracownika
--FROM ksiegowosc.pracownicy p
--JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
--JOIN ksiegowosc.premia prm ON p.id_pracownika = prm.id_premii
--WHERE prm.id_premii IS NULL 
--AND pen.kwota > 2000; 

SELECT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensja pen ON w.id_pensji = pen.id_pensji
WHERE w.id_premii IS NULL AND pen.kwota > 2000; 

-- D)

SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

-- E)

SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- F)

SELECT p.imie, p.nazwisko, g.liczba_godzin - 160 AS nadgodziny
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
WHERE g.liczba_godzin > 160;

-- G)

SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
WHERE pen.kwota BETWEEN 1500 AND 3000;

-- H)

SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
WHERE g.liczba_godzin > 160 AND w.id_premii IS NULL;

-- I)

SELECT *
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
ORDER BY pen.kwota;

-- J)

SELECT p.imie, p.nazwisko, pen.kwota AS pensja, prm.kwota AS premia
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
JOIN ksiegowosc.premia prm ON p.id_pracownika = prm.id_premii
ORDER BY pen.kwota DESC, prm.kwota DESC;