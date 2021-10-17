-- Zadanie opartê o bibliotekê library

--1. Napisz polecenie select, za pomoc¹ którego uzyskasz tytu³ i numer ksi¹¿ki
SELECT title_no, title FROM title

-- 2. Napisz polecenie, które wybiera tytu³ o numerze 10
SELECT title From title WHERE title_no = 10

-- 3. Napisz polecenie, które wybiera numer czytelnika i karê
-- dla tych czytelników, którzy maj¹ kary miêdzy $8 a $9 
SELECT member_no,fine_assessed FROM loanhist WHERE fine_assessed BETWEEN 8 AND 9

-- 4. Napisz polecenie select, za pomoc¹ którego uzyskasz
-- numer ksi¹¿ki i autora dla wszystkich ksi¹¿ek, których
-- autorem jest Charles Dickens lub Jane Austen
SELECT title_no FROM title WHERE ( author = 'Charles Dickens' OR  author = 'Jane Austen')

-- 5. Napisz polecenie, które wybiera numer tytu³u i tytu³ dla
-- wszystkich rekordów zawieraj¹cych string „adventures” gdzieœ w tytule
SELECT title_no, title FROM title WHERE title LIKE '%adventures%'

-- 6. Napisz polecenie, które wybiera numer czytelnika, karê
-- oraz zap³acon¹ karê dla wszystkich, którzy jeszcze nie zap³acili.
SELECT member_no, fine_assessed, fine_paid FROM loanhist 
WHERE (fine_assessed > fine_paid AND fine_waived IS NULL) 
OR (fine_waived IS NOT NULL AND fine_assessed > fine_paid+fine_waived)

-- 7. Napisz polecenie, które wybiera wszystkie unikalne pary
-- miast i stanów z tablicy adult
SELECT DISTINCT city, state FROM adult

-- 8. Napisz polecenie, które wybiera wszystkie tytu³y z tablicy
-- title i wyœwietla je w porz¹dku alfabetycznym.
SELECT title FROM title ORDER BY title

-- 9. Napisz polecenie, które:
-- - wybiera numer cz³onka biblioteki, isbn ksi¹¿ki i wartoœæ
-- naliczonej kary dla wszystkich wypo¿yczeñ, dla których naliczono karê
-- - stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹ wartoœæ kolumny fine_assessed
-- - stwórz alias ‘double fine’ dla tej kolumny
SELECT member_no, isbn, fine_assessed, fine_assessed*2 as 'double fine' FROM loanhist WHERE fine_assessed IS NOT NULL AND fine_assessed > 0


-- 10. Napisz polecenie, które:
-- a)
-- - generuje pojedyncz¹ kolumnê, która zawiera kolumny:
-- imiê cz³onka biblioteki, inicja³ drugiego imienia i nazwisko dla wszystkich cz³onków biblioteki,
-- którzy nazywaj¹ siê Anderson
-- - nazwij tak powsta³¹ kolumnê „email_name”
-- - zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych loginów e -mail” utworzonych przez po³¹czenie imienia cz³onka
-- biblioteki, z inicja³em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi literami).
SELECT firstname + '.' + middleinitial + '.' + lastname as 'email_name' FROM MEMBER WHERE lastname LIKE 'Anderson'
-- b)
-- - zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych loginów e -mail” utworzonych przez po³¹czenie imienia cz³onka
-- biblioteki, z inicja³em drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi literami).
SELECT LOWER(firstname + middleinitial + SUBSTRING(lastname, 1, 2)) as 'demo_e-mail' FROM member WHERE lastname like 'Anderson'

-- 11. Napisz polecenie, które wybiera title i title_no z tablicy title.
-- Wynikiem powinna byæ pojedyncza kolumna o formacie jak w przyk³adzie poni¿ej:
-- The title is: Poems, title number 7
-- Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w oparciu o wyra¿enie, które ³¹czy 4 elementy:
-- sta³a znakowa ‘The title is:’
-- wartoœæ kolumny title
-- sta³a znakowa ‘title number’
-- wartoœæ kolumny title_no
SELECT 'The title is : ' + title + ', title number ' + CAST(title_no as varchar) as 'titleinfo' FROM title