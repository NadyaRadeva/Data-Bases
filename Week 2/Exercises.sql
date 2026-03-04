use movies;

-- Exercise 1
SELECT ms.NAME
FROM STARSIN AS si
JOIN MOVIESTAR AS ms ON si.STARNAME=ms.NAME
WHERE si.MOVIETITLE='The Usual Suspects' AND ms.GENDER='M';

-- Exercise 2
SELECT si.STARNAME
FROM MOVIE as m
JOIN STARSIN as si ON m.TITLE=si.MOVIETITLE
WHERE m.YEAR=1995 AND m.STUDIONAME='MGM';

-- Exercise 3
SELECT DISTINCT me.NAME
FROM MOVIEEXEC as me
JOIN MOVIE as m ON me.CERT#=m.PRODUCERC#
WHERE m.STUDIONAME='MGM';

-- Exercise 4
SELECT m.TITLE
FROM MOVIE AS m
WHERE m.LENGTH > (SELECT LENGTH 
				  FROM MOVIE 
				  WHERE TITLE='Star Wars');

-- Exercise 5
SELECT me.NAME
FROM MOVIEEXEC AS me
WHERE me.NETWORTH > (SELECT NETWORTH
					 FROM MOVIEEXEC AS x
					 WHERE x.NAME = 'Stephen Spielberg');   
			
use pc;

-- Exercise 6
SELECT p.maker, l.speed
FROM product AS p
JOIN laptop AS l ON p.model = l.model
WHERE l.hd >= 9;

-- Exercise 7
(SELECT pr.model, pc.price
FROM product AS pr
JOIN pc ON pr.model = pc.model
WHERE pr.maker = 'B')
UNION
(SELECT pr.model, l.price
FROM product AS pr
JOIN laptop AS l ON pr.model = l.model
WHERE pr.maker = 'B')
UNION
(SELECT pr.model, prt.price
FROM product AS pr
JOIN printer AS prt ON pr.model = prt.model
WHERE pr.maker = 'B');

-- Exercise 8
SELECT pr.maker
FROM product AS pr
JOIN laptop AS l ON pr.model=l.model
EXCEPT
SELECT pr.maker
FROM product AS pr
JOIN pc AS pc ON pr.model=pc.model;

-- Exercise 9
SELECT DISTINCT p1.hd
FROM pc AS p1
JOIN pc AS p2 ON p1.hd = p2.hd 
AND p1.code <> p2.code;

-- Exercise 10
SELECT p1.model AS model1, p2.model AS model2
FROM pc AS p1
JOIN pc AS p2 ON p1.speed = p2.speed
   AND p1.ram = p2.ram
   AND p1.code < p2.code;

-- Exercise 11
SELECT DISTINCT pr.maker
FROM pc AS pc
JOIN product AS pr ON pc.model=pr.model
AND pc.speed>=400;

USE ships;
-- Exercise 12
SELECT s.NAME
FROM SHIPS AS s
JOIN CLASSES AS c ON s.CLASS=c.CLASS
WHERE c.DISPLACEMENT>50000;

-- Exercise 13
SELECT sh.NAME, cl.NUMGUNS, cl.DISPLACEMENT
FROM CLASSES AS cl
JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
JOIN OUTCOMES AS ou ON sh.NAME=ou.SHIP
WHERE ou.BATTLE='Guadalcanal';

-- Exercise 14
(SELECT cl1.COUNTRY
FROM CLASSES AS cl1
WHERE cl1.TYPE='bb')
INTERSECT
(SELECT cl2.COUNTRY
FROM CLASSES AS cl2
WHERE cl2.TYPE='bc');


-- Exercise 15
SELECT DISTINCT o1.ship
FROM outcomes AS o1
JOIN outcomes AS o2
    ON o1.ship = o2.ship
   AND o1.battle <> o2.battle
WHERE o1.result = 'damaged';
