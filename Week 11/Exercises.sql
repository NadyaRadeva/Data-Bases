USE FLIGHTS;

-- Exercise 1
CREATE VIEW v_flights_3 AS
SELECT a.NAME AS airline_name, f.FNUMBER AS flight_number, COUNT(b.CUSTOMER_ID) AS confirmed_passengers
FROM AIRLINES AS a
LEFT JOIN FLIGHTS AS f ON a.CODE = f.AIRLINE_OPERATOR
LEFT JOIN BOOKINGS AS b ON f.FNUMBER = b.FLIGHT_NUMBER AND b.STATUS = 1
GROUP BY a.NAME, f.FNUMBER;

SELECT * FROM v_flights_3 ORDER BY airline_name, flight_number;

-- Exercise 2
CREATE VIEW v_client_from_agency AS
SELECT  a.NAME AS AGENCY, c.FNAME, c.LNAME, COUNT(*) AS BOOKINGS_COUNT
FROM AGENCIES a
JOIN BOOKINGS b ON a.NAME = b.AGENCY
JOIN CUSTOMERS c ON b.CUSTOMER_ID = c.ID
GROUP BY a.NAME, c.ID, c.FNAME, c.LNAME
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM BOOKINGS b2
        WHERE b2.AGENCY = a.NAME
 GROUP BY b2.CUSTOMER_ID
    ) AS sub
);

SELECT * FROM v_client_from_agency;

-- Exercise 3
CREATE VIEW v_agencies_sofia AS
SELECT *
FROM AGENCIES
WHERE CITY = 'Sofia'
WITH CHECK OPTION;

INSERT INTO v_agencies_sofia
VALUES ('New Agency', 'Bulgaria', 'Sofia', '0888888888');

INSERT INTO v_agencies_sofia
VALUES ('Bad Agency', 'Bulgaria', 'Varna', '0888888888');

-- Exercise 4
CREATE VIEW v_agencies_no_phone AS
SELECT *
FROM AGENCIES
WHERE PHONE IS NULL
WITH CHECK OPTION;

INSERT INTO v_agencies_no_phone
VALUES ('NoPhone Agency', 'Bulgaria', 'Sofia', NULL);

INSERT INTO v_agencies_no_phone
VALUES ('WithPhone Agency', 'Bulgaria', 'Sofia', '0888123456');

-- Exercise 5
INSERT INTO v_agencies_sofia
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');
INSERT INTO v_agencies_sofia
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);
INSERT INTO v_SF_Agencies
VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');
INSERT INTO v_agencies_no_phone
VALUES('T4 Tour', 'Bulgaria', 'Varna',null);
INSERT INTO v_agencies_no_phone
VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');

-- Exercise 6
-- 3 and 4

-- Exercise 7
DROP VIEW v_flights_3;
DROP VIEW v_client_from_agency;
DROP VIEW v_agencies_sofia;
DROP VIEW v_agencies_no_phone;


USE pc;

-- Exercise 8
CREATE INDEX idx_product_maker_type
ON product(maker, type);

SELECT *
FROM product
WHERE maker = 'A' AND type = 'Printer';


USE ships;

-- Exercise 9
CREATE INDEX idx_classes_type
ON Classes(type);

CREATE INDEX idx_classes_country
ON Classes(country);

CREATE INDEX idx_ships_class
ON Ships(class);

CREATE INDEX idx_ships_launched
ON Ships(launched);

CREATE INDEX idx_battles_date
ON Battles(date);

CREATE INDEX idx_outcomes_ship
ON Outcomes(ship);

CREATE INDEX idx_outcomes_battle
ON Outcomes(battle);

CREATE INDEX idx_outcomes_ship_battle
ON Outcomes(ship, battle);

-- Exercise 10
DROP INDEX idx_product_maker_type ON product;

DROP INDEX idx_classes_type ON Classes;
DROP INDEX idx_classes_country ON Classes;

DROP INDEX idx_ships_class ON Ships;
DROP INDEX idx_ships_launched ON Ships;

DROP INDEX idx_battles_date ON Battles;

DROP INDEX idx_outcomes_ship ON Outcomes;
DROP INDEX idx_outcomes_battle ON Outcomes;
DROP INDEX idx_outcomes_ship_battle ON Outcomes;
