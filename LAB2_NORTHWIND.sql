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
SELECT * FROM [Order Details] WHERE OrderID = 10250

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
