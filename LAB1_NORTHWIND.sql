-- Dane z bazy Northwind

-- Podstawowe selecty

-- 1. Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address, City, Region, Country FROM Customers

-- 2. Wybierz nazwiska i numery telefonów pracowników
SELECT LastName, HomePhone FROM Employees

-- 3. Wybierz nazwy i ceny produktów
SELECT ProductName, UnitPrice FROM Products

-- 4. Poka¿ nazwy i opisy wszystkich kategorii produktów
SELECT CategoryName, Description FROM Categories

-- 5. Poka¿ nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage FROM Suppliers


-- Selecty z okreœlonymi wymogami

-- 1. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby w Londynie
SELECT CompanyName, Address, City, Country FROM Customers WHERE City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klientów maj¹cych siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address, City, Country FROM Customers WHERE Country = 'France' OR Country = 'Spain'

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20 a 30SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

-- 4. Wybierz nazwy i ceny produktów z kategorii ‘meat’SELECT ProductName, UnitPrice FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories 
WHERE CategoryName LIKE '%meat%')

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmê ‘Tokyo Traders’
SELECT ProductName, UnitsInStock FROM Products WHERE SupplierID IN (SELECT SupplierID FROM Suppliers 
WHERE CompanyName LIKE 'Tokyo Traders')

-- 6. Wybierz nazwy produktów których nie ma w magazyni
SELECT ProductName FROM Products WHERE UnitsInStock = 0


-- Selecty z porównywaniem napisów

-- 1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'-- 2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê z zakresu od B do LSELECT FirstName, LastName, Title From Employees WHERE LastName LIKE '[B-L]%'-- 3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê na literê B lub LSELECT FirstName, LastName, Title FROM Employees WHERE LastName LIKE '[BL]%'-- 4. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinekSELECT CategoryName FROM Categories WHERE Description LIKE '%,%'-- 5. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store’SELECT * FROM Customers WHERE CompanyName LIKE '%Store%'-- Zakresy, zmienne logiczne-- 1. Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20-- 2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 and 30-- 3. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan) lub we W³oszech (Italy)SELECT CompanyName, Country FROM Customers WHERE Country LIKE 'Japan' OR Country LIKE 'Italy'-- Sortowanie danych-- 1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju,-- w ramach danego kraju nazwy firm posortuj alfabetycznieSELECT CompanyName, Country FROM Customers ORDER BY Country, CompanyName-- 2. Wybierz informacjê o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malej¹co wg cenySELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID, UnitPrice DESC-- 3. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Wielkiej Brytanii (UK) lub we W³oszech (Italy),-- wyniki posortuj tak jak w pkt 1SELECT CompanyName, Country FROM Customers WHERE Country LIKE 'UK' OR Country LIKE 'Italy'