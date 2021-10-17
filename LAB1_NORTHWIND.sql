-- Dane z bazy Northwind

-- Podstawowe selecty

-- 1. Wybierz nazwy i adresy wszystkich klient�w
SELECT CompanyName, Address, City, Region, Country FROM Customers

-- 2. Wybierz nazwiska i numery telefon�w pracownik�w
SELECT LastName, HomePhone FROM Employees

-- 3. Wybierz nazwy i ceny produkt�w
SELECT ProductName, UnitPrice FROM Products

-- 4. Poka� nazwy i opisy wszystkich kategorii produkt�w
SELECT CategoryName, Description FROM Categories

-- 5. Poka� nazwy i adresy stron www dostawc�w
SELECT CompanyName, HomePage FROM Suppliers


-- Selecty z okre�lonymi wymogami

-- 1. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie
SELECT CompanyName, Address, City, Country FROM Customers WHERE City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address, City, Country FROM Customers WHERE Country = 'France' OR Country = 'Spain'

-- 3. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20 a 30

-- 4. Wybierz nazwy i ceny produkt�w z kategorii �meat�
WHERE CategoryName LIKE '%meat%')

-- 5. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� �Tokyo Traders�
SELECT ProductName, UnitsInStock FROM Products WHERE SupplierID IN (SELECT SupplierID FROM Suppliers 
WHERE CompanyName LIKE 'Tokyo Traders')

-- 6. Wybierz nazwy produkt�w kt�rych nie ma w magazyni
SELECT ProductName FROM Products WHERE UnitsInStock = 0


-- Selecty z por�wnywaniem napis�w

-- 1. Szukamy informacji o produktach sprzedawanych w butelkach (�bottle�)