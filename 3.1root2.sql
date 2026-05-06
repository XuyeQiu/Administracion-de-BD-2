-- parte 3.1 a)
-- sesión root2
-- objetivo interbloqueo con root1
Start transaction;
select * from Personas where ID_Persona=2 for update;
 -- después de que root1 reserve su fila, root2 intenta modificarla
 update Personas set CodPostal=28111 where ID_Persona=1;
 
 
 -- parte 3.1 b)
 -- tras iniciar la transacción de root1 leemos el dato sucio, pero primero tengo que poner nivel de aislamiento q permite lectura sucia
 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 select Edicion from Cursos where ID_Curso=1;