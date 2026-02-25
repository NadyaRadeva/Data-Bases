/*use movies;

-- Exercise 1
SELECT address
FROM STUDIO
WHERE name='Disney';

-- Exercise 2
SELECT birthdate
FROM MOVIESTAR
WHERE name='Jack Nicholson';

-- Exercise 3
SELECT starname
FROM STARSIN
WHERE MOVIEYEAR=1980 OR MOVIETITLE LIKE 'Knight%';

-- Exercise 4
SELECT name
FROM MOVIEEXEC
WHERE NETWORTH>10000000;

-- Exercise 5
SELECT name
FROM MOVIESTAR
WHERE GENDER='M' OR ADDRESS='Prefect Rd.';*/

/*use pc;

-- Exercise 6
SELECT model, speed AS MHz, hd AS GB
FROM pc
WHERE price < 1200;

-- Exdercise 7
SELECT DISTINCT maker
FROM product
WHERE type='Printer';

-- Exercise 8
SELECT model, ram, screen
FROM laptop
WHERE price>1000;

-- Exercise 9
SELECT *
FROM printer
WHERE color='y';

-- Exercise 10
SELECT model, speed AS MHz, hd AS GB
FROM pc
WHERE (cd = '12x' OR cd = '16x') AND price < 2000;*/

use ships;

-- Exercise 11
SELECT class, country
FROM CLASSES
WHERE NUMGUNS<10;

-- Exercise 12
SELECT name AS shipName
FROM SHIPS
WHERE LAUNCHED<1918;

-- Exercise 13
SELECT ship, battle
FROM OUTCOMES
WHERE result='sunk';

-- Exercise 14
SELECT name
FROM SHIPS
WHERE name=CLASS;

-- Exercise 15
SELECT name
FROM SHIPS
WHERE name LIKE 'R%';

-- Exercise 16
SELECT name
FROM SHIPS
WHERE name LIKE '% %';

SELECT name
FROM SHIPS
WHERE name LIKE '% %' AND name NOT LIKE '% % %';
