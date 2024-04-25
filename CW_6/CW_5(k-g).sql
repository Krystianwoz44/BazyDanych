Use firma;
--k) Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko�. 
Use firma;
SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pensja
GROUP BY stanowisko;


--l) Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �ksi�gowy�
Use firma;
SELECT 
    stanowisko,
    AVG(kwota) AS srednia_placa,
    MIN(kwota) AS minimalna_placa,
    MAX(kwota) AS maksymalna_placa
FROM 
    ksiegowosc.pensja
WHERE 
    stanowisko = 'Ksi�gowy'
GROUP BY 
    stanowisko;

--l) ALTERNATYWNIE z poleceniem HAVING
Use firma;
SELECT 
    stanowisko,
    AVG(kwota) AS srednia_placa,
    MIN(kwota) AS minimalna_placa,
    MAX(kwota) AS maksymalna_placa
FROM 
    ksiegowosc.pensja
GROUP BY 
    stanowisko
HAVING 
    stanowisko = 'Ksi�gowy';

--m) Policz sum� wszystkich wynagrodze�.
Use firma;
SELECT 
    SUM(kwota) AS suma_wynagrodzen
FROM (
    SELECT kwota FROM ksiegowosc.pensja p
    UNION ALL
    SELECT kwota FROM ksiegowosc.premia pr
	JOIN ksiegowosc.wynagrodzenie w ON w.id_premii = pr.id_premii
) AS wszystkie_wynagrodzenia;

--f) Policz sum� wynagrodze� w ramach danego stanowiska.
Use firma;
SELECT 
    p.stanowisko,
    SUM(p.kwota) AS suma_pensji,
    SUM(pr.kwota) AS suma_premii,
    SUM(p.kwota) + SUM(pr.kwota) AS suma_wynagrodzen
FROM 
    ksiegowosc.pensja p
LEFT JOIN 
    ksiegowosc.premia pr ON p.id_pensji = pr.id_premii
GROUP BY 
    p.stanowisko;

--g) Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska.

Use firma;
SELECT p.stanowisko,
    COUNT(pr.id_premii) AS liczba_premii
FROM ksiegowosc.pensja p
JOIN ksiegowosc.premia pr ON p.id_pensji = pr.id_premii
JOIN ksiegowosc.wynagrodzenie w ON w.id_premii = pr.id_premii
GROUP BY 
    p.stanowisko;

--h) Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 2501 z�.

Use firma;
DELETE w FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
WHERE pn.kwota < 2501

DELETE g FROM ksiegowosc.godziny g
JOIN ksiegowosc.pensja pn ON pn.id_pensji = g.id_pracownika
WHERE pn.kwota < 2501

DELETE p FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.pensja pn ON pn.id_pensji = p.id_pracownika
WHERE pn.kwota < 2501

-- DODANIE Usuni�tego pracownika:

Use firma;
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES (9, 'Robert', 'Kaczor', 'ul. Pi�kna 9, Szczecin', '0123456789');

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES (9, '2024-01-23', 160, 9);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES (9, '2024-01-23', 9, 9, 9, 9);