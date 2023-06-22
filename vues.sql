--### Vue "VuePersonnageSpecialite" :

--Cette vue affiche les informations sur les personnages ainsi que leurs spécialités.

CREATE VIEW VuePersonnageSpecialite AS
SELECT p.numPersonnage, p.nomPersonnage, p.aliasPersonnage, s.nomSpecialite
FROM Personnage p
         JOIN SpecialitePersonnage sp ON p.numPersonnage = sp.numPersonnage
         JOIN Specialite s ON sp.numSpecialite = s.numSpecialite;


--### Vue "VueEvenementLieu" :

--Cette vue affiche les événements avec leurs lieux correspondants.

CREATE VIEW VueEvenementLieu AS
SELECT e.numEvenement, e.descriptionEvenement, ep.nomEpisode, l.nomLieu
FROM Evenement e
         JOIN Episode ep ON e.episodeEvenement = ep.numEpisode
         JOIN Lieu l ON e.LieuEvenement = l.numLieu;


--### Vue "VuePersonnageEpisode" :

--Cette vue affiche les personnages présents dans chaque épisode.

CREATE VIEW VuePersonnageEpisode AS
SELECT ep.numEpisode, p.nomPersonnage
FROM EpisodePersonnage ep
         JOIN Personnage p ON ep.numPersonnage = p.numPersonnage;


--### Vue "VueArcSaison" :

--Cette vue affiche les arcs avec les saisons auxquelles ils appartiennent.

CREATE VIEW VueArcSaison AS
SELECT a.numArc, a.nomArc, s.nomSaison
FROM Arc a
         JOIN Saison s ON a.numArc = s.Arc;

--### Vue "VueClanPersonnage" :

--Cette vue affiche les clans avec les personnages qui en font partie.

CREATE VIEW VueClanPersonnage AS
SELECT c.numClan, c.nomClan, p.nomPersonnage
FROM Clan c
         JOIN Personnage p ON c.numClan = p.Clan;
