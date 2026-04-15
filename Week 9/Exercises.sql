USE movies;

-- Exercise1
INSERT INTO MOVIESTAR(NAME, BIRTHDATE)
VALUES('Nicole Kidman', '1967-06-20');

SELECT * FROM MOVIESTAR;

-- Exercise 2
DELETE FROM MOVIEEXEC
WHERE NETWORTH < 30000000
  AND CERT# NOT IN (SELECT PRODUCERC# FROM MOVIE);

-- Exercise 3
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL;

USE pc;

-- Exercise 4
INSERT INTO PRODUCT (maker, model, type)
VALUES ('C', 1100, 'PC');

INSERT INTO PC (code, model, speed, ram, hd, cd, price)
VALUES (12, 1100, 2400, 2048, 500, '52x', 299);

-- Exercise 5
DELETE FROM PC
WHERE model = 1100;

-- Exercise 6
DELETE FROM Laptop
WHERE model IN (
    SELECT L.model
    FROM Laptop L
    JOIN PRODUCT P ON L.model = P.model
    WHERE P.maker NOT IN (
        SELECT maker
        FROM PRODUCT
        WHERE type = 'Printer'
    )
);

-- Exercise 7
UPDATE PRODUCT
SET maker = 'A'
WHERE maker = 'B';

-- Exercise 8
UPDATE PC
SET price = price / 2, hd = hd + 20;

-- Exercise 9
UPDATE Laptop
SET screen = screen + 1
WHERE model IN (
    SELECT model
    FROM PRODUCT
    WHERE maker = 'B'
);


USE ships;

-- Exercise 10
INSERT INTO Classes (class, type, country, numGuns, bore, displacement)
VALUES ('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000);

INSERT INTO Ships (name, class, launched)
VALUES ('Nelson', 'Nelson', 1927);

INSERT INTO Ships (name, class, launched)
VALUES ('Rodney', 'Nelson', 1927);

-- Exercise 11
DELETE FROM Ships
WHERE name IN (
    SELECT ship
    FROM Outcomes
    WHERE result = 'sunk'
);

-- Exercise 12
UPDATE Classes
SET bore = bore * 2.5;

UPDATE Classes
SET displacement = displacement / 1.1;
