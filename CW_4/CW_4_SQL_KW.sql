CREATE DATABASE firma;
GO
USE firma;
GO
CREATE SCHEMA rozliczenia;
GO


-- Tabela pracownicy
CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(20) NOT NULL
);

-- Tabela godziny
CREATE TABLE rozliczenia.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin DECIMAL(5, 2) NOT NULL,
    id_pracownika INT
);

-- Tabela pensje
CREATE TABLE rozliczenia.pensje (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10, 2) NOT NULL,
    id_premii INT
);

-- Tabela premie
CREATE TABLE rozliczenia.premie (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10, 2) NOT NULL
);


-- Klucz obcy id_pracownika w tabeli godziny
ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT FK_godziny_pracownicy
FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

-- Klucz obcy id_premii w tabeli pensje
ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT FK_pensje_premie
FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

USE firma;
INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
    (1, 'Jan', 'Kowalski', 'ul. Wiejska 1, Warszawa', '123456789'),
    (2, 'Anna', 'Nowak', 'ul. Spacerowa 5, Kraków', '987654321'),
    (3, 'Piotr', 'Nowicki', 'ul. Kwiatowa 10, Wroc³aw', '555444333'),
    (4, 'Maria', 'Wiœniewska', 'ul. S³oneczna 3, Gdañsk', '111222333'),
    (5, 'Micha³', 'Kowalczyk', 'ul. Ogrodowa 8, Poznañ', '777888999'),
    (6, 'Ewa', 'Lis', 'ul. Leœna 12, £ódŸ', '222333444'),
    (7, 'Krzysztof', 'Kamiñski', 'ul. Zielona 7, Szczecin', '444555666'),
    (8, 'Magdalena', 'Jankowska', 'ul. Polna 15, Lublin', '666777888'),
    (9, 'Adam', 'Wójcik', 'ul. Piêkna 20, Katowice', '999888777'),
    (10, 'Barbara', 'Zaj¹c', 'ul. Parkowa 2, Bydgoszcz', '333222111');

INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2024-04-01', 8.5, 1),  
    (2, '2024-04-02', 7, 2),     
    (3, '2024-04-03', 6, 3),
    (4, '2024-04-04', 9, 4),
    (5, '2024-04-05', 8, 5),
    (6, '2024-04-06', 7.5, 6),
    (7, '2024-04-07', 8, 7),
    (8, '2024-04-08', 6.5, 8),
    (9, '2024-04-09', 7, 9),
    (10, '2024-04-10', 8, 10);   

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
    (1, 'Premia kwartalna', 1000.00),
    (2, 'Premia za osi¹gniêcie celów sprzeda¿owych', 800.00),
    (3, 'Premia roczna', 1500.00),
    (4, 'Premia za wyniki finansowe', 1200.00),
    (5, 'Premia motywacyjna', 700.00),
    (6, 'Premia za efektywnoœæ', 900.00),
    (7, 'Premia za doœwiadczenie', 600.00),
    (8, 'Premia za innowacyjnoœæ', 1100.00),
    (9, 'Premia za sta¿ pracy', 500.00),
    (10, 'Premia za udzia³ w szkoleniu', 400.00);

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
    (1, 'Kierownik', 8000.00, 1),
    (2, 'Specjalista ds. sprzeda¿y', 6000.00, 2),
    (3, 'Ksiêgowy', 6500.00, NULL),
    (4, 'Informatyk', 7000.00, 3),
    (5, 'Administrator', 5500.00, NULL),
    (6, 'Analityk finansowy', 7200.00, 4),
    (7, 'Sekretarka', 4800.00, NULL),
    (8, 'Technik', 5000.00, 5),
    (9, 'Doradca klienta', 4500.00, NULL),
    (10, 'Magazynier', 4000.00, NULL);
-- 6. Wyœwietl nazwiska pracowników i ich adresy.
SELECT nazwisko, adres
FROM rozliczenia.pracownicy;


SELECT id_godziny, data, liczba_godzin, id_pracownika,
       DATEPART(WEEKDAY, data) AS dzien_tygodnia,
       DATEPART(MONTH, data) AS miesiac
FROM rozliczenia.godziny;


ALTER TABLE rozliczenia.pensje
ADD kwota_netto DECIMAL(10, 2);


EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
GO
-- Obliczanie kwoty netto
UPDATE rozliczenia.pensje
	SET kwota_netto = kwota_brutto * 0.75; 

