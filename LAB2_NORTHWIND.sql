SELECT Phone + ', ' + ISNull(Fax, '') as phonefax FROM Suppliers
-- Zastosowania agregatów

-- 1. Podaj liczbê produktów o cenach mniejszych ni¿ 10$ lub wiêkszych ni¿ 20$
SELECT COUNT(*) FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

-- 2. Podaj maksymaln¹ cenê produktu dla produktów o cenach poni¿ej 20$
SELECT Max(UnitPrice) FROM Products WHERE UnitPrice < 20 

-- 3. Podaj maksymaln¹, minimaln¹ i œredni¹ cenê produktu dla produktów sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice) as Maxprice, MIN(UnitPrice) as Minprice, AVG(UnitPrice) as avgprice 
FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

-- 4. Wypisz informacjê o wszystkich produktach o cenie powy¿ej œredniej
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- 5. Podaj wartoœæ zamówienia o numerze 10250
SELECT * FROM [Order Details] WHERE OrderID = 10250

--Zastosowania GROUP BY

-- 1. Podaj maksymaln¹ cenê zamawianego produktu dla
-- ka¿dego zamówienia. Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice) as Maxprice FROM [Order Details] GROUP BY OrderID  ORDER BY Maxprice DESC

-- 2. Podaj maksymaln¹ i minimaln¹ cenê zamawianego produktu dla ka¿dego zamówienia
SELECT OrderID, MAX(UnitPrice) as MAxprice, MIN(UnitPrice) as Minprice
FROM [Order Details] GROUP BY OrderID

-- 3. Podaj liczbê zamówieñ dostarczanych przez poszczególnych spedytorów
SELECT COUNT(*) as Orders, ShipVia FROM Orders GROUP BY ShipVia

-- 4. Który ze spedytorów by³ najaktywniejszy w 1997 roku?
SELECT TOP 1 ShipVia, COUNT(*) as Orders1997 FROM Orders WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia ORDER BY Orders1997 DESC
