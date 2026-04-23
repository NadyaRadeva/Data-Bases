USE nw;

-- recursion
WITH foo AS
(
	(
	  SELECT EmployeeID, FirstName, LastName, Title, ReportsTo, 0 LVL 
	  FROM Employees
	  WHERE ReportsTo IS NULL
	)
	UNION ALL
	(
	  SELECT e.EmployeeID, e.FirstName, e.LastName, e.Title, e.ReportsTo, (foo.LVL+1) LVL FROM foo
	  INNER JOIN Employees e ON e.ReportsTo=foo.EmployeeID
	)
)
SELECT * FROM foo;

USE foo;

DROP TABLE Movie;
CREATE TABLE Movie (
                    title VARCHAR(20),
					year INT,
					length INT,
					colour CHAR(1),
					CONSTRAINT UC_MOVIE1 UNIQUE(title, year)
					)

SELECT * FROM MOVIE;

DROP TABLE Movie;
CREATE TABLE Movie (
                    title VARCHAR(20),
					year INT,
					length INT,
					colour CHAR(1),
					CONSTRAINT pk_movie_17 PRIMARY KEY(title, year)
					)

SELECT * FROM MOVIE;


DROP TABLE Star;
CREATE TABLE(
			 NAME VARCHAR(20) NOT NULL UNIQUE,
			 BIRTHDATE DATE,
			 ADDRESS VARCHAR(40),
			 CONSTRAINT  pk_star_1 PRIMARY KEY(NAME)
			 )

DROP TABLE si;
CREATE TABLE si(
				id INT PRIMARY KEY,
				mtitle VARCHAR(20),
				myear INT,
				sname VARCHAR(20)
				)


DROP TABLE si;
CREATE TABLE si(
				id INT PRIMARY KEY,
				mtitle VARCHAR(20),
				myear INT,
				sname VARCHAR(20),
				constraint fk_si_3 FOREIGN KEY(sname) REFERENCES Star(name)
					ON DELETE NO ACTION
					ON UPDATE NO ACTION
				)

--NAME,STARTDATE, ENDDATE - constraints, data - homework - za vseki proekt k[ dvoj programisti e rabotila sumarno naj-dylgo vreme zaedno
CREATE TABLE Track(
					USERNAME VARCHAR(8),
					PROJECT INT PRIMARY KEY,
					STARTDATE DATE,
					ENDDATE DATE,
					CONSTRAINT )
