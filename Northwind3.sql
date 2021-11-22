--1. Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej
--pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20 AND 30


--2. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w
--dostarczanych przez firm� �Tokyo Traders�
SELECT ProductName, UnitsInStock, Suppliers.CompanyName FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Tokyo Traders'


--3. Czy s� jacy� klienci kt�rzy nie z�o�yli �adnego zam�wienia w 1997 roku, je�li tak
--to poka� ich dane adresowe
SELECT Address + ' ' + City FROM Customers
LEFT OUTER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID AND YEAR(OrderDate) = 1997
WHERE YEAR(OrderDate) IS NULL


--4. Wybierz nazwy i numery telefon�w dostawc�w, dostarczaj�cych produkty,
--kt�rych aktualnie nie ma w magazynie
SELECT CompanyName, Phone FROM Suppliers
INNER JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitsInStock = 0


--5. Wybierz nazwy i ceny produkt�w (baza northwind) o cenie jednostkowej
--pomi�dzy 20.00 a 30.00, dla ka�dego produktu podaj dane adresowe dostawcy,
--interesuj� nas tylko produkty z kategorii �Meat/Poultry
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
WHERE UnitPrice BETWEEN 20 AND 30 and CategoryName = 'Meat/Poultry'


--6. Wybierz nazwy i ceny produkt�w z kategorii �Confections� dla ka�dego produktu
--podaj nazw� dostawcy.
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Categories.CategoryName = 'Confections'


--7. Wybierz nazwy i numery telefon�w klient�w , kt�rym w 1997 roku przesy�ki
--dostarcza�a firma �United Package�
SELECT Customers.CompanyName, Customers.Phone FROM Customers 
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
WHERE YEAR(ShippedDate) = 1997 AND Shippers.CompanyName = 'United Package'


--8. Wybierz nazwy i numery telefon�w klient�w, kt�rzy kupowali produkty z kategorii
--�Confections�
SELECT DISTINCT Customers.CompanyName, Customers.Phone FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products
ON Products.ProductID = [Order Details].ProductID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
WHERE Categories.CategoryName = 'Confections'


--9. Napisz polecenie, kt�re wy�wietla pracownik�w oraz ich podw�adnych (baza
--northwind)
SELECT E.LastName, E.FirstName, E2.EmployeeID FROM Employees E
LEFT OUTER JOIN Employees E2
ON E2.ReportsTo=E.EmployeeID


--10. Napisz polecenie, kt�re wy�wietla pracownik�w, kt�rzy nie maj� podw�adnych
--(baza northwind)
SELECT E.LastName, E.FirstName FROM Employees E
LEFT OUTER JOIN Employees E2
ON E2.ReportsTo=E.EmployeeID
WHERE E2.EmployeeID IS NULL


--11. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek towaru oraz
--nazw� klienta.
SELECT [Order Details].OrderID, CompanyName, SUM(Quantity) FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY [Order Details].OrderID, CompanyName


--12. Zmodyfikuj poprzedni przyk�ad, aby pokaza� tylko takie zam�wienia, dla kt�rych
--��czna liczb� zam�wionych jednostek jest wi�ksza ni� 250
SELECT [Order Details].OrderID, CompanyName, SUM(Quantity) FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY [Order Details].OrderID, CompanyName
HAVING SUM(Quantity)>250


--13. Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia oraz nazw�
--klienta i  imi� i nazwisko pracownika dla zam�wie� dla kt�rych
-- ��czna liczba jednostek jest wi�ksza ni� 250.
SELECT [Order Details].OrderID, SUM(UnitPrice*Quantity*(1-Discount)),
CompanyName, FirstName, LastName FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees 
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY CompanyName, FirstName, LastName, [Order Details].OrderID
HAVING SUM(Quantity)>250


--14. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� zam�wionych przez
--klient�w jednostek towar�w z tek kategorii.
SELECT CategoryName, SUM(Quantity) FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName


--15. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto�� zam�wionych przez
--klient�w jednostek towar�w z tek kategorii.
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName


--16. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
--a) ��cznej warto�ci zam�wie�
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY price DESC

--b) ��cznej liczby zam�wionych przez klient�w jednostek towar�w.
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity) DESC


--17. Dla ka�dego zam�wienia podaj jego warto�� uwzgl�dniaj�c op�at� za przesy�k�
SELECT Orders.OrderID, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice)+Freight AS 'price' FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Orders.OrderID, Freight


--18. Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie� kt�re przewie�li w 1997r
SELECT CompanyName, COUNT(*) FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate)=1997
GROUP BY CompanyName


--19. Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz� liczb�
--zam�wie�) w 1997r, podaj nazw� tego przewo�nika
SELECT TOP 1 CompanyName FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate)=1997
GROUP BY CompanyName
ORDER BY COUNT(*) DESC


--20. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie�
--obs�u�onych przez tego pracownika
SELECT FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName


--21. Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1997r, podaj imi� i
--nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, COUNT(*) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(ShippedDate) = 1997
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY COUNT(*) DESC


--22. Kt�ry z pracownik�w obs�u�y� najaktywniejszy (obs�u�y� zam�wienia o
--najwi�kszej warto�ci) w 1997r, podaj imi� i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(ShippedDate) = 1997
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY SUM(Quantity * UnitPrice * (1-Discount)) DESC


--1. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie�
--obs�u�onych przez tego pracownika
--Ogranicz wynik tylko do pracownik�w

--a) kt�rzy maj� podw�adnych
SELECT DISTINCT Employees.FirstName, Employees.LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
LEFT OUTER JOIN Employees AS E2
ON E2.ReportsTo = Employees.EmployeeID
WHERE E2.EmployeeID IS NOT NULL
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, E2.EmployeeID


--b) kt�rzy nie maj� podw�adnych
SELECT Employees.FirstName, Employees.LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
LEFT OUTER JOIN Employees AS E2
ON E2.ReportsTo = Employees.EmployeeID
WHERE E2.EmployeeID IS NULL
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName