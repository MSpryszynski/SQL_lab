-- Zadanie opart� o bibliotek� library

--1. Napisz polecenie select, za pomoc� kt�rego uzyskasz tytu� i numer ksi��ki
SELECT title_no, title FROM title

-- 2. Napisz polecenie, kt�re wybiera tytu� o numerze 10
SELECT title From title WHERE title_no = 10

-- 3. Napisz polecenie, kt�re wybiera numer czytelnika i kar�
-- dla tych czytelnik�w, kt�rzy maj� kary mi�dzy $8 a $9 
SELECT member_no,fine_assessed FROM loanhist WHERE fine_assessed BETWEEN 8 AND 9

-- 4. Napisz polecenie select, za pomoc� kt�rego uzyskasz
-- numer ksi��ki i autora dla wszystkich ksi��ek, kt�rych
-- autorem jest Charles Dickens lub Jane Austen
SELECT title_no FROM title WHERE ( author = 'Charles Dickens' OR  author = 'Jane Austen')

-- 5. Napisz polecenie, kt�re wybiera numer tytu�u i tytu� dla
-- wszystkich rekord�w zawieraj�cych string �adventures� gdzie� w tytule
SELECT title_no, title FROM title WHERE title LIKE '%adventures%'

-- 6. Napisz polecenie, kt�re wybiera numer czytelnika, kar�
-- oraz zap�acon� kar� dla wszystkich, kt�rzy jeszcze nie zap�acili.
SELECT member_no, fine_assessed, fine_paid FROM loanhist 
WHERE (fine_assessed > fine_paid AND fine_waived IS NULL) 
OR (fine_waived IS NOT NULL AND fine_assessed > fine_paid+fine_waived)

-- 7. Napisz polecenie, kt�re wybiera wszystkie unikalne pary
-- miast i stan�w z tablicy adult
SELECT DISTINCT city, state FROM adult

-- 8. Napisz polecenie, kt�re wybiera wszystkie tytu�y z tablicy
-- title i wy�wietla je w porz�dku alfabetycznym.
SELECT title FROM title ORDER BY title

-- 9. Napisz polecenie, kt�re:
-- - wybiera numer cz�onka biblioteki, isbn ksi��ki i warto��
-- naliczonej kary dla wszystkich wypo�ycze�, dla kt�rych naliczono kar�
-- - stw�rz kolumn� wyliczeniow� zawieraj�c� podwojon� warto�� kolumny fine_assessed
-- - stw�rz alias �double fine� dla tej kolumny
SELECT member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine' FROM loanhist WHERE fine_assessed IS NOT NULL AND fine_assessed > 0


-- 10. Napisz polecenie, kt�re:
-- a)
-- - generuje pojedyncz� kolumn�, kt�ra zawiera kolumny:
-- imi� cz�onka biblioteki, inicja� drugiego imienia i nazwisko dla wszystkich cz�onk�w biblioteki,
-- kt�rzy nazywaj� si� Anderson
-- - nazwij tak powsta�� kolumn� �email_name�
-- - zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych login�w e -mail� utworzonych przez po��czenie imienia cz�onka
-- biblioteki, z inicja�em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma�ymi literami).
SELECT firstname + '.' + middleinitial + '.' + lastname as 'email_name' FROM MEMBER WHERE lastname LIKE 'Anderson'
-- b)
-- - zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych login�w e -mail� utworzonych przez po��czenie imienia cz�onka
-- biblioteki, z inicja�em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma�ymi literami).
SELECT LOWER(firstname + middleinitial + SUBSTRING(lastname, 1, 2)) as 'demo_e-mail' FROM member WHERE lastname like 'Anderson'

-- 11. Napisz polecenie, kt�re wybiera title i title_no z tablicy title.
-- Wynikiem powinna by� pojedyncza kolumna o formacie jak w przyk�adzie poni�ej:
-- The title is: Poems, title number 7
-- Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w oparciu o wyra�enie, kt�re ��czy 4 elementy:
-- sta�a znakowa �The title is:�
-- warto�� kolumny title
-- sta�a znakowa �title number�
-- warto�� kolumny title_no
SELECT 'The title is : ' + title + ', title number ' + CAST(title_no as varchar) as 'titleinfo' FROM title