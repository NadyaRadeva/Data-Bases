CREATE TABLE Track (
    username VARCHAR(8) NOT NULL,
    project INT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NULL,

    CONSTRAINT PK_Track PRIMARY KEY (username, project),
    CONSTRAINT CK_Track_Dates CHECK (enddate IS NULL OR enddate >= startdate),
    CONSTRAINT CK_Username_Length CHECK (LEN(username) >= 3),
    CONSTRAINT CK_Project_Positive CHECK (project > 0)
);
