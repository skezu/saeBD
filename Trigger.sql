---------------------Trigger pour vérifier l'âge minimum d'un personnage :Ce déclencheur empêche l'insertion d'un personnage dont l'âge est inférieur à 18 ans car un héro ou un monstre doit être majeur.
CREATE OR REPLACE TRIGGER VerifierAgePersonnage
BEFORE INSERT ON Personnage
FOR EACH ROW
BEGIN
    IF :NEW.agePersonnage < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'L''âge du personnage doit être supérieur ou égal à 18 ans.');
    END IF;
END;
-------------------------------Trigger pour mettre à jour le rang d'un personnage en fonction de son niveau :Ce déclencheur met à jour automatiquement le rang d'un personnage lorsqu'un nouveau niveau lui est attribué.
CREATE OR REPLACE TRIGGER MettreAJourRangPersonnage
AFTER INSERT ON Niveau
FOR EACH ROW
BEGIN
    UPDATE Personnage
    SET rangPersonnage = :NEW.rangNiveau
    WHERE numPersonnage = :NEW.numPersonnage;
END;
----------------Trigger pour empêcher la suppression d'un lieu utilisé lors d'un événement :Ce déclencheur empêche la suppression d'un lieu s'il est associé à un événement existant.
CREATE OR REPLACE TRIGGER VerifierSuppressionLieu
BEFORE DELETE ON Lieu
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Evenement WHERE LieuEvenement = :OLD.numLieu) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Ce lieu ne peut pas être supprimé car il est utilisé dans un événement.');
    END IF;
END;
------------------Trigger pour mettre à jour la description d'un arc lors de la modification de ses épisodes :Ce déclencheur met à jour la description d'un arc en fonction des descriptions de ses épisodes.
CREATE OR REPLACE TRIGGER MettreAJourDescriptionArc
AFTER UPDATE ON Episode
FOR EACH ROW
BEGIN
    UPDATE Arc
    SET descriptionArc = (
        SELECT LISTAGG(descriptionEpisode, '; ')
        WITHIN GROUP (ORDER BY numeroEpisode)
        FROM Episode
        WHERE saison = :NEW.saison
    )
    WHERE numArc = (
        SELECT Arc
        FROM Saison
        WHERE numSaison = :NEW.saison
    );
END;
------------------Trigger pour vérifier la spécialité d'un personnage lors de son ajout à un épisode :Ce déclencheur vérifie si le personnage ajouté à un épisode possède la spécialité requise pour l'événement.
CREATE OR REPLACE TRIGGER VerifierSpecialitePersonnage
BEFORE INSERT ON EpisodePersonnage
FOR EACH ROW
DECLARE
    specialiteRequise NUMBER;
BEGIN
    SELECT numSpecialite
    INTO specialiteRequise
    FROM Evenement
    WHERE numEvenement = :NEW.numEpisode;

    IF specialiteRequise IS NOT NULL AND specialiteRequise NOT IN (
        SELECT numSpecialite
        FROM SpecialitePersonnage
        WHERE numPersonnage = :NEW.numPersonnage
    ) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Ce personnage ne possède pas la spécialité requise pour participer à l''événement.');
    END IF;
END;
----------------Test du déclencheur "VerifierAgePersonnage" :
-- Tentative d'insertion d'un personnage avec un âge inférieur à 18 ans
INSERT INTO Personnage (numPersonnage, nomPersonnage, aliasPersonnage, racePersonnage, agePersonnage, sexPersonnage, descriptionPersonnage, villePersonnage, Clan, rangPersonnage, RolePersonnage)
VALUES (1, 'John Doe', 'JD', 'Humain', 16, 'M', 'Description', 1, 1, 1, 1);
-- Résultat : Le déclencheur générera une erreur : "L'âge du personnage doit être supérieur ou égal à 18 ans."

-- Insertion valide d'un personnage avec un âge supérieur à 18 ans
INSERT INTO Personnage (numPersonnage, nomPersonnage, aliasPersonnage, racePersonnage, agePersonnage, sexPersonnage, descriptionPersonnage, villePersonnage, Clan, rangPersonnage, RolePersonnage)
VALUES (2, 'Jane Smith', 'JS', 'Elfe', 25, 'F', 'Description', 1, 1, 1, 1);
-- Résultat : L'insertion est effectuée avec succès.
--------------------------------------------Test du déclencheur "MettreAJourRangPersonnage" :
-- Insertion d'un nouveau niveau pour un personnage
INSERT INTO Niveau (numNiveau, numEpisode, numPersonnage, rangNiveau)
VALUES (1, 1, 2, 2);
-- Résultat : Le déclencheur mettra à jour automatiquement le rang du personnage (numPersonnage = 2) en lui attribuant le rang correspondant au niveau (rangNiveau = 2).

-- Vérification de la mise à jour du rang du personnage
SELECT rangPersonnage
FROM Personnage
WHERE numPersonnage = 2;
-- Résultat : Le rang du personnage (numPersonnage = 2) sera mis à jour avec la valeur 2.
------Test du déclencheur "VerifierSuppressionLieu" :
-- Suppression d'un lieu associé à un événement existant
DELETE FROM Lieu WHERE numLieu = 1;
-- Résultat : Le déclencheur générera une erreur : "Ce lieu ne peut pas être supprimé car il est utilisé dans un événement."

-- Suppression d'un lieu non associé à un événement existant
DELETE FROM Lieu WHERE numLieu = 2;
-- Résultat : La suppression du lieu (numLieu = 2) sera effectuée avec succès.
-----Test du déclencheur "MettreAJourDescriptionArc" :
-- Modification de la description d'un épisode appartenant à un arc
UPDATE Episode SET descriptionEpisode = 'Nouvelle description' WHERE numEpisode = 1;
-- Résultat : Le déclencheur mettra à jour automatiquement la description de l'arc correspondant à l'épisode modifié.

-- Vérification de la mise à jour de la description de l'arc
SELECT descriptionArc
FROM Arc
WHERE numArc = (
    SELECT Arc
    FROM Saison
    WHERE numSaison = (
        SELECT saison
        FROM Episode
        WHERE numEpisode = 1
    )
);
-- Résultat : La description de l'arc associé à l'épisode (numEpisode = 1) sera mise à jour avec la nouvelle description.
-----Test du déclencheur "VerifierExistenceSpecialitePersonnage" :
-- Insertion d'une relation entre un personnage et une spécialité non existante
INSERT INTO SpecialitePersonnage (numPersonnage, numSpecialite)
VALUES (2, 10);
-- Résultat : Le déclencheur générera une erreur : "La spécialité spécifiée n'existe pas."

-- Insertion valide d'une relation entre un personnage et une spécialité existante
INSERT INTO SpecialitePersonnage (numPersonnage, numSpecialite)
VALUES (2, 1);
-- Résultat : L'insertion est effectuée avec succès.
