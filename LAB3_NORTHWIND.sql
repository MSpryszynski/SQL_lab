--1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
--pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20 AND 30


--2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów
--dostarczanych przez firmê ‘Tokyo Traders’
SELECT ProductName, UnitsInStock, Suppliers.CompanyName FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Tokyo Traders'


--3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeżli tak
--to pokaż ich dane adresowe
SELECT Address + ' ' + City FROM Customers
LEFT OUTER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID AND YEAR(OrderDate) = 1997
WHERE YEAR(OrderDate) IS NULL


--4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty,
--których aktualnie nie ma w magazynie
SELECT CompanyName, Phone FROM Suppliers
INNER JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
WHERE UnitsInStock = 0


--5. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
--pomiędzy 20.00 a 30.00, dla ka¿dego produktu podaj dane adresowe dostawcy,
--interesują nas tylko produkty z kategorii ‘Meat/Poultry
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
INNER JOIN Categories
ON Categories.CategoryID = Products.CategoryID
WHERE UnitPrice BETWEEN 20 AND 30 and CategoryName = 'Meat/Poultry'


--6. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu
--podaj nazwę dostawcy.
SELECT ProductName, UnitPrice, Suppliers.Address FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Categories.CategoryName = 'Confections'


--7. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
--dostarczała firma ‘United Package’
SELECT Customers.CompanyName, Customers.Phone FROM Customers 
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
WHERE YEAR(ShippedDate) = 1997 AND Shippers.CompanyName = 'United Package'


--8. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
--‘Confections’
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


--9. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza
--northwind)
SELECT E.LastName, E.FirstName, E2.EmployeeID FROM Employees E
LEFT OUTER JOIN Employees E2
ON E2.ReportsTo=E.EmployeeID


--10. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych
--(baza northwind)
SELECT E.LastName, E.FirstName FROM Employees E
LEFT OUTER JOIN Employees E2
ON E2.ReportsTo=E.EmployeeID
WHERE E2.EmployeeID IS NULL


--11. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz
--nazwę klienta.
SELECT [Order Details].OrderID, CompanyName, SUM(Quantity) FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY [Order Details].OrderID, CompanyName


--12. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
--łączna liczba zamówionych jednostek jest większa niż 250
SELECT [Order Details].OrderID, CompanyName, SUM(Quantity) FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY [Order Details].OrderID, CompanyName
HAVING SUM(Quantity)>250


--13. Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę
--klienta i  imiê i nazwisko pracownika dla zamówieñ dla których
-- łączna liczba jednostek jest większa niż 250.
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


--14. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
--klientów jednostek towarów z tej kategorii.
SELECT CategoryName, SUM(Quantity) FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName


--15. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
--klientów jednostek towarów z tek kategorii.
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName


--16. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
--a) łącznej wartoœci zamówieñ
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY price DESC

--b) łącznej liczby zamówionych przez klientów jednostek towarów.
SELECT CategoryName, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice) AS 'price' FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details]
ON [Order Details].ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity) DESC


--17. Dla każdego zamówienia podaj jego wartość uwzglêdniając opłatę za przesyłkę
SELECT Orders.OrderID, SUM(Quantity * (1-Discount) * [Order Details].UnitPrice)+Freight AS 'price' FROM [Order Details]
INNER JOIN Orders
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Orders.OrderID, Freight


--18. Dla każdego przewoźnika (nazwa) podaj liczbê zamówień które przewieźli w 1997r
SELECT CompanyName, COUNT(*) FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate)=1997
GROUP BY CompanyName


--19. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę
--zamówień) w 1997r, podaj nazwę tego przewoźnika
SELECT TOP 1 CompanyName FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(ShippedDate)=1997
GROUP BY CompanyName
ORDER BY COUNT(*) DESC


--20. Dla ka¿dego pracownika (imię i nazwisko) podaj łączną wartość zamówień
--obsłużonych przez tego pracownika
SELECT FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName


--21. Który z pracowników obsłużył najwiêkszą liczbê zamówieñ w 1997r, podaj imię i
--nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, COUNT(*) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(ShippedDate) = 1997
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY COUNT(*) DESC


--22. Który z pracowników był najaktywniejszy (obsłużył zamówienia o
--największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
SELECT TOP 1 FirstName, LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(ShippedDate) = 1997
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY SUM(Quantity * UnitPrice * (1-Discount)) DESC


--1. Dla każdego pracownika (imiê i nazwisko) podaj łączną wartość zamówień
--obsłużonych przez tego pracownika
--Ogranicz wynik tylko do pracowników

--a) którzy mają podwładnych
SELECT DISTINCT Employees.FirstName, Employees.LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
LEFT OUTER JOIN Employees AS E2
ON E2.ReportsTo = Employees.EmployeeID
WHERE E2.EmployeeID IS NOT NULL
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, E2.EmployeeID


--b) którzy nie mają podwładnych
SELECT Employees.FirstName, Employees.LastName, SUM(Quantity * UnitPrice * (1-Discount)) FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details]
ON [Order Details].OrderID = Orders.OrderID
LEFT OUTER JOIN Employees AS E2
ON E2.ReportsTo = Employees.EmployeeID
WHERE E2.EmployeeID IS NULL
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
