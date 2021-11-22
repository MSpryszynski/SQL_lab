
--1. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza
--library). Interesuje nas imi�, nazwisko i data urodzenia dziecka.
SELECT firstname, lastname, juvenile.birth_date FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no


--2. Napisz polecenie, kt�re podaje tytu�y aktualnie wypo�yczonych ksi��ek
SELECT DISTINCT title FROM title
INNER JOIN loan
ON title.title_no = loan.title_no


--3. Podaj informacje o karach zap�aconych za przetrzymywanie ksi��ki o tytule �Tao
--Teh King�. Interesuje nas data oddania ksi��ki, ile dni by�a przetrzymywana i jak�
--zap�acono kar� 
SELECT in_date, DATEDIFF(Day, due_date, in_date), fine_paid FROM loanhist
INNER JOIN title
ON loanhist.title_no = title.title_no
WHERE title.title = 'Tao Teh King' 


--4. Napisz polecenie kt�re podaje list� ksi��ek (mumery ISBN) zarezerwowanych
--przez osob� o nazwisku: Stephen A. Graff
SELECT isbn FROM reservation
INNER JOIN member
ON reservation.member_no = member.member_no
WHERE firstname + ' ' + middleinitial + '. ' + lastname = 'Stephen A. Graff'


--5. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza
--library). Interesuje nas imi�, nazwisko, data urodzenia dziecka i adres
--zamieszkania dziecka.
SELECT firstname, lastname, juvenile.birth_date, adult.city + ' ' + adult.street FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no
INNER JOIN adult
ON juvenile.adult_member_no = adult.member_no


--6. Napisz polecenie, kt�re wy�wietla list� dzieci b�d�cych cz�onkami biblioteki (baza
--library). Interesuje nas imi�, nazwisko, data urodzenia dziecka, adres
--zamieszkania dziecka oraz imi� i nazwisko rodzica
SELECT member.firstname, member.lastname, juvenile.birth_date,
adult.city + ', ' + adult.street, member2.firstname, member2.lastname FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no
INNER JOIN adult
ON juvenile.adult_member_no = adult.member_no
INNER JOIN member member2
ON adult.member_no = member2.member_no


--7. Napisz polecenie, kt�re wy�wietla adresy cz�onk�w biblioteki, kt�rzy maj� dzieci
--urodzone przed 1 stycznia 1996. Interesuj� nas tylko adresy takich cz�onk�w
--biblioteki, kt�rzy aktualnie nie przetrzymuj� ksi��ek.
SELECT city + ', ' + street, loan.member_no FROM adult
INNER JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
LEFT OUTER JOIN loan
ON adult.member_no = loan.member_no
WHERE juvenile.birth_date < '1996-01-01' AND loan.member_no IS NULL


--8. Napisz polecenie kt�re zwraca imi� i nazwisko (jako pojedyncz� kolumn� �
--name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedyncz�
--kolumn� � address) dla wszystkich doros�ych cz�onk�w biblioteki
SELECT firstname + ' ' + lastname AS 'name', street + ' ' + city + ' ' + state + ' ' + zip AS address FROM member
INNER JOIN adult
ON adult.member_no = member.member_no


--9. Napisz polecenie, kt�re zwraca: isbn, copy_no, on_loan, title, translation, cover,
--dla ksi��ek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
SELECT copy.isbn, copy_no, on_loan, title, translation, cover FROM copy
INNER JOIN title
ON title.title_no = copy.title_no
INNER JOIN item
ON copy.isbn = item.isbn
WHERE copy.isbn = 1 OR copy.isbn=500 OR copy.isbn=1000 


--10. Napisz polecenie kt�re zwraca o u�ytkownikach biblioteki o nr 250, 342, i 1675
--(dla ka�dego u�ytkownika: nr, imi� i nazwisko cz�onka biblioteki), oraz informacj�
--o zarezerwowanych ksi��kach (isbn, data) 
SELECT member.member_no, firstname, lastname, isbn, log_date FROM member
LEFT OUTER JOIN reservation
ON reservation.member_no = member.member_no
WHERE member.member_no = 250 OR member.member_no = 342 OR member.member_no = 1675


--11. Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) maj� wi�cej ni�
--dwoje dzieci zapisanych do biblioteki 
SELECT member.member_no FROM member
INNER JOIN adult
ON member.member_no = adult.member_no
INNER JOIN juvenile
ON juvenile.adult_member_no = adult.member_no
WHERE state = 'AZ'
GROUP BY member.member_no HAVING COUNT(*) > 2


--12. Podaj list� cz�onk�w biblioteki mieszkaj�cych w Arizonie (AZ) kt�rzy maj� wi�cej
--ni� dwoje dzieci zapisanych do biblioteki oraz takich kt�rzy mieszkaj� w Kaliforni
--(CA) i maj� wi�cej ni� troje dzieci zapisanych do biblioteki
SELECT member.member_no FROM member
INNER JOIN adult
ON member.member_no = adult.member_no
INNER JOIN juvenile
ON juvenile.adult_member_no = adult.member_no
WHERE state = 'AZ' 
GROUP BY member.member_no HAVING COUNT(*) > 1
UNION
SELECT member.member_no FROM member
INNER JOIN adult
ON member.member_no = adult.member_no
INNER JOIN juvenile
ON juvenile.adult_member_no = adult.member_no
WHERE state = 'CA' 
GROUP BY member.member_no HAVING COUNT(*) > 2

