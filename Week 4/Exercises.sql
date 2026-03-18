USE movies;

-- Exercise 1
SELECT me.NAME, m2.TITLE
FROM MOVIE AS m
INNER JOIN MOVIEEXEC AS me ON m.PRODUCERC# = me.CERT#
INNER JOIN MOVIE AS m2 ON m2.PRODUCERC# = me.CERT#
WHERE m.TITLE = 'Star Wars';

-- Exercise 2
SELECT DISTINCT me.NAME
FROM MOVIEEXEC AS me
INNER JOIN MOVIE AS m ON me.CERT#=m.PRODUCERC#
INNER JOIN STARSIN AS si ON m.TITLE=si.MOVIETITLE
WHERE si.STARNAME='Harrison Ford';

--Exercise 3
SELECT s.NAME, si.STARNAME
FROM STUDIO AS s
INNER JOIN MOVIE AS m ON s.NAME=m.STUDIONAME
INNER JOIN STARSIN AS si ON m.TITLE=si.MOVIETITLE 
ORDER BY s.NAME ASC;

-- Exercise 4
SELECT si.STARNAME, me.NETWORTH, m.TITLE
FROM STARSIN AS si
INNER JOIN MOVIE AS m ON si.MOVIETITLE=m.TITLE
INNER JOIN MOVIEEXEC AS me ON m.PRODUCERC#=me.CERT#
WHERE me.NETWORTH >= ALL (SELECT me1.NETWORTH FROM MOVIEEXEC AS me1);

-- Exercise 5
SELECT ms.name
FROM MovieStar AS ms
LEFT JOIN StarsIn AS si ON ms.name = si.starname
WHERE si.starname IS NULL;

USE pc;
-- Exercise 6
SELECT p.maker, p.model, p.type
FROM Product AS p
LEFT JOIN PC AS pc ON p.model = pc.model
LEFT JOIN Laptop AS l ON p.model = l.model
LEFT JOIN Printer AS pr ON p.model = pr.model
WHERE pc.model IS NULL
  AND l.model IS NULL
  AND pr.model IS NULL;

-- Exercise 7
SELECT DISTINCT p1.maker
FROM Product AS p1
INNER JOIN Laptop AS l ON p1.model = l.model
INNER JOIN Product AS p2 ON p1.maker = p2.maker
INNER JOIN Printer AS pr ON p2.model = pr.model;

-- Exercise 8
SELECT DISTINCT l1.hd
FROM Laptop AS l1
INNER JOIN Laptop AS l2
    ON l1.hd = l2.hd
   AND l1.model <> l2.model;

-- Exercise 9
SELECT pc.model
FROM PC AS pc
LEFT JOIN Product AS p ON pc.model = p.model
WHERE p.model IS NULL;

USE ships;

-- Exercise 10
SELECT sh.name,
       sh.class,
       cl.type,
       cl.country,
       cl.numGuns,
       cl.bore,
       cl.displacement
FROM Ships AS sh
INNER JOIN Classes AS cl
    ON sh.class = cl.class;

-- Exercise 11
SELECT sh.name,
       cl.class,
       cl.type,
       cl.country,
       cl.numGuns,
       cl.bore,
       cl.displacement
FROM Classes AS cl
LEFT JOIN Ships AS sh
    ON cl.class = sh.class
WHERE sh.name IS NOT NULL
   OR EXISTS (
        SELECT 1
        FROM Ships AS s
        WHERE s.name = cl.class
   );

-- Exercise 12
SELECT c.country, s.name
FROM Ships AS s
JOIN Classes AS c ON s.class = c.class
LEFT JOIN Outcomes AS o ON s.name = o.ship
WHERE o.ship IS NULL;

-- Exercise 13
SELECT s.name AS "Ship Name"
FROM Ships AS s
JOIN Classes AS c ON s.class = c.class
WHERE c.numGuns >= 7
  AND s.launched = 1916;

-- Exercise 14
SELECT o.ship AS "Ship Name",
       o.battle AS "Battle Name",
       b.date   AS "Battle Date"
FROM Outcomes AS o
INNER JOIN Battles AS b ON o.battle = b.name
WHERE o.result = 'sunk'
ORDER BY o.battle;

-- Exercise 15
SELECT s.name,
       c.displacement,
       s.launched
FROM Ships AS s
INNER JOIN Classes AS c
    ON s.class = c.class
WHERE s.name = s.class;

-- Exercise 16
SELECT c.class
FROM Classes AS c
LEFT JOIN Ships AS s
    ON c.class = s.class
WHERE s.class IS NULL;

-- Exercise 17
SELECT s.name,
       c.displacement,
       c.numGuns,
       o.result
FROM Outcomes AS o
INNER JOIN Ships AS s ON o.ship = s.name
INNER JOIN Classes AS c ON s.class = c.class
WHERE o.battle = 'North Atlantic';
