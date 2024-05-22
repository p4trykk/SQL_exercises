-- Wyświetl zamówienia złożone w czwartym kwartale 1996 roku
SELECT *
FROM Zamowienia
WHERE YEAR(data_zlozenia) = 1996 AND QUARTER(data_zlozenia) = 4;
-- Wyświetlić pierwszych pięciu pracowników banku (nr, imię, nazwisko), których nazwiska lub imiona rozpoczynają się literą "J" i data urodzenia jest między 01-01-1970 i 31-12-1980, posortowane malejąco wg numerów
SELECT TOP 5 pr_nr, pr_imie, pr_nazwisko
FROM Pracownicy
WHERE (pr_imie LIKE 'J%' OR pr_nazwisko LIKE 'J%') AND pr_data_ur BETWEEN '1970-01-01' AND '1980-12-31'
ORDER BY pr_nr DESC;
-- Wyświetlić imiona, nazwiska i numery wyróżnionych pracowników
SELECT pr_imie, pr_nazwisko, pr_nr
FROM Pracownicy
JOIN Wyroznieni ON pr_nr = wyr_pr_nr
ORDER BY pr_nr;
-- Wyświetlić ilość miejscowości zamieszkania pracowników (niepowtarzających się)
SELECT COUNT(DISTINCT pr_miejscowosc_zam)
FROM Pracownicy;
-- Wyświetlić nazwiska pracowników, którzy nie sprzedali żadnego produktu
SELECT pr_nazwisko
FROM Pracownicy
WHERE pr_nr NOT IN (
    SELECT spr_pr_nr
    FROM Sprzedaz
)
ORDER BY pr_nazwisko;
-- Wyświetlić nazwę regionu oraz liczbę pracowników pracujących w regionie
SELECT odd_region, COUNT(DISTINCT pr_nr)
FROM Pracownicy
JOIN Oddzialy ON pr_odd_nr_rozlicz = odd_nr_rozlicz
GROUP BY odd_region;
-- Wyświetlić imiona i nazwiska pracowników, którzy sprzedali większą liczbę produktów niż wynosi średnia sprzedaż produktów przypadająca na jednego pracownika
SELECT pr_imie, pr_nazwisko
FROM Pracownicy
WHERE pr_nr IN (
    SELECT spr_pr_nr
    FROM Sprzedaz
    GROUP BY spr_pr_nr
    HAVING COUNT(spr_prod_nr) > (
        SELECT AVG(sprzedaz_pracownika)
        FROM (
            SELECT COUNT(spr_prod_nr) AS sprzedaz_pracownika
            FROM Sprzedaz
            GROUP BY spr_pr_nr
        ) AS t
    )
);
-- Wyświetlić statystykę liczby pracowników zamieszkałych w poszczególnych miejscowościach
SELECT pr_miejscowosc_zam, COUNT(DISTINCT pr_nr)
FROM Pracownicy
GROUP BY pr_miejscowosc_zam;
-- Wyświetlić statystykę liczby sprzedanych produktów dla poszczególnych pracowników
SELECT spr_pr_nr, COUNT(DISTINCT spr_prod_nr)
FROM Sprzedaz
GROUP BY spr_pr_nr;
-- Wyświetlić sumę punktów sprzedanych produktów dla poszczególnych pracowników
SELECT spr_pr_nr, SUM(Produkty.prod_punktacja)
FROM Sprzedaz
JOIN Produkty ON Sprzedaz.spr_prod_nr = Produkty.prod_nr
GROUP BY spr_pr_nr;