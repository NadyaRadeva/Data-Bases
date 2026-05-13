USE FLIGHTS;

-- Exercise 1
ALTER TABLE FLIGHTS
ADD num_pass INT DEFAULT 0;

SELECT * FROM FLIGHTS;

UPDATE f
SET num_pass = (
    SELECT COUNT(*)
    FROM BOOKINGS b
    WHERE b.FLIGHT_NUMBER = f.FNUMBER AND b.STATUS = 1
)
FROM FLIGHTS f;

-- Exercise 2
ALTER TABLE AGENCIES
ADD num_book INT DEFAULT 0;

UPDATE c
SET num_book = (
    SELECT COUNT(*)
    FROM BOOKINGS b
    WHERE b.AGENCY = c.NAME
)
FROM AGENCIES c;

SELECT * FROM AGENCIES;

-- Exercise 3
CREATE TRIGGER trg_update_counts
ON BOOKINGS
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE f
    SET f.num_pass = f.num_pass + x.cnt
    FROM FLIGHTS f
    JOIN (
        SELECT FLIGHT_NUMBER, COUNT(*) AS cnt
        FROM inserted
        WHERE STATUS = 1
        GROUP BY FLIGHT_NUMBER
    ) x ON f.FNUMBER = x.FLIGHT_NUMBER;

    UPDATE a
    SET a.num_book = a.num_book + y.cnt
    FROM AGENCIES a
    JOIN (
        SELECT AGENCY, COUNT(*) AS cnt
        FROM inserted
        GROUP BY AGENCY
    ) y ON a.NAME = y.AGENCY;

END;
GO


INSERT INTO BOOKINGS
VALUES ('ZZ9999', 'Travel One', 'FB', 'FB1363', 1, '2024-01-01', '2024-02-01', 200, 1);

SELECT FNUMBER, num_pass FROM FLIGHTS WHERE FNUMBER='FB1363';
SELECT NAME, num_book FROM AGENCIES WHERE NAME='Travel One';

-- Exercise 4
CREATE TRIGGER trg_update_counts_delete
ON BOOKINGS
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE f
    SET f.num_pass = f.num_pass - x.cnt
    FROM FLIGHTS f
    JOIN (
        SELECT FLIGHT_NUMBER, COUNT(*) AS cnt
        FROM deleted
        WHERE STATUS = 1
        GROUP BY FLIGHT_NUMBER
    ) x ON f.FNUMBER = x.FLIGHT_NUMBER;

    UPDATE a
    SET a.num_book = a.num_book - y.cnt
    FROM AGENCIES a
    JOIN (
        SELECT AGENCY, COUNT(*) AS cnt
        FROM deleted
        GROUP BY AGENCY
    ) y ON a.NAME = y.AGENCY;

END;
GO

DELETE FROM BOOKINGS
WHERE CODE = 'YN698P';

SELECT FNUMBER, num_pass FROM FLIGHTS WHERE FNUMBER='FB852';
SELECT NAME, num_book FROM AGENCIES WHERE NAME='Fly Tour';


-- Exercise 5
CREATE TRIGGER trg_update_counts_update
ON BOOKINGS
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE f
    SET f.num_pass = f.num_pass + x.cnt
    FROM FLIGHTS f
    JOIN (
        SELECT i.FLIGHT_NUMBER, COUNT(*) AS cnt
        FROM inserted i
        JOIN deleted d ON i.CODE = d.CODE
        WHERE d.STATUS = 0 AND i.STATUS = 1
        GROUP BY i.FLIGHT_NUMBER
    ) x ON f.FNUMBER = x.FLIGHT_NUMBER;

    UPDATE f
    SET f.num_pass = f.num_pass - y.cnt
    FROM FLIGHTS f
    JOIN (
        SELECT i.FLIGHT_NUMBER, COUNT(*) AS cnt
        FROM inserted i
        JOIN deleted d ON i.CODE = d.CODE
        WHERE d.STATUS = 1 AND i.STATUS = 0
        GROUP BY i.FLIGHT_NUMBER
    ) y ON f.FNUMBER = y.FLIGHT_NUMBER;

END;
GO


UPDATE BOOKINGS
SET STATUS = 1
WHERE CODE = 'YN298P';

UPDATE BOOKINGS
SET STATUS = 0
WHERE CODE = 'YN698P';
