-- Añadimos nueva columna para solucionar el default
ALTER TABLE Personas
ADD COLUMN HombreMujer integer NOT NULL DEFAULT 0;

SET SQL_SAFE_UPDATES = 0;
UPDATE Personas
SET HombreMujer = CASE
    WHEN Genero = 'H' THEN 1
    ELSE 0
END;

-- dropeamos la pk para añadir la nueva columna como parte de la pk
ALTER TABLE Personas
DROP PRIMARY KEY;
ALTER TABLE Personas
Add PRIMARY KEY (ID_Persona,HombreMujer);

-- Ver indices de la tabla para eliminar aquellos que no forman parte de las columnas de particon
SHOW INDEX FROM Personas;

-- dropeamos aquellos indices q no sean primary
ALTER TABLE Personas
DROP INDEX DNI;
ALTER TABLE Personas
DROP INDEX ID_Persona;

-- quitamos dependencias de claves foráneas
ALTER TABLE MatriculadosInteresados
DROP FOREIGN KEY FK_Personas;

-- creamos la particion
alter table Personas
PARTITION BY LIST(HombreMujer) (
    PARTITION p_Hombre VALUES IN (1),
    PARTITION p_Mujer VALUES IN (0) 
);

-- comprobamos la particion
select PARTITION_NAME,
	   PARTITION_METHOD,
       PARTITION_DESCRIPTION,
       TABLE_ROWS
FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA='PracABD'
AND TABLE_NAME='Personas';















