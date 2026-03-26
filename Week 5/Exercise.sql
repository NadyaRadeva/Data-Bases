USE pc;

-- Exercise 1
SELECT AVG(speed) AS 'Average speed'
FROM pc;

-- Exercise 2
SELECT pr.maker AS 'maker', AVG(l.screen) AS 'average screen'
FROM laptop AS l
INNER JOIN product AS pr ON l.model=pr.model
GROUP BY pr.maker;

-- Exercise 3
SELECT AVG(speed) AS 'average speed'
FROM laptop
WHERE price > 1000;

-- Exercise 4
SELECT pr.maker AS 'maker', AVG(pc.price) AS 'average price'
FROM pc AS pc
INNER JOIN product AS pr ON pc.model=pr.model
WHERE pr.maker='A'
GROUP BY pr.maker;

-- Exercise 5
SELECT maker, AVG(price) AS 'average price'
FROM (
    SELECT p.maker, pc.price
    FROM Product p
    JOIN PC pc ON p.model = pc.model
    WHERE p.maker = 'B'

    UNION ALL

    SELECT p.maker, l.price
    FROM Product p
    JOIN Laptop l ON p.model = l.model
    WHERE p.maker = 'B'
) AS all_prices
GROUP BY maker;

-- Exercise 6
SELECT speed, AVG(price) AS 'average price'
FROM pc
GROUP BY speed;

-- Exercise 7
SELECT pr.maker, COUNT(pc.code) AS 'number_of_pc'
FROM product AS pr
INNER JOIN pc AS pc ON pr.model=pc.model
GROUP BY pr.maker
HAVING COUNT(DISTINCT pc.code) >= 3;

-- Exercise 8
SELECT pr.maker AS 'maker', MAX(pc.price) AS 'price'
FROM PC AS pc
INNER JOIN Product AS pr ON pc.model = pr.model
GROUP BY pr.maker
HAVING MAX(pc.price) = (
    SELECT MAX(price)
    FROM PC
);

-- Exercise 9
SELECT speed, AVG(price) AS 'price'
FROM pc
GROUP BY speed
HAVING speed > 800;

-- Exercise 10
SELECT pr.maker, AVG(pc.hd)
FROM Product pr
LEFT JOIN PC AS pc ON pr.model = pc.model
LEFT JOIN Printer AS prn ON pr.model = prn.model
GROUP BY pr.maker
HAVING COUNT(pc.model) > 0 AND COUNT(prn.model) > 0;



USE ships;

-- Exercise 1
SELECT COUNT(CLASS) AS 'No_classes'
FROM CLASSES
WHERE TYPE='bb';

-- Exercise 2
SELECT CLASS, AVG(NUMGUNS) AS 'average guns'
FROM CLASSES
WHERE TYPE='bb'
GROUP BY CLASS;

-- Exercise 3
SELECT AVG(NUMGUNS) AS 'average guns'
FROM CLASSES
WHERE TYPE='bb';

-- Exercise 4
SELECT cl.CLASS, MIN(sh.LAUNCHED) as 'First Year', MAX(sh.LAUNCHED) AS 'Last Year'
FROM CLASSES AS cl
INNER JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
GROUP BY cl.CLASS;

-- Exercise 5
SELECT cl.CLASS, COUNT(sh.NAME) AS 'No_sunk'
FROM CLASSES AS cl
INNER JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
INNER JOIN OUTCOMES AS o ON sh.NAME=o.SHIP
WHERE o.RESULT='sunk'
GROUP BY cl.CLASS;

-- Exercise 6
SELECT cl.CLASS, COUNT(sh.NAME) AS 'No_sunk'
FROM CLASSES AS cl
INNER JOIN SHIPS AS sh ON cl.CLASS=sh.CLASS
INNER JOIN OUTCOMES AS o ON o.SHIP=sh.NAME
WHERE o.RESULT='sunk'
GROUP BY cl.CLASS
HAVING COUNT(sh.NAME) > 2;

-- Exercise 7
SELECT COUNTRY, AVG(BORE) AS 'average bore'
FROM CLASSES
GROUP BY COUNTRY;
