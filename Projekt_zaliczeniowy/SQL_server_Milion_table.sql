USE	stratygrafia;
GO
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

-- Wype³nianie tabeli Milion liczbami od 0 do 999 999 za pomoc¹ autoz³¹czenia tabeli Dziesiec
INSERT INTO projekt.Milion SELECT a1.cyfra +10* a2.cyfra + 100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 100000*a6.cyfra AS liczba, 
a1.cyfra AS cyfra
FROM projekt.Dziesiec a1, projekt.Dziesiec a2, projekt.Dziesiec a3, projekt.Dziesiec a4, projekt.Dziesiec a5, projekt.Dziesiec a6
ORDER BY liczba ASC;
