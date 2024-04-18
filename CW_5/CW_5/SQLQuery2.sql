USE firma;

CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie NVARCHAR(50),
    nazwisko NVARCHAR(50),
    adres NVARCHAR(100),
    telefon NVARCHAR(20)
);

CREATE TABLE ksiegowosc.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE,
    liczba_godzin INT,
    id_pracownika INT,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);

CREATE TABLE ksiegowosc.pensja (
    id_pensji INT PRIMARY KEY,
    stanowisko NVARCHAR(50),
    kwota DECIMAL(10, 2)
);

CREATE TABLE ksiegowosc.premia (
    id_premii INT PRIMARY KEY,
    rodzaj NVARCHAR(50),
    kwota DECIMAL(10, 2)
);

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE,
    id_pracownika INT,
    id_godziny INT,
    id_pensji INT,
    id_premii INT,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
    FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
    FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
    FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)
);

-- Wype�nienie tabeli 'pracownicy' przyk�adowymi rekordami:
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
    (1, 'Jan', 'Kowalski', 'ul. Wiejska 1, Warszawa', '1234567890'),
    (2, 'Anna', 'Nowak', 'ul. Spacerowa 5, Krak�w', '9876543210'),
    (3, 'Piotr', 'Zi�ba', 'ul. S�oneczna 10, Gda�sk', '6543210987'),
    (4, 'Ewa', 'Mazurek', 'ul. Le�na 2, Wroc�aw', '3210987654'),
    (5, 'Micha�', 'Wo�niak', 'ul. Polna 3, Pozna�', '7890123456'),
    (6, 'Magdalena', 'Lis', 'ul. Ogrodowa 7, ��d�', '2345678901'),
    (7, 'Adam', 'Soko�owski', 'ul. Zamkowa 4, Lublin', '8901234567'),
    (8, 'Karolina', 'Jaworska', 'ul. Plac Podzamcze 6, Katowice', '4567890123'),
    (9, 'Robert', 'Kaczor', 'ul. Pi�kna 9, Szczecin', '0123456789'),
    (10, 'Katarzyna', 'Piotrowska', 'ul. S�owackiego 8, Gdynia', '5678901234');

INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2024-01-15', 150, 1),
    (2, '2024-01-16', 167, 2),
    (3, '2024-01-17', 200, 3),
    (4, '2024-01-18', 120, 4),
    (5, '2024-01-19', 80, 5),
    (6, '2024-01-20', 164, 6),
    (7, '2024-01-21', 198, 7),
    (8, '2024-01-22', 145, 8),
    (9, '2024-01-23', 160, 9),
    (10, '2024-01-24', 130, 10);

-- Wype�nienie tabeli 'pensja'
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
    (1, 'Ksi�gowy', 5000.00),
    (2, 'Specjalista ds. Finansowych', 6000.00),
    (3, 'Asystent Ksi�gowego', 3500.00),
    (4, 'Pracownik ds. Rozlicze�', 4000.00),
    (5, 'Starszy Ksi�gowy', 7000.00),
    (6, 'Analityk Finansowy', 6500.00),
    (7, 'Doradca Podatkowy', 7500.00),
    (8, 'Kierownik Finansowy', 9000.00),
    (9, 'Praktykant Ksi�gowy', 2500.00),
    (10, 'Specjalista ds. P�ac', 5500.00);

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
    (1, 'Premia roczna', 1000.00),
    (2, 'Premia za wyj�tkowe osi�gni�cia', 1500.00),
    (3, 'Premia motywacyjna', 800.00),
    (4, 'Premia za sta� pracy', 500.00),
    (5, 'Premia �wi�teczna', 1200.00),
    (6, 'Premia za efektywno��', 1000.00),
    (7, 'Premia za dodatkowe zadania', 700.00),
    (8, 'Premia za wyniki finansowe', 2000.00),
    (9, 'Premia za d�ugi sta�', 1500.00),
    (10, 'Premia uznaniowa', 900.00);

-- Wype�nienie tabeli 'wynagrodzenie' przyk�adowymi rekordami:
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
    (1, '2024-01-15', 1, 1, 5, 2),
    (2, '2024-01-16', 2, 2, 2, NULL),
    (3, '2024-01-17', 3, 3, 4, 3),
    (4, '2024-01-18', 4, 4, 3, 4),
    (5, '2024-01-19', 5, 5, 6, NULL),
    (6, '2024-01-20', 6, 6, 1, 6),
    (7, '2024-01-21', 7, 7, 8, NULL),
    (8, '2024-01-22', 8, 8, 7, 8),
    (9, '2024-01-23', 9, 9, 9, 9),
    (10, '2024-01-24', 10, 10, 10, NULL);