CREATE DATABASE stratygrafia;
GO
USE	stratygrafia;
GO
CREATE SCHEMA projekt;
GO

CREATE TABLE projekt.GeoEon (
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
(1, 'Czwartorzêd', 1),
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
(11, 'Œrodkowa', 5),
(12, 'Dolna', 5),
(13, 'Górna', 6),
(14, 'Œrodkowa', 6),
(15, 'Dolna', 6),
(16, 'Górny', 7),
(17, 'Dolny', 7),
(18, 'Górny', 8),
(19, 'Dolny', 8),
(20, 'Górny', 9),
(21, 'Œrodkowy', 9),
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
(31, 'Walan¿yn', 9),
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
(52, 'Kazañ', 16),
(53, 'Ufa', 16),
(54, 'Kangur', 17),
(55, 'Artinsk', 17),
(56, 'Sakmar', 17),
(57, 'Assel', 17),
(58, 'G¿el', 18),
(59, 'Kasimow', 18),
(60, 'Moskow', 18),
(61, 'Baszkir', 18),
(62, 'Serpuchow', 19),
(63, 'Wizen', 19),
(64, 'Turnej', 19),
(65, 'Famen', 20),
(66, 'Fran', 20),
(67, '¯ywet', 21),
(68, 'Eifel', 21),
(69, 'Ems', 22),
(70, 'Prag', 22),
(71, 'Lochkow', 22);

SELECT 
    GeoPietro.id_pietro,
    GeoEon.nazwa_eon,    
	GeoEra.nazwa_era,
	GeoOkres.nazwa_okres,
	GeoEpoka.nazwa_epoka,
	GeoPietro.nazwa_pietro,
	GeoEon.id_eon,    
	GeoEra.id_era,
	GeoOkres.id_okres,
	GeoEpoka.id_epoka
INTO projekt.GeoTabela
FROM projekt.GeoPietro
INNER JOIN projekt.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
INNER JOIN projekt.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
INNER JOIN projekt.GeoEra ON GeoOkres.id_era = GeoEra.id_era
INNER JOIN projekt.GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

ALTER TABLE projekt.GeoTabela
ADD CONSTRAINT PK_GeoTabela PRIMARY KEY (id_pietro);