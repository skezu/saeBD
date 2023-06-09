
-------------------------------------------------------------------SPECIALITE--------------------------------------------------------------------------------

CREATE TABLE Specialite (
  numSpecialite INTEGER(4),
  nomSpecialite VARCHAR(25)
  Primary Key (numSpecialite)
);
DROP TABLE Specialite;

-------------------------------------------------------------------ROLE--------------------------------------------------------------------------------
CREATE TABLE Role(
  numRole INTEGER(4) PRIMARY KEY,
  nomRole VARCHAR(25)
  PRIMARY KEY (numRole)

) ;
  DROP TABLE Role;
-------------------------------------------------------------------CLAN--------------------------------------------------------------------------------
CREATE TABLE Clan(
  numClan INTEGER(4),
  nomClan VARCHAR(25),
  descriptionClan VARCHAR(255),
  PRIMARY KEY (numClan)
) ;
DROP TABLE Clan;

------------------------------------ARC----------------------------------------------------------------------------------

CREATE TABLE Arc(
  numArc INTEGER(4),
  nomArc VARCHAR(25),
  descriptionArc VARCHAR(255),
  PRIMARY KEY (numArc)
);
DROP TABLE Arc;
---------------------------------------------- SAISON --------------------------------------------------------------------------------

CREATE TABLE Saison(
  numSaison INTEGER(4) ,
  nomSaison VARCHAR(25),
  numeroSaison INTEGER(4),
  descriptionSaison VARCHAR(255),
  Arc INTEGER(4),
  FOREIGN KEY Arc REFERENCE Arc(numArc),
  PRIMARY KEY (numSaison)
);
DROP TABLE Saison;

--------------------------------EPISODE-------------------------------------------------
CREATE TABLE Episode(
  numEpisode INTEGER(4),
  nomEpisode VARCHAR(25),
  numeroEpisode INTEGER(4),
  tempEpisode VARCHAR(25),
  descriptionEpisode VARCHAR(255),
  saison INTEGER(4),
  FOREIGN KEY saison REFERENCE Saison(numSaison);
  PRIMARY KEY (numEpisode)
);
DROP TABLE Episode;
------------------------------------------------VILLE---------------------------------------
CREATE TABLE Ville (
  numville INTEGER(4),
  nomville VARCHAR(25)
  PRIMARY KEY (numville)
);
Drop Table Ville;
------------------------------------------------EpisodeVille---------------------------------------
CREATE TABLE EpisodeVille(
  numEpisode INTEGER(4),
  numVille INTEGER(4),
  FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
  FOREIGN KEY (numVille) REFERENCES Ville(numVille),
  PRIMARY KEY (numEpisode,numVille)
);
DROP TABLE EpisodeVille;
-------------------------------------------Lieu------------------------------------------------
CREATE TABLE Lieu (
  numLieu INTEGER(4),
  nomLieu VARCHAR(60),
  descriptionLieu VARCHAR(255),
  villeLieu INTEGER(4),
  FOREIGN KEY (villeLieu) REFERENCES Ville(numVille),
  PRIMARY KEY (numLieu)
);
DROP TABLE Lieu;
-----------------------------------------------RANG----------------------------------------------------

    CREATE TABLE Rang (
    numRang INTEGER(4),
    nomRang VARCHAR(25);
    PRIMARY KEY (numRang)
);
DROP TABLE Rang;
---------------------------------------Personnage----------------------------------------------------
CREATE TABLE Personnage(
numPersonnage INTEGER(4),
nomPersonnage VARCHAR(25),
aliasPersonnage VARCHAR(25),
racePersonnage VARCHAR(25),
agePersonnage INTEGER(4),
sexPersonnage VARCHAR(25),
descriptionPersonnage VARCHAR(255),
villePersonnage INTEGER(4),
Clan INTEGER(4),
rangPersonnage INTEGER(4),
RolePersonnage INTEGER(4),
FOREIGN KEY (villePersonnage) REFERENCES Ville(numVille),
FOREIGN KEY (rangPersonnage) REFERENCES Rang(numRang),
FOREIGN KEY (Clan) REFERENCES Clan(numClan),
FOREIGN KEY (RolePersonnage) REFERENCES Role(numRole),
PRIMARY KEY (numPersonnage)
)
DROP TABLE Personnage;

------------------------------------------------------------RELATION------------------------------------------------------------
CREATE TABLE Relation (
    numPersonnage INTEGER(4),
    numPersonnage2 INTEGER(4),
    typeRelation VARCHAR(20),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numPersonnage2) REFERENCES Personnage(numPersonnage),
    PRIMARY KEY (numPersonnage,numPersonnage2)
)
DROP TABLE Relation;

-------------------------------------------------------------EPISODEPERSONNAGE------------------------------------------------
CREATE TABLE EpisodePersonnage(
numPersonnage INTEGER(4),
numEpisode INTEGER(4),
FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
PRIMARY KEY (numPersonnage,numEpisode)
);
DROP TABLE EpisodePersonnage;

-------------------------------------------------------------NIVEAU------------------------------------------------------------
CREATE TABLE Niveau(
    numNiveau INTEGER,
    numEpisode INTEGER,
    numPersonnage INTEGER,
    rangNiveau INTEGER,
    FOREIGN KEY (numNiveau) REFERENCES Niveau(numNiveau),
    FOREIGN KEY (numEpisode) REFERENCES Episode(numEpisode),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (rangNiveau) REFERENCES Rang(numRang),
    PRIMARY KEY (numNiveau,numEpisode,numPersonnage)
);
DROP TABLE Niveau;

--------------------------------------------------Evenement------------------------------------------------------------
CREATE TABLE Evenement(
    numEvenement INTEGER(4), 
    descriptionEvenement VARCHAR(50),
    episodeEvenement INTEGER(4),
    LieuEvenement INTEGER(4),
    FOREIGN KEY (episodeEvenement) REFERENCES Episode(numEpisode),
    FOREIGN KEY (LieuEvenement) REFERENCES Lieu(numLieu),
    FOREIGN KEY (numEvenement) REFERENCES Evenement(numEvenement),
    PRIMARY KEY (numEvenement)
);
DROP TABLE Evenement;

---------------------------------------------------------------SPECIALITEPERSONNAGE------------------------------------------------
CREATE TABLE SpecialitePersonnage(
    numPersonnage INTEGER(4),
    numSpecialite INTEGER(4),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numSpecialite) REFERENCES Specialite(numSpecialite),
    PRIMARY KEY (numPersonnage,numSpecialite)
);
DROP TABLE SpecialitePersonnage;

-----------------------------------------------------------EVENEMENTPERSONNAGE------------------------------------------------
CREATE TABLE EvenementPersonnage(
    numPersonnage INTEGER(4),
    numEvenement INTEGER(4),
    FOREIGN KEY (numPersonnage) REFERENCES Personnage(numPersonnage),
    FOREIGN KEY (numEvenement) REFERENCES Evenement(numEvenement),
    PRIMARY KEY (numPersonnage,numEvenement)
);
DROP TABLE EvenementPersonnage;


