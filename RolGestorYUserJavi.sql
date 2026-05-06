Create role Gestor;
drop role Gestor;

-- Conceder privilegios LMD (SELECT, INSERT, UPDATE, DELETE) sobre todas las tablas de la BD
GRANT SELECT, INSERT, UPDATE, DELETE ON PracABD1.* TO Gestor WITH GRANT OPTION;

-- Permitir al rol gestor crear roles y usuarios en todo el sistema

GRANT CREATE USER ON *.* TO Gestor;  -- create user incluye create role

-- Permitir asignar al rol gestor roles a los usuarios que crea
Grant ROLE_ADMIN ON *.* TO Gestor;

-- Crear el usuario javier con contraseña segura
CREATE USER 'javier' IDENTIFIED BY '1234';
drop user 'javier';

-- Entrego el rol a javi
GRANT Gestor TO 'javier';

-- Activa el usuario con el rol
SET DEFAULT ROLE Gestor TO 'javier';

-- nos conecatamos como javier y continuamos con las siguientes sentencias

-- Creación role secretario y asignación del rol a usuarios
CREATE ROLE Secretario;
Drop role Secretario;

GRANT SELECT ON PracABD1.* to Secretario;
GRANT INSERT ON PracABD1.Cursos to Secretario;
GRANT UPDATE (Estado) ON PracABD1.MatriculadosInteresados to Secretario;

CREATE USER 'Maribel' IDENTIFIED BY '1234';
CREATE USER 'Miriam' IDENTIFIED BY '1234';
Drop user 'Maribel';
Drop user 'Miriam';


GRANT Secretario TO 'Maribel';
GRANT Secretario TO 'Miriam';

SET DEFAULT ROLE Secretario TO 'Maribel';
SET DEFAULT ROLE Secretario TO 'Miriam';

-- Creación role comercial
CREATE ROLE Comercial;
Drop role Comercial; 

GRANT SELECT ON PracABD1.Personas TO Comercial;
GRANT SELECT ON PracABD1.Cursos TO Comercial;
GRANT SELECT ON PracABD1.MatriculadosInteresados TO Comercial;
GRANT INSERT, UPDATE ON PracABD1.Personas TO Comercial;
GRANT INSERT, UPDATE ON PracABD1.MatriculadosInteresados TO Comercial;

CREATE USER 'Paco' IDENTIFIED BY '1234';
CREATE USER 'Santiago' IDENTIFIED BY '1234';
Drop user 'Paco';
Drop user 'Santiago';

Grant Comercial to 'Paco';
Grant Comercial to 'Santiago';

SET DEFAULT ROLE Comercial TO 'Paco';
SET DEFAULT ROLE Comercial TO 'Santiago';

-- FALTAN APARTADOS 3 Y 4 PRIMERA PARTE
SHOW GRANTS FOR Secretario;
SHOW GRANTS FOR Comercial;
SHOW GRANTS FOR Gestor;
SHOW GRANTS FOR 'Miriam';
SHOW GRANTS FOR 'Maribel';
SHOW GRANTS FOR 'javier';
SHOW GRANTS FOR 'Santiago';
SHOW GRANTS FOR 'Paco';

-- sentencias secretario
-- permitida
SELECT ID_Curso,Nombre,Area FROM Cursos WHERE ID_Curso=1;
-- no permitida
INSERT INTO pracabd1.MatriculadosInteresados (ID_Persona,ID_Curso,Estado,Descripcion)
values(1,1,1,'ss');

-- sentencias comercial
-- permitidas
SELECT ID_Curso,Nombre,Area FROM Cursos WHERE ID_Curso=1;
-- no permitidas
INSERT INTO pracabd1.Cursos (ID_Curso,Nombre,Area,Edicion)
values(1,'1','1',2022);

-- sentencias gestor
-- permitidas
SELECT ID_Curso,Nombre,Area FROM Cursos WHERE ID_Curso=1;
-- no permitido
SHOW GRANTS FOR Secretario;


-- Como Gestor: Quitar puesto secretario y comercial a Miriam y Santiago respectivamente 
-- solo darles visualizar.
Revoke Secretario from 'Miriam';
Revoke Comercial from 'Santiago';
Grant select on PracABD1.* to 'Miriam','Santiago';

-- Como root: Mostrar permisos de Santiago y Miriam tras el cambio
SHOW GRANTS FOR 'Santiago';
SHOW GRANTS FOR 'Miriam';

-- Este comando falla porque javier no puede ver permismos de otro usuarios
SHOW GRANTS FOR 'Paco';






