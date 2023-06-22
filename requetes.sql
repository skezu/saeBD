-- 4. Quelle classe de Monstre le héros Genos a-t-il combattu ?
SELECT R2.nomRang from Rang
INNER JOIN Rang R2 ON R2.numRang = R.numRang
INNER JOIN Personnage P1 ON P1.Personnage.numRang = R.numRang
INNER JOIN Personnage P2 ON P2.Personnage.numRang = R2.numRang
INNER JOIN rolerole R ON R.numrolerole = P2.numrolerole
INNER JOIN A_FAIT A ON P1.numPersonnage = A.numPersonnage
INNER JOIN A_FAIT A2 ON P2.numPersonnage = A2.numPersonnage
WHERE A.numEvenement=A2.numEvenement
AND P1.nomPersonnage = 'Genos'
AND P2.nomrolerole = 'Monstre';


-- 5. Quelle ville a sollicité le plus d’intervention de héros
Select numVille, nomVille, count(numEvenement) from Ville
INNER JOIN Lieu L ON L.numVille = Ville.numVille
INNER JOIN Evenement E ON E.numEvenement = L.numEvenement
INNER JOIN A_FAIT A ON A.numEvenement = E.numEvenement
INNER JOIN Personnage P ON P.numPersonnage = A.numPersonnage
INNER JOIN rolerole R ON R.numrolerole = P.numrolerole
WHERE R.nomrolerole = 'Héros'
GROUP BY numVille, nomVille
HAVING count(numEvenement) = (SELECT max(count(numEvenement)) from Ville
INNER JOIN Lieu L ON L.numVille = Ville.numVille
INNER JOIN Evenement E ON E.numEvenement = L.numEvenement
INNER JOIN A_FAIT A ON A.numEvenement = E.numEvenement
INNER JOIN Personnage P ON P.numPersonnage = A.numPersonnage
INNER JOIN rolerole R ON R.numrolerole = P.numrolerole
WHERE R.nomrolerole = 'Héros');

-- 6. Donner la liste nominative des amis de l'héro Saitama
SELECT nomPersonnage, AliasPersonnage
FROM Personnage P1
INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
INNER JOIN EST_EN_RELATION_AVEC R ON P1.numPersonnage = R.numPersonnage
INNER JOIN EST_EN_RELATION_AVEC R2 ON P2.numPersonnage = R2.numPersonnage
WHERE R.typeRelation='Ami' AND P2.nomPersonnage = 'Saitama';

-- 7. Donner la liste des monstres qui ont battu plus de 15 héros
SELECT P1.numPersonnage, P1.nomPersonnage, P1.AliasPersonnage, P2.numPersonnage
FROM Personnage P1
INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
INNER JOIN rolerole R ON R.numrolerole = P1.numrolerole
INNER JOIN rolerole R2 ON R2.numrolerole = P2.numrolerole
INNER JOIN A_FAIT AF ON P1.numPersonnage = AF.numPersonnage
INNER JOIN A_FAIT AF2 ON P2.numPersonnage = AF2.numPersonnage
WHERE R.nomrolerole = 'Monstre' AND R2.nomrolerole = 'Héros'
GROUP BY nomPersonnage, AliasPersonnage
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
    SELECT COUNT(*) INTO nbPersonnage FROM APPARAIT
    WHERE APPARAIT.numEpisode = numEpisode;
    RETURN nbPersonnage;
end;
-- 10. Donner les vainqueurs des différents combats à partir d’un épisode X avec leurs adversaires

-- 11. Donner la liste des amis de Saitama masculin
SELECT nomPersonnage, AliasPersonnage
FROM Personnage P1
 INNER JOIN Personnage P2 ON P1.numPersonnage = P2.numPersonnage
 INNER JOIN EST_EN_RELATION_AVEC R ON P1.numPersonnage = R.numPersonnage
 INNER JOIN EST_EN_RELATION_AVEC R2 ON P2.numPersonnage = R2.numPersonnage
WHERE R.typeRelation='Ami' AND P2.nomPersonnage = 'Saitama' AND P1.sexePersonnage = 'M';

-- 12. Donner la description de l’épisode précédent l’épisode X
CREATE OR REPLACE PROCEDURE descrPrec(numDeEpisode NUMBER) 
IS
    descr VARCHAR2(30);
BEGIN
    SELECT descriptionEpisode INTO descr
    FROM EPISODE
    WHERE numEpisode = numDeEpisode-1;

	DBMS_OUTPUT.PUT_LINE(descr);

END;