CREATE DATABASE stratygrafia;

CREATE SCHEMA projekt;

CREATE TABLE projekt.GeoEon (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR(50)
);


CREATE TABLE projekt.GeoEon2 (
    id_eon INT PRIMARY KEY,
    nazwa_eon VARCHAR(50)
);

CREATE TABLE projekt.GeoEra (
    id_era INT PRIMARY KEY,
    nazwa_era VARCHAR(50),
    id_eon INT,
    FOREIGN KEY (id_eon) REFERENCES projekt.GeoEon(id_eon)
);

CREATE TABLE projekt.GeoOkres (
    id_okres INT PRIMARY KEY,
    nazwa_okres VARCHAR(50),
    id_era INT,
    FOREIGN KEY (id_era) REFERENCES projekt.GeoEra(id_era)
);

CREATE TABLE projekt.GeoEpoka (
    id_epoka INT PRIMARY KEY,
    nazwa_epoka VARCHAR(50),
    id_okres INT,
    FOREIGN KEY (id_okres) REFERENCES projekt.GeoOkres(id_okres)
);

CREATE TABLE projekt.GeoPietro (
    id_pietro INT PRIMARY KEY,
    nazwa_pietro VARCHAR(50),
    id_epoka INT,
    FOREIGN KEY (id_epoka) REFERENCES projekt.GeoEpoka(id_epoka)
);

INSERT INTO projekt.GeoEon (id_eon, nazwa_eon) VALUES (1, 'Fanerozoik');

INSERT INTO projekt.GeoEra (id_era, nazwa_era, id_eon) VALUES 
(1, 'Kenozoik', 1),
(2, 'Mezozoik', 1),
(3, 'Paleozoik', 1);

INSERT INTO projekt.GeoOkres (id_okres, nazwa_okres, id_era) VALUES 
(1, 'Czwartorzęd', 1),
(2, 'Neogen', 1),
(3, 'Paleogen', 1),
(4, 'Kreda', 2),
(5, 'Jura', 2),
(6, 'Trias', 2),
(7, 'Perm', 3),
(8, 'Karbon', 3),
(9, 'Dewon', 3);

INSERT INTO projekt.GeoEpoka (id_epoka, nazwa_epoka, id_okres) VALUES 
(1, 'Holocen', 1),
(2, 'Plejstocen', 1),
(3, 'Pliocen', 2),
(4, 'Miocen', 2),
(5, 'Oligocen', 3),
(6, 'Eocen', 3),
(7, 'Paleocen', 3),
(8, 'Górna', 4),
(9, 'Dolna', 4),
(10, 'Górna', 5),
(11, 'Środkowa', 5),
(12, 'Dolna', 5),
(13, 'Górna', 6),
(14, 'Środkowa', 6),
(15, 'Dolna', 6),
(16, 'Górny', 7),
(17, 'Dolny', 7),
(18, 'Górny', 8),
(19, 'Dolny', 8),
(20, 'Górny', 9),
(21, 'Środkowy', 9),
(22, 'Dolny', 9);

INSERT INTO projekt.GeoPietro (id_pietro, nazwa_pietro, id_epoka) VALUES 
(1, NULL, 1),
(2, NULL, 2),
(3, 'Gelas', 3),
(4, 'Piacent', 3),
(5, 'Zankl', 3),
(6, 'Mesyn', 4),
(7, 'Torton', 4),
(8, 'Serrawall', 4),
(9, 'Lang', 4),
(10, 'Burdigal', 4),
(11, 'Akwitan', 4),
(12, 'Szat', 5),
(13, 'Rupel', 5),
(14, 'Priabon', 6),
(15, 'Barton', 6),
(16, 'Lutet', 6),
(17, 'Iprez', 6),
(18, 'Thanet', 7),
(19, 'Zeland', 7),
(20, 'Dan', 7),
(21, 'Mastrycht', 8),
(22, 'Kampan', 8),
(23, 'Santon', 8),
(24, 'Koniak', 8),
(25, 'Turon', 8),
(26, 'Cenoman', 8),
(27, 'Alb', 9),
(28, 'Apt', 9),
(29, 'Barrem', 9),
(30, 'Hoteryw', 9),
(31, 'Walanżyn', 9),
(32, 'Berias', 9),
(33, 'Tyton', 10),
(34, 'Kimeryd', 10),
(35, 'Oksford', 10),
(36, 'Keleowej', 11),
(37, 'Baton', 11),
(38, 'Bajos', 11),
(39, 'Aalen', 11),
(40, 'Toark', 12),
(41, 'Pliensbach', 12),
(42, 'Synemur', 12),
(43, 'Hetang', 12),
(44, 'Retyk', 13),
(45, 'Noryk', 13),
(46, 'Karnik', 13),
(47, 'Ladyn', 14),
(48, 'Anizyk', 14),
(49, 'Olenek', 15),
(50, 'Ind', 15),
(51, 'Tatar', 16),
(52, 'Kazań', 16),
(53, 'Ufa', 16),
(54, 'Kangur', 17),
(55, 'Artinsk', 17),
(56, 'Sakmar', 17),
(57, 'Assel', 17),
(58, 'Gżel', 18),
(59, 'Kasimow', 18),
(60, 'Moskow', 18),
(61, 'Baszkir', 18),
(62, 'Serpuchow', 19),
(63, 'Wizen', 19),
(64, 'Turnej', 19),
(65, 'Famen', 20),
(66, 'Fran', 20),
(67, 'Żywet', 21),
(68, 'Eifel', 21),
(69, 'Ems', 22),
(70, 'Prag', 22),
(71, 'Lochkow', 22);

CREATE TABLE projekt.GeoTabela AS (SELECT * FROM projekt.GeoPietro NATURAL JOIN projekt.GeoEpoka NATURAL
JOIN projekt.GeoOkres NATURAL JOIN projekt.GeoEra NATURAL JOIN projekt.GeoEon );

ALTER TABLE projekt.geotabela ADD CONSTRAINT geotabela_pk PRIMARY KEY (id_pietro);


CREATE TABLE projekt.Dziesiec (
    cyfra INT PRIMARY KEY
);

-- Wstawianie danych do tabeli Dziesiec
INSERT INTO projekt.Dziesiec (cyfra) VALUES 
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE projekt.Milion (
    liczba INT NOT NULL PRIMARY KEY,
    cyfra INT
);

-- Wypełnianie tabeli Milion liczbami od 0 do 999 999 za pomocą autozłączenia tabeli Dziesiec
INSERT INTO projekt.Milion 
SELECT a1.cyfra + 10 * a2.cyfra + 100 * a3.cyfra + 1000 * a4.cyfra + 10000 * a5.cyfra + 100000 * a6.cyfra AS liczba, 
       a1.cyfra AS cyfra
FROM projekt.Dziesiec a1, 
     projekt.Dziesiec a2, 
     projekt.Dziesiec a3, 
     projekt.Dziesiec a4, 
     projekt.Dziesiec a5, 
     projekt.Dziesiec a6
ORDER BY liczba ASC;


select * from projekt.Milion

-- Zapytanie 1ZL
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM projekt.Milion M
INNER JOIN projekt.GeoTabela ON mod(M.liczba,71) = (projekt.GeoTabela.id_pietro);

-- Zapytanie 2ZL
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM projekt.Milion M
INNER JOIN projekt.GeoPietro ON mod(M.liczba,71) = GeoPietro.id_pietro
NATURAL JOIN projekt.GeoEpoka
NATURAL JOIN projekt.GeoOkres
NATURAL JOIN projekt.GeoEra
NATURAL JOIN projekt.GeoEon;

-- Zapytanie 3ZG
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM projekt.Milion M
WHERE mod(M.liczba,71) IN (SELECT id_pietro FROM projekt.GeoTabela WHERE mod(M.liczba,71) IN (id_pietro));

-- Zapytanie 4ZG
EXPLAIN ANALYZE
SELECT COUNT(*) FROM projekt.Milion M 
WHERE mod(M.liczba,71) IN
(SELECT id_pietro 
FROM projekt.GeoPietro 
NATURAL JOIN projekt.GeoEpoka 
NATURAL JOIN projekt.GeoOkres 
NATURAL JOIN projekt.GeoEra 
NATURAL JOIN projekt.GeoEon);


-- Nałożenie Indeksów
-- Indeksy dla tabeli Milion
CREATE INDEX idx_Milion_liczba ON projekt.Milion (liczba);

-- Indeksy dla tabeli GeoPietro
CREATE INDEX idx_GeoPietro_id_pietro ON projekt.GeoPietro (id_pietro);
CREATE INDEX idx_GeoPietro_id_epoka ON projekt.GeoPietro (id_epoka);

-- Indeksy dla tabeli GeoEpoka
CREATE INDEX idx_GeoEpoka_id_epoka ON projekt.GeoEpoka (id_epoka);
CREATE INDEX idx_GeoEpoka_id_okres ON projekt.GeoEpoka (id_okres);

-- Indeksy dla tabeli GeoOkres
CREATE INDEX idx_GeoOkres_id_okres ON projekt.GeoOkres (id_okres);
CREATE INDEX idx_GeoOkres_id_era ON projekt.GeoOkres (id_era);

-- Indeksy dla tabeli GeoEra
CREATE INDEX idx_GeoEra_id_era ON projekt.GeoEra (id_era);
CREATE INDEX idx_GeoEra_id_eon ON projekt.GeoEra (id_eon);

-- Indeksy dla tabeli GeoEon
CREATE INDEX idx_GeoEon_id_eon ON projekt.GeoEon (id_eon);

-- Indeksy dla tabeli GeoTabela
CREATE INDEX idx_GeoTabela_id_pietro ON projekt.GeoTabela (id_pietro);


