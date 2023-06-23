DROP TABLE Specialite;
DROP TABLE RoleRole;
DROP TABLE Clan;
DROP TABLE Arc;
DROP TABLE Saison;
DROP TABLE Episode;
Drop Table Ville;
DROP TABLE EpisodeVille;
DROP TABLE Lieu;
DROP TABLE Rang;
DROP TABLE Personnage;
DROP TABLE Relation;
DROP TABLE EpisodePersonnage;
DROP TABLE Niveau;
DROP TABLE EvenementPersonnage;
DROP TABLE SpecialitePersonnage;
DROP TABLE Evenement;
-------------------------------------------------------------------SPECIALITE--------------------------------------------------------------------------------

CREATE TABLE Specialite (
    numSpecialite NUMBER PRIMARY KEY,
    nomSpecialite VARCHAR(50)
);



-------------------------------------------------------------------ROLE--------------------------------------------------------------------------------
CREATE TABLE RoleRole(
  numRoleRole NUMBER PRIMARY KEY,
  nomRoleRole VARCHAR(50)
);
 
-------------------------------------------------------------------CLAN--------------------------------------------------------------------------------
CREATE TABLE Clan(
  numClan NUMBER,
  nomClan VARCHAR(50),
  descriptionClan VARCHAR(255),
  PRIMARY KEY (numClan)
) ;


------------------------------------ARC----------------------------------------------------------------------------------

CREATE TABLE Arc(
  numArc NUMBER,
  nomArc VARCHAR(50),
  descriptionArc VARCHAR(255),
  PRIMARY KEY (numArc)
);



--------------------ArcSaison----------------------------------------------
CREATE TABLE ArcSaison(
  numArc NUMBER,
  numSaison NUMBER,
  FOREIGN KEY (numArc) REFERENCES Arc(numArc),
  FOREIGN KEY (numSaison) REFERENCES Saison(numSaison),
  PRIMARY KEY (numArc,numSaison)
);

---------------------------------------------- SAISON --------------------------------------------------------------------------------

CREATE TABLE Saison(
  numSaison NUMBER,
  nomSaison VARCHAR(25),
  numeroSaison NUMBER,
  descriptionSaison VARCHAR(255),
  Arc NUMBER,
  FOREIGN KEY (numSaison) REFERENCES ArcSaison(numSaison),
  PRIMARY KEY (numSaison)
);


--------------------------------EPISODE-------------------------------------------------
CREATE TABLE Episode(
  numEpisode NUMBER,
  nomEpisode VARCHAR(50),
  numeroEpisode NUMBER,
  tempEpisode VARCHAR(25),
  descriptionEpisode VARCHAR(255),
  saison NUMBER,
  FOREIGN KEY (saison) REFERENCES Saison(numSaison),
  PRIMARY KEY (numEpisode),
  CHECK (saison >= 1),
  CHECK (numeroEpisode > 0),
  UNIQUE (numeroEpisode, saison)
);

------------------------------------------------VILLE---------------------------------------
CREATE TABLE Ville (
  numville NUMBER,
  nomville VARCHAR(25),
  PRIMARY KEY (numville)
);

------------------------------------------------EpisodeVille---------------------------------------
CREATE TABLE EpisodeVille(
  numEpisode NUMBER,
  numVille NUMBER,
  FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
  FOREIGN KEY (numVille) REFERENCES Ville(numVille),
  PRIMARY KEY (numEpisode,numVille)
);

-------------------------------------------Lieu------------------------------------------------
CREATE TABLE Lieu (
  numLieu NUMBER,
  nomLieu VARCHAR(60),
  descriptionLieu VARCHAR(255),
  villeLieu NUMBER,
  FOREIGN KEY (villeLieu) REFERENCES Ville(numVille),
  PRIMARY KEY (numLieu)
);

-----------------------------------------------RANG----------------------------------------------------

CREATE TABLE Rang (
    numRang NUMBER,
    nomRang VARCHAR(25),
    PRIMARY KEY (numRang)
);

---------------------------------------Personnage----------------------------------------------------
CREATE TABLE Personnage(
numPersonnage NUMBER,
nomPersonnage VARCHAR(50),
aliasPersonnage VARCHAR(50),
racePersonnage VARCHAR(25),
agePersonnage NUMBER,
sexPersonnage VARCHAR(25),
descriptionPersonnage VARCHAR(255),
villePersonnage NUMBER,
Clan NUMBER,
RolePersonnage NUMBER,
FOREIGN KEY (villePersonnage) REFERENCES Ville(numVille),
FOREIGN KEY (Clan) REFERENCES Clan(numClan),
FOREIGN KEY (RolePersonnage) REFERENCES RoleRole(numRoleRole),
PRIMARY KEY (numPersonnage),
CHECK (sexPersonnage IN ('M', 'F','X')),
CHECK (agePersonnage > 0)
);

------------------------------------------------------------RELATION------------------------------------------------------------
CREATE TABLE Relation (
    numPersonnage NUMBER,
    numPersonnage2 NUMBER,
    typeRelation VARCHAR(20),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numPersonnage2) REFERENCES Personnage(numPersonnage),
    PRIMARY KEY (numPersonnage,numPersonnage2)
);


-------------------------------------------------------------EPISODEPERSONNAGE------------------------------------------------
CREATE TABLE EpisodePersonnage(
numPersonnage NUMBER,
numEpisode NUMBER,
FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
PRIMARY KEY (numPersonnage,numEpisode)
);


-------------------------------------------------------------NIVEAU------------------------------------------------------------
CREATE TABLE Niveau(
    numNiveau NUMBER,
    numEpisode NUMBER,
    numPersonnage NUMBER,
    rangNiveau NUMBER,
    PRIMARY KEY (numNiveau,numEpisode,numPersonnage),
    FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (rangNiveau) REFERENCES Rang(numRang)
);


--------------------------------------------------Evenement------------------------------------------------------------
CREATE TABLE Evenement(
    numEvenement NUMBER,
    descriptionEvenement VARCHAR(50),
    episodeEvenement NUMBER,
    LieuEvenement NUMBER,
    FOREIGN KEY (episodeEvenement) REFERENCES Episode(numEpisode),
    FOREIGN KEY (LieuEvenement) REFERENCES Lieu(numLieu),
    FOREIGN KEY (numEvenement) REFERENCES Evenement(numEvenement),
    PRIMARY KEY (numEvenement)
);


---------------------------------------------------------------SPECIALITEPERSONNAGE------------------------------------------------
CREATE TABLE SpecialitePersonnage(
    numPersonnage NUMBER,
    numSpecialite NUMBER,
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numSpecialite) REFERENCES Specialite(numSpecialite),
    PRIMARY KEY (numPersonnage,numSpecialite)
);


-----------------------------------------------------------EVENEMENTPERSONNAGE------------------------------------------------
CREATE TABLE EvenementPersonnage(
    numPersonnage NUMBER,
    numEvenement NUMBER,
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numEvenement) REFERENCES Evenement(numEvenement),
    PRIMARY KEY (numPersonnage,numEvenement)
);



