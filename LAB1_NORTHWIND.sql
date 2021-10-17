-- Dane z bazy Northwind

-- Podstawowe selecty

-- 1. Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address, City, Region, Country FROM Customers

-- 2. Wybierz nazwiska i numery telefonów pracowników
SELECT LastName, HomePhone FROM Employees

-- 3. Wybierz nazwy i ceny produktów
SELECT ProductName, UnitPrice FROM Products

-- 4. Pokaż nazwy i opisy wszystkich kategorii produktów
SELECT CategoryName, Description FROM Categories

-- 5. Pokaż nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage FROM Suppliers


-- Selecty z określonymi wymogami

-- 1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
SELECT CompanyName, Address, City, Country FROM Customers WHERE City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address, City, Country FROM Customers WHERE Country = 'France' OR Country = 'Spain'

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20 a 30.
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

-- 4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
SELECT ProductName, UnitPrice FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories 
WHERE CategoryName LIKE '%meat%')

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
SELECT ProductName, UnitsInStock FROM Products WHERE SupplierID IN (SELECT SupplierID FROM Suppliers 
WHERE CompanyName LIKE 'Tokyo Traders')

-- 6. Wybierz nazwy produktów których nie ma w magazyni
SELECT ProductName FROM Products WHERE UnitsInStock = 0


-- Selecty z porównywaniem napisów

-- 1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

-- 2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
SELECT FirstName, LastName, Title From Employees WHERE LastName LIKE '[B-L]%'

-- 3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
SELECT FirstName, LastName, Title FROM Employees WHERE LastName LIKE '[BL]%'

-- 4. Znajdź nazwy kategorii, które w opisie zawierają przecinek
SELECT CategoryName FROM Categories WHERE Description LIKE '%,%'

-- 5. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
SELECT * FROM Customers WHERE CompanyName LIKE '%Store%'


-- Zakresy, zmienne logiczne

-- 1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 and 30

-- 3. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
SELECT CompanyName, Country FROM Customers WHERE Country LIKE 'Japan' OR Country LIKE 'Italy'


-- Sortowanie danych

-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju,
-- w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country FROM Customers ORDER BY Country, CompanyName

-- 2. Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny
SELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID, UnitPrice DESC

-- 3. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Wielkiej Brytanii (UK) lub we Włoszech (Italy),
-- wyniki posortuj tak jak w pkt 1
SELECT CompanyName, Country FROM Customers WHERE Country LIKE 'UK' OR Country LIKE 'Italy'
