SELECT Phone + ', ' + ISNull(Fax, '') as phonefax FROM Suppliers
-- Zastosowania agregat�w

-- 1. Podaj liczb� produkt�w o cenach mniejszych ni� 10$ lub wi�kszych ni� 20$
SELECT COUNT(*) FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

-- 2. Podaj maksymaln� cen� produktu dla produkt�w o cenach poni�ej 20$
SELECT Max(UnitPrice) FROM Products WHERE UnitPrice < 20 

-- 3. Podaj maksymaln�, minimaln� i �redni� cen� produktu dla produkt�w sprzedawanych w butelkach (�bottle�)
SELECT MAX(UnitPrice) as Maxprice, MIN(UnitPrice) as Minprice, AVG(UnitPrice) as avgprice 
FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

-- 4. Wypisz informacj� o wszystkich produktach o cenie powy�ej �redniej
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- 5. Podaj warto�� zam�wienia o numerze 10250
SELECT * FROM [Order Details] WHERE OrderID = 10250

--Zastosowania GROUP BY

-- 1. Podaj maksymaln� cen� zamawianego produktu dla
-- ka�dego zam�wienia. Posortuj zam�wienia wg maksymalnej ceny produktu
SELECT OrderID, MAX(UnitPrice) as Maxprice FROM [Order Details] GROUP BY OrderID  ORDER BY Maxprice DESC

-- 2. Podaj maksymaln� i minimaln� cen� zamawianego produktu dla ka�dego zam�wienia
SELECT OrderID, MAX(UnitPrice) as MAxprice, MIN(UnitPrice) as Minprice
FROM [Order Details] GROUP BY OrderID

-- 3. Podaj liczb� zam�wie� dostarczanych przez poszczeg�lnych spedytor�w
SELECT COUNT(*) as Orders, ShipVia FROM Orders GROUP BY ShipVia

-- 4. Kt�ry ze spedytor�w by� najaktywniejszy w 1997 roku?
SELECT TOP 1 ShipVia, COUNT(*) as Orders1997 FROM Orders WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia ORDER BY Orders1997 DESC
