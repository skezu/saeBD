---------Vue "VuePersonnageSpecialite" :
CREATE VIEW VuePersonnageSpecialite AS
SELECT p.numPersonnage, p.nomPersonnage, p.aliasPersonnage, s.nomSpecialite
FROM Personnage p
JOIN SpecialitePersonnage sp ON p.numPersonnage = sp.numPersonnage
JOIN Specialite s ON sp.numSpecialite = s.numSpecialite;

---------Vue "VueEvenementLieu" :
CREATE VIEW VueEvenementLieu AS
SELECT e.numEvenement, e.descriptionEvenement, ep.nomEpisode, l.nomLieu
FROM Evenement e
JOIN Episode ep ON e.episodeEvenement = ep.numEpisode
JOIN Lieu l ON e.LieuEvenement = l.numLieu;
-------Vue "VuePersonnageEpisode" :
CREATE VIEW VuePersonnageEpisode AS
SELECT ep.numEpisode, ep.nomEpisode, p.nomPersonnage
FROM EpisodePersonnage ep
JOIN Personnage p ON ep.numPersonnage = p.numPersonnage;
--------Vue "VueArcSaison" :
CREATE VIEW VueArcSaison AS
SELECT a.numArc, a.nomArc, s.nomSaison
FROM Arc a
JOIN Saison s ON a.numArc = s.Arc;

---------Vue "VueClanPersonnage" :
CREATE VIEW VueClanPersonnage AS
SELECT c.numClan, c.nomClan, p.nomPersonnage
FROM Clan c
JOIN Personnage p ON c.numClan = p.Clan;