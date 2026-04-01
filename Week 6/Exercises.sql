USE movies;

-- Exercise 1
SELECT TITLE, YEAR
FROM MOVIE
WHERE 
    CASE 
        WHEN LENGTH IS NULL THEN 1
        WHEN LENGTH > 120 AND YEAR < 2000 THEN 1
        ELSE 0
    END = 1;

-- Exercise 2
SELECT NAME, GENDER
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE>1948
ORDER BY NAME DESC;

-- Exercise 3
SELECT s.NAME AS StudioName, COUNT(DISTINCT si.STARNAME) AS ActorCount
FROM STUDIO s
LEFT JOIN MOVIE m ON m.STUDIONAME = s.NAME
LEFT JOIN STARSIN si ON si.MOVIETITLE = m.TITLE
GROUP BY s.NAME
ORDER BY s.NAME;

-- Exercise 4
SELECT si.STARNAME AS 'Actor Name', COUNT(m.TITLE) AS 'No. movies'
FROM STARSIN AS si
LEFT JOIN MOVIE AS m ON si.MOVIETITLE=m.TITLE
GROUP BY si.STARNAME
ORDER BY si.STARNAME ASC;

-- Exercise 5
SELECT s.NAME AS StudioName, m.TITLE AS MovieTitle
FROM STUDIO s
LEFT JOIN MOVIE m ON s.NAME = m.STUDIONAME
WHERE m.YEAR = (SELECT MAX(m1.YEAR) FROM MOVIE m1 WHERE m1.STUDIONAME = s.NAME)
ORDER BY s.NAME ASC;

-- Exercise 6
SELECT NAME, BIRTHDATE
FROM MOVIESTAR
WHERE BIRTHDATE >= ALL (SELECT BIRTHDATE FROM MOVIESTAR) AND GENDER='M';

-- Exercise 7
SELECT si.STARNAME, m.STUDIONAME
FROM STARSIN si
LEFT JOIN MOVIE m ON si.MOVIETITLE = m.TITLE
GROUP BY si.STARNAME, m.STUDIONAME
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM STARSIN si2
    JOIN MOVIE m2 ON si2.MOVIETITLE = m2.TITLE
    WHERE si2.STARNAME = si.STARNAME
    GROUP BY m2.STUDIONAME
);

-- Exercise 8
SELECT m.TITLE, m.YEAR, COUNT(si.STARNAME) AS STARNAME
FROM MOVIE AS m
LEFT JOIN STARSIN AS si ON m.TITLE=si.MOVIETITLE
GROUP BY m.TITLE, m.YEAR
HAVING COUNT(si.STARNAME) > 2;


USE ships;

-- Exercise 1
SELECT DISTINCT sh.NAME AS ShipNames
FROM SHIPS AS sh
LEFT JOIN OUTCOMES AS o ON sh.NAME=o.SHIP
WHERE sh.NAME LIKE 'C%' OR sh.NAME LIKE 'K%'
GROUP BY sh.NAME
HAVING COUNT(o.BATTLE) >= 1;

-- Exercise 2
SELECT sh.NAME, cl.COUNTRY
FROM SHIPS sh
LEFT JOIN CLASSES cl ON sh.CLASS = cl.CLASS
LEFT JOIN OUTCOMES o ON sh.NAME = o.SHIP
GROUP BY sh.NAME, cl.COUNTRY
HAVING COUNT(CASE 
             WHEN o.RESULT = 'sunk' 
             THEN 1 END) = 0;

-- Exercise 3
SELECT cl.COUNTRY, COUNT(CASE 
                         WHEN o.RESULT = 'sunk' THEN 1 
                         END) AS NumSunkShips
FROM CLASSES cl
LEFT JOIN SHIPS sh ON cl.CLASS = sh.CLASS
LEFT JOIN OUTCOMES o ON sh.NAME = o.SHIP
GROUP BY cl.COUNTRY;

-- Exercise 4
SELECT b.NAME, COUNT(o.SHIP) AS NumShips
FROM BATTLES b
LEFT JOIN OUTCOMES o ON b.NAME = o.BATTLE
GROUP BY b.NAME
HAVING COUNT(o.SHIP) >
       (
           SELECT COUNT(o1.SHIP)
           FROM BATTLES b1
           LEFT JOIN OUTCOMES o1 ON b1.NAME = o1.BATTLE
           WHERE b1.NAME = 'Guadalcanal'
       );

-- Exercise 5
SELECT b.NAME
FROM BATTLES AS b
LEFT JOIN OUTCOMES AS o ON b.NAME=o.BATTLE
LEFT JOIN SHIPS AS sh ON sh.NAME=o.SHIP
LEFT JOIN CLASSES AS cl ON cl.CLASS=sh.CLASS
GROUP BY b.NAME
HAVING COUNT(DISTINCT cl.COUNTRY) > (SELECT COUNT(DISTINCT cl1.COUNTRY)
                            FROM BATTLES AS b1
                            LEFT JOIN OUTCOMES AS o1 ON b1.NAME=o1.BATTLE
                            LEFT JOIN SHIPS AS sh1 ON sh1.NAME=o1.SHIP
                            LEFT JOIN CLASSES AS cl1 ON cl1.CLASS=sh1.CLASS
                            WHERE b1.NAME='Surigao Strait');

-- Exercise 6
SELECT sh.NAME
FROM SHIPS sh
LEFT JOIN CLASSES cl ON sh.CLASS = cl.CLASS
WHERE cl.DISPLACEMENT = (
        SELECT MIN(DISPLACEMENT)
        FROM CLASSES
      )
  AND cl.BORE = (
        SELECT MAX(BORE)
        FROM CLASSES
      );

-- Exercise 7
SELECT COUNT(DISTINCT sh.NAME)
FROM SHIPS AS sh
WHERE EXISTS (
    SELECT 1
    FROM OUTCOMES AS o1
    JOIN BATTLES AS b1 ON b1.NAME = o1.BATTLE
    WHERE o1.SHIP = sh.NAME AND o1.RESULT = 'damaged'
)
AND EXISTS (
    SELECT 1
    FROM OUTCOMES AS o2
    LEFT JOIN BATTLES AS b2 ON b2.NAME = o2.BATTLE
    WHERE o2.SHIP = sh.NAME
      AND b2.DATE > (
          SELECT MAX(b1.DATE)
          FROM OUTCOMES o1
          LEFT JOIN BATTLES b1 ON b1.NAME = o1.BATTLE
          WHERE o1.SHIP = sh.NAME AND o1.RESULT = 'damaged'
      )
);


USE pc;

-- Exercise 1
SELECT l.model AS Model
FROM laptop AS l
LEFT JOIN product AS pr  ON l.model=pr.model
LEFT JOIN laptop AS l1 ON l.model=l1.model
WHERE l.screen=11 AND l1.screen=15
GROUP BY l.model;

-- Exercise 2
SELECT DISTINCT pc.model
FROM pc AS pc
LEFT JOIN product AS pr ON pc.model=pr.model
LEFT JOIN laptop AS l ON l.model=pr.model
WHERE pc.price < (SELECT MIN(l1.price) 
				  FROM laptop AS l1 
				  LEFT JOIN product AS pr1 ON l1.model=pr1.model
				  LEFT JOIN pc AS pc1 ON pr1.model=pc1.model
				  WHERE pr.maker=pr1.maker);

-- Exercise 3
SELECT pc.model AS Model, AVG(pc.price) AS AveragePrice
FROM pc
LEFT JOIN product pr ON pc.model = pr.model
GROUP BY pc.model, pr.maker
HAVING AVG(pc.price) < (
    SELECT MIN(l.price)
    FROM laptop l
    LEFT JOIN product pr1 ON l.model = pr1.model
    WHERE pr1.maker = pr.maker
);

-- Exercise 4
SELECT pc.code,
       pr.maker,
       (SELECT COUNT(DISTINCT pc1.price)
        FROM pc pc1
        WHERE pc1.price <= pc.price) AS price_rank
FROM pc pc
JOIN product pr ON pc.model = pr.model;
