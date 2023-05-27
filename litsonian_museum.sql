DROP DATABASE IF EXISTS litsonian_museum;
CREATE DATABASE litsonian_museum;
USE litsonian_museum;

DROP TABLE IF EXISTS Exhibit;
CREATE TABLE Exhibit(
	EID					INT				PRIMARY KEY		AUTO_INCREMENT,
    Exhibit_Name		VARCHAR(100)	NOT NULL,
    Start_Date			DATE			NOT NULL,
    End_Date			DATE			NOT NULL,
    Description			VARCHAR(1000)	NOT NULL,
    CHECK (End_date > Start_date),
    CONSTRAINT Exhibit_SK UNIQUE (EID, Exhibit_name)
    );
        
DROP TABLE IF EXISTS Section;        
CREATE TABLE Section (
    SID INT AUTO_INCREMENT PRIMARY KEY,
    Stype ENUM('empty', 'storage', 'display') NOT NULL,
    EID INT,
    CONSTRAINT EID_FK
		FOREIGN KEY (EID)
        REFERENCES Exhibit,
    CONSTRAINT Section_SK UNIQUE (SID, Stype)
);

DROP TABLE IF EXISTS Artifact_Owner;
CREATE TABLE Artifact_Owner(
    OID					INT		AUTO_INCREMENT		PRIMARY KEY,
    Owner_name			VARCHAR(100),
    CONSTRAINT Owner_SK UNIQUE (OID, Owner_name)
);

DROP TABLE IF EXISTS Artifact;
CREATE TABLE Artifact(
	AID					INT		PRIMARY KEY		AUTO_INCREMENT,
    Description			VARCHAR(1000)		NOT NULL,
    Art_Medium			VARCHAR(100)		NOT NULL,
    Ownership_Status	ENUM('OWNED','BORROWED')		NOT NULL,
    Display_Status		ENUM('ON_DISPLAY','LOANED_OUT','IN_STORAGE')		NOT NULL,
    Title				VARCHAR(100),
    OID					INT		NOT NULL,
    EID					INT,
    SID					INT,
	CONSTRAINT Owner_FK
		FOREIGN KEY (OID)
		REFERENCES Artifact_Owner (OID),
    CONSTRAINT Exhibit_FK
		FOREIGN KEY (EID)
		REFERENCES Exhibit (EID),
	CONSTRAINT Section_FK
		FOREIGN KEY (SID)
		REFERENCES Section (SID),
	CONSTRAINT Artifact_SK UNIQUE (AID, OID, Display_Status, Ownership_Status)
);

DROP TABLE IF EXISTS Artwork;
CREATE TABLE Artwork(
    AID					INT		PRIMARY KEY,
    Style				VARCHAR(50)		NOT NULL,
    Creation_Date		VARCHAR(20),
    Artist_Name			VARCHAR(100),
    CONSTRAINT Artifact_FK
        FOREIGN KEY (AID)
        REFERENCES Artifacts (AID),
	CONSTRAINT Artwork_SK UNIQUE (AID, Style)
);

DROP TABLE IF EXISTS Literature;
CREATE TABLE Literature(
    AID					INT                PRIMARY KEY,
    Lit_Language		VARCHAR(30)        NOT NULL,
    Author				VARCHAR(100),
    Creation_Date    	VARCHAR(20),
    Transcription    	VARCHAR(200),
    Genre            	VARCHAR(50),
    CONSTRAINT AID_FK
        FOREIGN KEY (AID)
        REFERENCES Artifact,
	CONSTRAINT Literature_SK UNIQUE (AID, Lit_Language)
);

DROP TABLE IF EXISTS Item;
CREATE TABLE Item(
    AID                 	INT                PRIMARY KEY,
    Date_Discovered        	VARCHAR(20),
    Relevant_Date_Range    	VARCHAR(100),
    Creator                	VARCHAR(100),
    CHECK (Date_Discovered <= GetDate()),
    CONSTRAINT AID_FK
        FOREIGN KEY (AID)
        REFERENCES Artifact
);