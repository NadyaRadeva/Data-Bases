-- Exercise 1
-- A
CREATE TABLE Product(maker CHAR(1),
					 model CHAR(4),
					 type VARCHAR(7));

CREATE TABLE Printer(code INT,
					 model CHAR(4),
					 price DECIMAL(10,2));

-- Б
INSERT INTO Product(maker, model, type)
VALUES ('A', '1234', 'laptop'), 
       ('B', 'x567', 'pc'),
	   ('C', 'M890', 'printer');

SELECT * FROM Product;

INSERT INTO Printer(code, model, price)
VALUES (101, 'P123', 199.99),
       (102, 'X456', 349.50),
	   (103, 'Z111', 120.00);

SELECT * FROM Printer;

-- В
ALTER TABLE Printer ADD type VARCHAR(6), colour CHAR(1);

SELECT * FROM Printer;

-- Г
ALTER TABLE Printer DROP COLUMN price;

SELECT * FROM Printer;

-- Д
DROP TABLE Product;
DROP TABLE Printer;


-- Exercise 2
CREATE TABLE Users(id INT,
				   email VARCHAR(100),
				   password VARCHAR(100),
				   registration_date DATE);

CREATE TABLE Friends(user_id INT,
                     friend_id INT);

CREATE TABLE Walls(receiver INT,
                  sender INT,
				  content VARCHAR(500),
				  sent_date DATE);

CREATE TABLE Groups(id INT,
                    name VARCHAR(100),
					description VARCHAR(200) DEFAULT '');

CREATE TABLE GroupMembers(group_id INT,
                          user_id INT);


INSERT INTO Users (id, email, password, registration_date)
VALUES (1, 'ivan@mail.com', 'pass123', '2024-03-15'),
       (2, 'maria@gmail.com', 'maria456', '2024-04-02'),
       (3, 'petar@yahoo.com', 'petar789', '2024-05-10');

INSERT INTO Friends (user_id, friend_id) 
VALUES (1, 2),
       (1, 3),
       (2, 3);

INSERT INTO Walls (receiver, sender, content, sent_date) 
VALUES (1, 2, 'Happy Birthday!', '2024-06-10'),
       (2, 1, 'Good luck on your exam!', '2024-06-15'),
       (3, 2, 'See you tomorrow!', '2024-06-20');

INSERT INTO Groups (id, name, description) 
VALUES (1, 'BookClub', 'Group for book lovers'),
       (2, 'Travelers', 'People who love travelling'),
       (3, 'Gamers', '');

INSERT INTO GroupMembers (group_id, user_id) 
VALUES (1, 1),
       (1, 2),
       (2, 3);

SELECT * FROM Users;
SELECT * FROM Friends;
SELECT * FROM Walls;
SELECT * FROM Groups;
SELECT * FROM GroupMembers;
