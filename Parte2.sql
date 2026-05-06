-- como root
CREATE or replace VIEW VistaPersonas (ID,DNI, Nombre ,Apellidos, Provincia, Telefono, Email)
AS SELECT ID_Persona, DNI, Nombre ,Apellido, Provincia, Teléfono, Email
FROM Personas;

-- creacion user suplente
create user 'Suplente' identified by '1234';
Grant select (ID, Nombre ,Apellidos, Provincia, Telefono, Email) on PracABD1.VistaPersonas to 'Suplente';
Grant insert on PracABD1.VistaPersonas to 'Suplente';

-- Como suplente: consultas del suplente 
SELECT Nombre,Apellidos FROM VistaPersonas ORDER BY Provincia;
SELECT COUNT(*) FROM VistaPersonas WHERE Provincia='Sevilla';
SELECT Email FROM VistaPersonas WHERE Provincia='Barcelona';

-- ejecutar la inserción como Suplente A4
INSERT INTO PracABD1.VistaPersonas(ID,DNI, Nombre ,Apellidos, Provincia, Telefono, Email)
VALUES (90000,'x','Ramon','Ramonez','Ramonia',1,'r@r.r');

select * from VistaPersonas where Nombre='Ramon' and Apellidos='Ramonez';

-- Comprobando si suplente puede acceder a las tablas de la BD
select Nombre from Personas;
select ID_Curso from Cursos;
select ID_Personas from MatriculadosInteresados;


-- Creacion Vista Cursos como root
CREATE or replace VIEW Cursos2020VB AS SELECT ID_Curso,Nombre,Area,Edicion FROM Cursos WHERE Edicion=2020;

-- Como suplente: Consultas
SELECT  ID_Curso,Nombre,Area FROM Cursos2020VB ORDER BY Area;
SELECT  ID_Curso,Nombre,Area FROM Cursos2020VB WHERE Area= 'Big Data';
SELECT  ID_Curso,Nombre,Area FROM Cursos2020VB WHERE Area= 'Realidad Virtual';

-- Otorgar permisos al suplente sobre la vista
GRANT SELECT(ID_Curso,Nombre,Area) ,INSERT ON Cursos2020VB TO Suplente;

-- Insertar sobre la vista
INSERT INTO PracABD1.Cursos2020VB(ID_Curso,Nombre,Area,Edicion)
VALUES (90000,'CursPrueba','BaseDeDatos',2020);

-- Comprobación
SELECT  ID_Curso,Nombre,Area FROM Cursos2020VB where ID_Curso=90000 and Nombre='CursPrueba';
