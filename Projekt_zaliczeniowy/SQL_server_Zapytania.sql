Use stratygrafia;
GO


--Zapytanie 1ZL
set statistics time on
SELECT COUNT(*) FROM projekt.Milion M
INNER JOIN projekt.GeoTabela ON (M.liczba % 71) = (projekt.GeoTabela.id_pietro);
set statistics time off




-- Zapytanie 2ZL
set statistics time on
SELECT COUNT(*) 
FROM projekt.Milion M
INNER JOIN projekt.GeoPietro ON (M.liczba % 71) = GeoPietro.id_pietro
INNER JOIN projekt.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
INNER JOIN projekt.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
INNER JOIN projekt.GeoEra ON GeoOkres.id_era = GeoEra.id_era
INNER JOIN projekt.GeoEon ON GeoEra.id_eon = GeoEon.id_eon;
set statistics time off


-- Zapytanie 3ZG

set statistics time on
SELECT COUNT(*) FROM projekt.Milion M
WHERE (M.liczba % 71) = (SELECT id_pietro FROM projekt.GeoTabela WHERE (M.liczba % 71) = (id_pietro));
set statistics time off

-- Zapytanie 4ZG
set statistics time on
SELECT COUNT(*)
FROM projekt.Milion M
WHERE (M.liczba % 71) IN (
    SELECT id_pietro
    FROM projekt.GeoPietro
    INNER JOIN projekt.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
    INNER JOIN projekt.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
    INNER JOIN projekt.GeoEra ON GeoOkres.id_era = GeoEra.id_era
    INNER JOIN projekt.GeoEon ON GeoEra.id_eon = GeoEon.id_eon);
set statistics time off

-- Na³o¿enie Indeksów
set statistics time on
-- Indeksy dla tabeli Milion
CREATE NONCLUSTERED INDEX idx_Milion_liczba ON projekt.Milion (liczba);

-- Indeksy dla tabeli GeoPietro
CREATE NONCLUSTERED INDEX idx_GeoPietro_id_pietro ON projekt.GeoPietro (id_pietro);
CREATE NONCLUSTERED INDEX idx_GeoPietro_id_epoka ON projekt.GeoPietro (id_epoka);

-- Indeksy dla tabeli GeoEpoka
CREATE NONCLUSTERED INDEX idx_GeoEpoka_id_epoka ON projekt.GeoEpoka (id_epoka);
CREATE NONCLUSTERED INDEX idx_GeoEpoka_id_okres ON projekt.GeoEpoka (id_okres);

-- Indeksy dla tabeli GeoOkres
CREATE NONCLUSTERED INDEX idx_GeoOkres_id_okres ON projekt.GeoOkres (id_okres);
CREATE NONCLUSTERED INDEX idx_GeoOkres_id_era ON projekt.GeoOkres (id_era);

-- Indeksy dla tabeli GeoEra
CREATE NONCLUSTERED INDEX idx_GeoEra_id_era ON projekt.GeoEra (id_era);
CREATE NONCLUSTERED INDEX idx_GeoEra_id_eon ON projekt.GeoEra (id_eon);

-- Indeksy dla tabeli GeoEon
CREATE NONCLUSTERED INDEX idx_GeoEon_id_eon ON projekt.GeoEon (id_eon);

-- Indeksy dla tabeli GeoTabela
CREATE NONCLUSTERED INDEX idx_GeoTabela_id_pietro ON projekt.GeoTabela (id_pietro);
set statistics time off


--Sprawdzenie INDEKSÓW
SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('projekt.GeoTabela');


SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('projekt.Milion');



-- Usuniêcie indeksów z tabeli Milion
DROP INDEX idx_Milion_liczba ON projekt.Milion;

-- Usuniêcie indeksów z tabeli GeoPietro
DROP INDEX idx_GeoPietro_id_pietro ON projekt.GeoPietro;
DROP INDEX idx_GeoPietro_id_epoka ON projekt.GeoPietro;

-- Usuniêcie indeksów z tabeli GeoEpoka
DROP INDEX idx_GeoEpoka_id_epoka ON projekt.GeoEpoka;
DROP INDEX idx_GeoEpoka_id_okres ON projekt.GeoEpoka;

-- Usuniêcie indeksów z tabeli GeoOkres
DROP INDEX idx_GeoOkres_id_okres ON projekt.GeoOkres;
DROP INDEX idx_GeoOkres_id_era ON projekt.GeoOkres;

-- Usuniêcie indeksów z tabeli GeoEra
DROP INDEX idx_GeoEra_id_era ON projekt.GeoEra;
DROP INDEX idx_GeoEra_id_eon ON projekt.GeoEra;

-- Usuniêcie indeksów z tabeli GeoEon
DROP INDEX idx_GeoEon_id_eon ON projekt.GeoEon;
