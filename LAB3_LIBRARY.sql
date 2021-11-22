
--1. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza
--library). Interesuje nas imiê, nazwisko i data urodzenia dziecka.
SELECT firstname, lastname, juvenile.birth_date FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no


--2. Napisz polecenie, które podaje tytu³y aktualnie wypo¿yczonych ksi¹¿ek
SELECT DISTINCT title FROM title
INNER JOIN loan
ON title.title_no = loan.title_no


--3. Podaj informacje o karach zap³aconych za przetrzymywanie ksi¹¿ki o tytule ‘Tao
--Teh King’. Interesuje nas data oddania ksi¹¿ki, ile dni by³a przetrzymywana i jak¹
--zap³acono karê 
SELECT in_date, DATEDIFF(Day, due_date, in_date), fine_paid FROM loanhist
INNER JOIN title
ON loanhist.title_no = title.title_no
WHERE title.title = 'Tao Teh King' 


--4. Napisz polecenie które podaje listê ksi¹¿ek (mumery ISBN) zarezerwowanych
--przez osobê o nazwisku: Stephen A. Graff
SELECT isbn FROM reservation
INNER JOIN member
ON reservation.member_no = member.member_no
WHERE firstname + ' ' + middleinitial + '. ' + lastname = 'Stephen A. Graff'


--5. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza
--library). Interesuje nas imiê, nazwisko, data urodzenia dziecka i adres
--zamieszkania dziecka.
SELECT firstname, lastname, juvenile.birth_date, adult.city + ' ' + adult.street FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no
INNER JOIN adult
ON juvenile.adult_member_no = adult.member_no


--6. Napisz polecenie, które wyœwietla listê dzieci bêd¹cych cz³onkami biblioteki (baza
--library). Interesuje nas imiê, nazwisko, data urodzenia dziecka, adres
--zamieszkania dziecka oraz imiê i nazwisko rodzica
SELECT member.firstname, member.lastname, juvenile.birth_date,
adult.city + ', ' + adult.street, member2.firstname, member2.lastname FROM member
INNER JOIN juvenile
ON member.member_no = juvenile.member_no
INNER JOIN adult
ON juvenile.adult_member_no = adult.member_no
INNER JOIN member member2
ON adult.member_no = member2.member_no


--7. Napisz polecenie, które wyœwietla adresy cz³onków biblioteki, którzy maj¹ dzieci
--urodzone przed 1 stycznia 1996. Interesuj¹ nas tylko adresy takich cz³onków
--biblioteki, którzy aktualnie nie przetrzymuj¹ ksi¹¿ek.
SELECT city + ', ' + street, loan.member_no FROM adult
INNER JOIN juvenile
ON adult.member_no = juvenile.adult_member_no
LEFT OUTER JOIN loan
ON adult.member_no = loan.member_no
WHERE juvenile.birth_date < '1996-01-01' AND loan.member_no IS NULL


--8. Napisz polecenie które zwraca imiê i nazwisko (jako pojedyncz¹ kolumnê –
--name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedyncz¹
--kolumnê – address) dla wszystkich doros³ych cz³onków biblioteki
SELECT firstname + ' ' + lastname AS 'name', street + ' ' + city + ' ' + state + ' ' + zip AS address FROM member
INNER JOIN adult
ON adult.member_no = member.member_no


--9. Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover,
--dla ksi¹¿ek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN
SELECT copy.isbn, copy_no, on_loan, title, translation, cover FROM copy
INNER JOIN title
ON title.title_no = copy.title_no
INNER JOIN item
ON copy.isbn = item.isbn
WHERE copy.isbn = 1 OR copy.isbn=500 OR copy.isbn=1000 


--10. Napisz polecenie które zwraca o u¿ytkownikach biblioteki o nr 250, 342, i 1675
--(dla ka¿dego u¿ytkownika: nr, imiê i nazwisko cz³onka biblioteki), oraz informacjê
--o zarezerwowanych ksi¹¿kach (isbn, data) 
SELECT member.member_no, firstname, lastname, isbn, log_date FROM member
LEFT OUTER JOIN reservation
ON reservation.member_no = member.member_no
WHERE member.member_no = 250 OR member.member_no = 342 OR member.member_no = 1675


--11. Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie (AZ) maj¹ wiêcej ni¿
--dwoje dzieci zapisanych do biblioteki 
SELECT member.member_no FROM member
INNER JOIN adult
ON member.member_no = adult.member_no
INNER JOIN juvenile
ON juvenile.adult_member_no = adult.member_no
WHERE state = 'AZ'
GROUP BY member.member_no HAVING COUNT(*) > 2


--12. Podaj listê cz³onków biblioteki mieszkaj¹cych w Arizonie (AZ) którzy maj¹ wiêcej
--ni¿ dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkaj¹ w Kaliforni
--(CA) i maj¹ wiêcej ni¿ troje dzieci zapisanych do biblioteki
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

