-- Zastosowania agregatów

-- 1. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
SELECT COUNT(*) FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
SELECT Max(UnitPrice) FROM Products WHERE UnitPrice < 20 

-- 3. Podaj maksymalną, minimalną i średnią cenę produktu dla produktów sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice) as Maxprice, MIN(UnitPrice) as Minprice, AVG(UnitPrice) as avgprice 
FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

-- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- 5. Podaj wartość zamówienia o numerze 10250
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) FROM [Order Details]
WHERE OrderID = 10250


--Zastosowania GROUP BY

-- 1. Podaj maksymalną cenę zamawianego produktu dla
-- każdego zamówienia. Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice) as Maxprice FROM [Order Details] GROUP BY OrderID  ORDER BY Maxprice DESC

-- 2. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID, MAX(UnitPrice) as MAxprice, MIN(UnitPrice) as Minprice
FROM [Order Details] GROUP BY OrderID

-- 3. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów
SELECT COUNT(*) as Orders, ShipVia FROM Orders GROUP BY ShipVia

-- 4. Który ze spedytorów był najaktywniejszy w 1997 roku?
SELECT TOP 1 ShipVia, COUNT(*) as Orders1997 FROM Orders WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia ORDER BY Orders1997 DESC


--HAVING

--1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderID FROM [Order Details] GROUP BY OrderID HAVING COUNT(*) > 5


--2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień
--(wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla
--każdego z klientów)
SELECT CustomerID, COUNT(*) as 'cnt' FROM Orders 
WHERE YEAR(ShippedDate) = 1998 
GROUP BY CustomerID HAVING COUNT(*) > 8 ORDER BY 'cnt' DESC


--Zadania do przećwiczenia
--1. Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia i
--zwraca wynik posortowany w malejącej kolejności (wg wartości sprzedaży).
SELECT SUM(UnitPrice*Quantity*(1-Discount)) as 'price' , OrderID
FROM [Order Details] GROUP BY OrderID ORDER BY 'price' DESC


--2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało pierwszych
--10 wierszy
SELECT TOP 10 SUM(UnitPrice*Quantity*(1-Discount)) as 'price' , OrderID
FROM [Order Details] GROUP BY OrderID ORDER BY 'price' DESC


--3. Podaj liczbę zamówionych jednostek produktów dla produktów, dla których
--productid < 3
SELECT SUM(Quantity) FROM [Order Details] WHERE ProductID < 3 GROUP BY ProductID


--4. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę
--zamówionych jednostek produktu dla wszystkich produktów
SELECT SUM(Quantity) FROM [Order Details] GROUP BY ProductID


--5. Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których
--łączna liczba zamawianych jednostek produktów jest > 250 
SELECT OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'price' 
FROM [Order Details] GROUP BY OrderID HAVING SUM(Quantity)>250


--6. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień
SELECT EmployeeID, COUNT(*) FROM Orders GROUP BY EmployeeID


--7. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień
SELECT ShipVia, SUM(Freight) FROM Orders GROUP BY ShipVia


--8. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień w latach o 1996 do 1997
SELECT ShipVia, SUM(Freight) FROM Orders WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997 GROUP BY ShipVia


--9. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
--podziałem na lata i miesiące
SELECT COUNT(*),EmployeeID,YEAR(ShippedDate)as year,MONTH(ShippedDate) as month 
    FROM Orders WHERE ShippedDate IS NOT NULL 
    GROUP BY EmployeeID,YEAR(ShippedDate),MONTH(ShippedDate)
	WITH ROLLUP
	

--10. Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
--kategorii
SELECT CategoryID, MIN(UnitPrice), MAX(UnitPrice) FROM Products GROUP BY CategoryID
