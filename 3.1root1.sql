-- parte 3.1 a)
-- sesión root1
-- objetivo interbloqueo con root2
-- root1 reserva una fila
Start transaction;
select * from Personas where ID_Persona=1 for update;
 -- después de que root2 reserve su fila, root1 intenta modificarla
 update Personas set CodPostal=28111 where ID_Persona=2;
 
 
 -- parte 3.1 b)
 -- lectura sucia por parte de root2
Start transaction;
update Cursos set Edicion=2015 where ID_Curso=1;

-- después de que root2 lea el dato sucio hago rollback
rollback;