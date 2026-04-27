CREATE TABLE Airline (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE Airport (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    UNIQUE(name, country)
);

CREATE TABLE Airplane (
    code VARCHAR(10) PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    seats INT NOT NULL CHECK (seats > 0),
    production_year INT NOT NULL
);

CREATE TABLE Customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    CHECK (LEN(email) >= 6 AND email LIKE '%@%' AND email LIKE '%.%')
);

CREATE TABLE Agency (
    name VARCHAR(100) PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE Flight (
    flight_number INT PRIMARY KEY,
    airline_code VARCHAR(10) NOT NULL,
    departure_airport VARCHAR(10) NOT NULL,
    arrival_airport VARCHAR(10) NOT NULL,
    flight_time TIME NOT NULL,
    duration INT NOT NULL,
    airplane_code VARCHAR(10) NOT NULL,

    FOREIGN KEY (airline_code) REFERENCES Airline(code),
    FOREIGN KEY (departure_airport) REFERENCES Airport(code),
    FOREIGN KEY (arrival_airport) REFERENCES Airport(code),
    FOREIGN KEY (airplane_code) REFERENCES Airplane(code)
);

CREATE TABLE Booking (
    code INT PRIMARY KEY,
    agency_name VARCHAR(100) NOT NULL,
    airline_code VARCHAR(10) NOT NULL,
    flight_number INT NOT NULL,
    customer_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    flight_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status INT NOT NULL CHECK (status IN (0,1)),

    FOREIGN KEY (agency_name) REFERENCES Agency(name),
    FOREIGN KEY (airline_code) REFERENCES Airline(code),
    FOREIGN KEY (flight_number) REFERENCES Flight(flight_number),
    FOREIGN KEY (customer_id) REFERENCES Customer(id),

    CHECK (flight_date >= reservation_date)
);
