USE movies;

-- Exercise 1
SELECT TITLE, YEAR
FROM MOVIE
WHERE INCOLOR='Y' AND (LENGTH<130 OR LENGTH IS NULL);

-- Exercise 2
-- Напишете заявка, която извежда имената на всички актьори, които са участвали във филм след 1990 година.

SELECT DISTINCT si.STARNAME
FROM STARSIN AS si
INNER JOIN MOVIE AS m ON m.TITLE=si.MOVIETITLE
WHERE m.YEAR > 1990

-- Exercise 3
--Напишете заявка, която извежда име на студио и брой филми, произведени от това студио.
SELECT s.NAME AS StudioName, COUNT(DISTINCT m.TITLE) AS Movies
FROM STUDIO AS s
INNER JOIN MOVIE AS m ON s.NAME=m.STUDIONAME
GROUP BY s.NAME;

-- Exercise 4
--Напишете заявка, която извежда име на актьор и най-ранната година на филм, в който той е участвал.
SELECT si.STARNAME AS StarName, MIN(m.YEAR) AS EarliestMovie
FROM STARSIN AS si
INNER JOIN MOVIE AS m ON si.MOVIETITLE=m.TITLE
GROUP BY si.STARNAME;

-- Exercise 5
-- Напишете заявка, която извежда студиата, които са произвели повече от два филма.
SELECT s.NAME, COUNT(m.TITLE) AS MovieCounter
FROM STUDIO AS s
INNER JOIN MOVIE AS m ON s.NAME=m.STUDIONAME
GROUP BY s.NAME 
HAVING COUNT(m.TITLE) > 2;

-- Exercise 6
-- Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм.
SELECT ms.NAME
FROM MOVIESTAR ms
LEFT JOIN STARSIN si ON si.STARNAME = ms.NAME
GROUP BY ms.NAME
HAVING COUNT(si.MOVIETITLE) = 0;

-- Exercise 7
-- Напишете заявка, която извежда заглавие на филм и броя актьори в него, подредени по броя актьори в намаляващ ред.
SELECT m.TITLE, COUNT(si.STARNAME) AS ActorCount
FROM MOVIE AS m
INNER JOIN STARSIN AS si ON m.TITLE=si.MOVIETITLE
GROUP BY m.TITLE
ORDER BY COUNT(si.STARNAME) DESC;

-- Exercise 8
-- Напишете заявка, която извежда актьорите, участвали в най-стария филм.
SELECT DISTINCT si.STARNAME
FROM STARSIN si
WHERE si.MOVIEYEAR = (
    SELECT MIN(MOVIEYEAR)
    FROM STARSIN
);

USE ships;

-- Exercise 9
-- Напишете заявка, която извежда имената на всички кораби, пуснати на вода след 1920 година.
SELECT DISTINCT sh.NAME
FROM SHIPS AS sh
WHERE sh.LAUNCHED > 1920;

-- Exercise 10
-- Напишете заявка, която извежда име на кораб и резултат от битката за всички кораби, участвали в битката "North Atlantic".
SELECT sh.NAME, o.RESULT
FROM SHIPS AS sh
INNER JOIN OUTCOMES AS o ON sh.NAME=o.SHIP
INNER JOIN BATTLES AS b ON b.NAME=o.BATTLE
WHERE b.NAME='North Atlantic';

-- Exercise 11
-- Напишете заявка, която извежда държавите и броя кораби за всяка държава.
SELECT cl.COUNTRY AS Country, COUNT(DISTINCT sh.NAME) AS Ship
FROM CLASSES AS cl
LEFT JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
GROUP BY cl.COUNTRY;

-- Exercise 12
-- Напишете заявка, която извежда името на най-тежкия клас кораби (по DISPLACEMENT).
SELECT cl.CLASS
FROM CLASSES cl
WHERE cl.DISPLACEMENT = (SELECT MAX(DISPLACEMENT) FROM CLASSES);

-- Exercise 13
-- Напишете заявка, която извежда имената на корабите, които никога не са участвали в битка.
SELECT DISTINCT sh.NAME
FROM SHIPS AS sh
LEFT JOIN OUTCOMES AS o ON sh.NAME=o.SHIP
WHERE o.BATTLE IS NULL;

-- Exercise 14
-- Напишете заявка, която извежда името на битката и броя кораби, участвали в нея.
SELECT o.BATTLE, COUNT(DISTINCT sh.NAME) NumberOfShips
FROM OUTCOMES o
LEFT JOIN SHIPS sh ON sh.NAME = o.SHIP
GROUP BY o.BATTLE;

-- Exercise 15
-- Напишете заявка, която извежда държавите, чиито кораби са участвали в повече от една битка.
SELECT DISTINCT cl.COUNTRY
FROM CLASSES AS cl
LEFT JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
LEFT JOIN OUTCOMES AS o ON o.SHIP=sh.NAME
GROUP BY cl.COUNTRY
HAVING COUNT(o.BATTLE) > 1;

-- Exercise 16
-- Напишете заявка, която извежда имената на корабите с най-голям брой оръдия.
SELECT sh.NAME
FROM SHIPS sh
JOIN CLASSES cl ON sh.CLASS = cl.CLASS
WHERE cl.NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES);

USE pc;

-- Exercise 17
-- Напишете заявка, която извежда всички модели компютри с RAM ≥ 64.
SELECT pr.model, pc.ram
FROM pc AS pc
INNER JOIN product AS pr ON pc.model=pr.model
WHERE pc.ram>=64;

-- Exercise 18
-- Напишете заявка, която извежда производителите, които произвеждат както лаптопи, така и принтери.
SELECT p.maker
FROM product p
LEFT JOIN laptop l ON p.model = l.model
LEFT JOIN printer r ON p.model = r.model
GROUP BY p.maker
HAVING COUNT(DISTINCT l.model) > 0
   AND COUNT(DISTINCT r.model) > 0;

-- Exercise 19
-- Напишете заявка, която извежда най-скъпия лаптоп.
SELECT code, price
FROM laptop
WHERE price = (SELECT MAX(price) FROM laptop);

-- Exercise 20
-- Напишете заявка, която извежда средната цена на компютрите за всеки производител.
SELECT pr.maker, AVG(pc.price)
FROM product AS pr
LEFT JOIN pc AS pc ON pr.model=pc.model
GROUP BY pr.maker;

-- Exercise 21
-- Напишете заявка, която извежда моделите компютри с най-голям твърд диск.
SELECT pr.model, pc.hd
FROM product pr
JOIN pc ON pr.model = pc.model
WHERE pc.hd = (SELECT MAX(hd) FROM pc);

-- Exercise 22
-- Напишете заявка, която извежда производителите, които имат повече от един модел лаптоп.
SELECT pr.maker
FROM product pr
INNER JOIN laptop l ON pr.model = l.model
GROUP BY pr.maker
HAVING COUNT(DISTINCT pr.model) > 1;

-- Exercise 23
-- Напишете заявка, която извежда всички принтери, по-евтини от средната цена на принтерите.
SELECT pr.model
FROM printer AS p
INNER JOIN product AS pr ON p.model=pr.model
WHERE p.price < (SELECT AVG(price) FROM printer);

-- Exercise 24
-- Напишете заявка, която извежда производител и брой продукти, които произвежда.
SELECT pr.maker, COUNT(DISTINCT pr.model) AS NumberOfProducts
FROM product AS pr
LEFT JOIN laptop  AS l   ON pr.model = l.model
LEFT JOIN printer AS pri ON pr.model = pri.model
LEFT JOIN pc AS pc  ON pr.model = pc.model
GROUP BY pr.maker;
