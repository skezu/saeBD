-- 4. Quelle classe de Monstre le héros Genos a-t-il combattu ?
SELECT R2.nomRang from Rang R
INNER JOIN Rang R2 ON R2.NUMRANG = R.numRang
INNER JOIN PERSONNAGE P1 ON P1.RANGPERSONNAGE = R.numRang
INNER JOIN Personnage P2 ON P2.RANGPERSONNAGE = R2.numRang
INNER JOIN ROLEROLE R ON R.NUMROLEROLE = P2.ROLEPERSONNAGE
INNER JOIN EVENEMENTPERSONNAGE A ON P1.numPersonnage = A.numPersonnage
INNER JOIN EVENEMENTPERSONNAGE A2 ON P2.numPersonnage = A2.numPersonnage
WHERE A.numEvenement=A2.numEvenement
AND P1.nomPersonnage = 'Genos'
AND P2.ROLEPERSONNAGE = 'Monstre';


-- 5. Quelle ville a sollicité le plus d’intervention de héros
Select numVille, nomVille, count(numEvenement) from Ville
INNER JOIN Lieu L ON L.VILLELIEU = Ville.numVille
INNER JOIN Evenement E ON E.LIEUEVENEMENT = L.NUMLIEU
INNER JOIN EVENEMENTPERSONNAGE A ON A.numEvenement = E.numEvenement
INNER JOIN Personnage P ON P.numPersonnage = A.numPersonnage
INNER JOIN ROLEROLE R ON R.NUMROLEROLE = P.ROLEPERSONNAGE
WHERE R.NOMROLEROLE = 'Héros'
GROUP BY numVille, nomVille
HAVING count(numEvenement) = (SELECT max(count(numEvenement)) from Ville
INNER JOIN Lieu L ON L.VILLELIEU = Ville.numVille
INNER JOIN Evenement E ON E.LIEUEVENEMENT = L.NUMLIEU
INNER JOIN EVENEMENTPERSONNAGE A ON A.numEvenement = E.numEvenement
INNER JOIN Personnage P ON P.numPersonnage = A.numPersonnage
INNER JOIN ROLEROLE R ON R.numRoleRole = P.ROLEPERSONNAGE
WHERE R.NOMROLEROLE = 'Héros');

-- 6. Donner la liste nominative des amis de l'héro Saitama
SELECT nomPersonnage, AliasPersonnage
FROM Personnage P1
INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
INNER JOIN RELATION R ON P1.numPersonnage = R.numPersonnage
INNER JOIN RELATION R2 ON P2.numPersonnage = R2.numPersonnage
WHERE R.typeRelation='Ami' AND P2.nomPersonnage = 'Saitama';

-- 7. Donner la liste des monstres qui ont battu plus de 15 héros
SELECT P1.NUMPERSONNAGE, P1.nomPersonnage, P1.AliasPersonnage, P2.numPersonnage
FROM Personnage P1
INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
INNER JOIN RoleRole R ON R.numRoleRole = P1.ROLEPERSONNAGE
INNER JOIN RoleRole R2 ON R2.NUMROLEROLE = P2.ROLEPERSONNAGE
INNER JOIN EVENEMENTPERSONNAGE AF ON P1.numPersonnage = AF.numPersonnage
INNER JOIN EVENEMENTPERSONNAGE AF2 ON P2.numPersonnage = AF2.numPersonnage
WHERE R.nomRoleRole = 'Monstre' AND R2.nomRoleRole = 'Héros'
GROUP BY numpersonnage, nomPersonnage, AliasPersonnage
HAVING count(P1.numPersonnage)>=15;

-- 8. Donner la liste des combats d’un épisode X
CREATE OR REPLACE FUNCTION nbCombatParEpisode(numEpisode INT) RETURN INTEGER IS
nbCombat INTEGER;
BEGIN
    SELECT COUNT(*) INTO nbCombat FROM EVENEMENT E
    NATURAL JOIN EPISODE
    WHERE E.descriptionEvenement LIKE '%Combat%' AND E.numEvenement = numEpisode;

    RETURN nbCombat;
end;
-- 9. Donner la liste des protagonistes d’un épisode X
CREATE OR REPLACE FUNCTION nbPersonnageParEpisode(numEpisode INT) RETURN INTEGER IS
nbPersonnage INTEGER;
BEGIN
    SELECT COUNT(*) INTO nbPersonnage FROM EPISODEPERSONNAGE
    WHERE EPISODEPERSONNAGE.numEpisode = numEpisode;
    RETURN nbPersonnage;
end;
-- 10. Donner les vainqueurs des différents combats à partir d’un épisode X avec leurs adversaires

-- 11. Donner la liste des amis de Saitama masculin
SELECT nomPersonnage, AliasPersonnage
FROM Personnage P1
 INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
 INNER JOIN RELATION R ON P1.numPersonnage = R.numPersonnage
 INNER JOIN RELATION R2 ON P2.numPersonnage = R2.numPersonnage
WHERE R.typeRelation='Ami' AND P2.nomPersonnage = 'Saitama' AND P1.SEXPERSONNAGE = 'M';

-- 12. Donner la description de l’épisode précédent l’épisode X
CREATE OR REPLACE PROCEDURE descrPrec1(numDeEpisode NUMBER) 
IS
    descr VARCHAR2(60);
BEGIN
    SELECT descriptionEpisode INTO descr
    FROM EPISODE
    WHERE numEpisode = numDeEpisode-1;

	DBMS_OUTPUT.PUT_LINE(descr);

END;

-- triggers
CREATE OR REPLACE TRIGGER VerifierAgePersonnage
    BEFORE INSERT ON Personnage
    FOR EACH ROW
BEGIN
    IF :NEW.agePersonnage < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'L''âge du personnage doit être supérieur ou égal à 18 ans.');
    END IF;
END;
/

-- 13. Donner le nombre d’épisodes de la saison X
CREATE OR REPLACE PROCEDURE nbEpisode(numDeSaison NUMBER)
IS
    nbEpisode NUMBER;
BEGIN
    SELECT COUNT(numEpisode) INTO nbEpisode
    FROM saison S
    INNER JOIN Episode e ON e.saison = s.numSaison
    WHERE numSaison = numDeSaison;

    DBMS_OUTPUT.PUT_LINE(nbEpisode);

END;