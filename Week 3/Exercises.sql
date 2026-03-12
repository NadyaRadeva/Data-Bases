USE movies;

-- Exercise 1
SELECT me.name
FROM MovieExec AS me
WHERE me.name IN (
        SELECT ms.name
        FROM MovieStar AS ms
        WHERE ms.gender = 'F'
    )
  AND me.networth > 10000000;

-- Exercise 2
SELECT ms.name
FROM MovieStar AS ms
WHERE ms.name NOT IN (
        SELECT me.name
        FROM MovieExec AS me
    );

-- Exercise 3
SELECT m.TITLE
FROM MOVIE AS m
WHERE m.LENGTH > (
        SELECT m1.LENGTH 
        FROM MOVIE AS m1 
        WHERE m1.TITLE='Star Wars'
        );

-- Exercise 4
SELECT m.TITLE, me0.NAME
FROM Movie AS m
JOIN MOVIEEXEC AS me0 ON m.PRODUCERC#=me0.CERT#
WHERE m.producerC# IN (
        SELECT me.cert#
        FROM MovieExec AS me
        WHERE me.networth >
              (SELECT me1.networth
               FROM MovieExec AS me1
               WHERE me1.name = 'Merv Griffin')
);



USE pc;

-- Exercise 1
SELECT DISTINCT pr.maker
FROM Product AS pr
WHERE pr.model IN (
        SELECT pc.model
        FROM PC AS pc
        WHERE pc.speed > 500
    );

-- Exercise 2
SELECT print1.code, print1.model, print1.price
FROM printer AS print1
WHERE print1.price >= ALL (SELECT print2.price FROM printer AS print2);

-- Exercise 3
SELECT *
FROM laptop AS lap1
WHERE lap1.speed < ALL (
        SELECT pc1.speed
        FROM pc AS pc1
    );

-- Exercise 4
SELECT model, price
FROM (
        SELECT model, price FROM pc
        UNION
        SELECT model, price FROM laptop
        UNION
        SELECT model, price FROM printer
     ) AS allProducts
WHERE price >= ALL (
        SELECT price
        FROM (
                SELECT price FROM pc
                UNION
                SELECT price FROM laptop
                UNION
                SELECT price FROM printer
             ) AS allPrices
     );

-- Exercise 5
SELECT pr.maker
FROM product AS pr
WHERE pr.model IN (
        SELECT print1.model
        FROM printer AS print1
        WHERE print1.color = 'y'
          AND print1.price <= ALL (
                SELECT print2.price
                FROM printer AS print2
                WHERE print2.color = 'y'
          )
);

-- Exercise 6
SELECT pr.maker
FROM product AS pr
WHERE pr.model IN (
        SELECT pc1.model
        FROM pc AS pc1
        WHERE pc1.speed >= ALL (
                SELECT pc2.speed
                FROM pc AS pc2
        )
        AND pc1.ram <= ALL (
                SELECT pc3.ram
                FROM pc AS pc3
                WHERE pc3.speed >= ALL (
                        SELECT pc4.speed
                        FROM pc AS pc4
                )
        )
);




USE ships;

-- Exercise 1
SELECT DISTINCT cl.COUNTRY
FROM CLASSES AS cl
WHERE cl.NUMGUNS >= ALL (
					      SELECT cl2.NUMGUNS
						  FROM CLASSES AS cl2);

-- Exercise 2
SELECT DISTINCT s.class
FROM Ships AS s
WHERE s.name IN (
        SELECT o.ship
        FROM Outcomes AS o
        WHERE o.result = 'sunk'
    );

-- Exercise 3
SELECT sh1.NAME, sh1.CLASS
FROM SHIPS AS sh1
WHERE sh1.CLASS IN (
                     SELECT cl.CLASS
                     FROM CLASSES AS cl
                     WHERE cl.BORE=16);

-- Exercise 4
SELECT b.NAME
FROM BATTLES AS b
WHERE b.NAME IN (
                  SELECT o.BATTLE
                  FROM OUTCOMES AS o
                  WHERE o.SHIP IN (
                                    SELECT sh.NAME
                                    FROM SHIPS AS sh
                                    WHERE sh.CLASS='Kongo'));

-- Exercise 5
SELECT sh.name, sh.class
FROM Ships AS sh
WHERE sh.class IN (
        SELECT cl.class
        FROM Classes AS cl
        WHERE cl.numGuns >= ALL (
                SELECT cl2.numGuns
                FROM Classes AS cl2
                WHERE cl2.bore = cl.bore
        )
);
