USE universidad;

/*Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.*/
SELECT apellido1, apellido2, nombre FROM universidad.persona
WHERE persona.tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

/*Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.*/
SELECT nombre, apellido1, apellido2 FROM universidad.persona
WHERE persona.tipo = 'alumno'
AND telefono IS NULL;

/*Retorna el llistat dels alumnes que van néixer en 1999.*/
SELECT * FROM universidad.persona
WHERE persona.tipo = 'alumno'
AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

/*Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.*/
SELECT * FROM universidad.persona
WHERE persona.tipo = 'profesor'
AND telefono IS NULL
AND persona.nif LIKE '%K'; 

/*Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.*/
SELECT * FROM universidad.asignatura
INNER JOIN universidad.grado ON grado.id = asignatura.id_grado
WHERE cuatrimestre = 1
AND curso = 3
AND grado.id = 7;

/*Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM universidad.persona
INNER JOIN universidad.profesor ON profesor.id_profesor = persona.id
INNER JOIN universidad.departamento ON profesor.id_departamento = departamento.id
ORDER BY persona.apellido1, persona.apellido2, persona.nombre;

/*Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.*/
SELECT universidad.asignatura.nombre, universidad.curso_escolar.anyo_inicio, universidad.curso_escolar.anyo_fin FROM universidad.asignatura
INNER JOIN universidad.alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
INNER JOIN universidad.persona ON alumno_se_matricula_asignatura.id_alumno = persona.id 
INNER JOIN universidad.curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
WHERE persona.nif = '26902806M';

/*Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).*/
SELECT DISTINCT universidad.departamento.nombre FROM universidad.departamento
INNER JOIN universidad.profesor ON profesor.id_departamento = departamento.id
INNER JOIN universidad.asignatura ON asignatura.id_profesor = profesor.id_profesor
INNER JOIN universidad.grado ON grado.id = asignatura.id_grado
WHERE universidad.grado.id = 4;

/*Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.*/
SELECT DISTINCT persona.* FROM universidad.persona
INNER JOIN universidad.alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
INNER JOIN universidad.curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
WHERE persona.tipo = 'Alumno'
AND curso_escolar.id = 5;

/*Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
SELECT universidad.departamento.nombre, universidad.persona.apellido1, universidad.persona.apellido2, universidad.persona.nombre FROM universidad.departamento
RIGHT JOIN universidad.persona ON persona.id = departamento.id
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre; 

/*Retorna un llistat amb els professors/es que no estan associats a un departament.*/
SELECT * FROM universidad.persona
LEFT JOIN universidad.departamento ON departamento.id = persona.id
WHERE departamento.nombre IS NULL;

/*Retorna un llistat amb els departaments que no tenen professors/es associats.*/
SELECT * FROM universidad.departamento
LEFT JOIN universidad.profesor ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

/*Retorna un llistat amb els professors/es que no imparteixen cap assignatura.*/
SELECT DISTINCT * FROM universidad.persona
INNER JOIN universidad.profesor ON profesor.id_profesor = persona.id
LEFT JOIN universidad.asignatura ON asignatura.id_profesor = profesor.id_profesor
WHERE asignatura.nombre IS NULL;

/*Retorna un llistat amb les assignatures que no tenen un professor/a assignat.*/
SELECT * FROM universidad.asignatura
WHERE asignatura.id_profesor IS NULL;

/*Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.*/
SELECT * FROM universidad.departamento
LEFT JOIN universidad.profesor ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

/*Retorna el nombre total d'alumnes que hi ha.*/
SELECT COUNT(universidad.persona.id) FROM universidad.persona
WHERE persona.tipo = 'alumno';

/*Calcula quants alumnes van néixer en 1999.*/
SELECT COUNT(universidad.persona.id) FROM universidad.persona
WHERE persona.tipo = 'alumno' 
AND persona.fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

/*Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/
SELECT COUNT(universidad.persona.id) AS Numero, universidad.departamento.nombre FROM universidad.persona
INNER JOIN universidad.profesor ON profesor.id_profesor = persona.id
INNER JOIN universidad.departamento ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre;

/*Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.*/
SELECT COUNT(universidad.persona.id) AS Numero, universidad.departamento.nombre FROM universidad.persona
INNER JOIN universidad.profesor ON profesor.id_profesor = persona.id
RIGHT JOIN universidad.departamento ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre;

/*Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT COUNT(asignatura.id), universidad.grado.nombre FROM universidad.asignatura
RIGHT JOIN universidad.grado ON grado.id = asignatura.id_grado
GROUP BY universidad.grado.nombre
ORDER BY COUNT(asignatura.id) DESC;

/*Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.*/
SELECT universidad.grado.nombre, COUNT(asignatura.id) FROM universidad.grado
LEFT JOIN universidad.asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40 
ORDER BY COUNT(asignatura.id) DESC;

/*Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT SUM(asignatura.creditos), universidad.asignatura.tipo, universidad.grado.nombre FROM universidad.asignatura
INNER JOIN universidad.grado ON grado.id = asignatura.id_grado
GROUP BY universidad.grado.nombre, universidad.asignatura.tipo;

/*Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.*/
SELECT universidad.curso_escolar.anyo_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) FROM universidad.alumno_se_matricula_asignatura
INNER JOIN universidad.curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
GROUP BY curso_escolar.anyo_inicio  ;

/*Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
SELECT universidad.persona.id, universidad.persona.nombre, universidad.persona.apellido1, universidad.persona.apellido2, COUNT(DISTINCT asignatura.id) FROM universidad.asignatura 
RIGHT JOIN universidad.persona ON persona.id = asignatura.id_profesor
GROUP BY persona.id
ORDER BY COUNT(asignatura.id) DESC;

/*Retorna totes les dades de l'alumne/a més jove.*/
SELECT * FROM universidad.persona
WHERE universidad.persona.tipo = 'alumno'
ORDER BY persona.fecha_nacimiento DESC LIMIT 1;

/*Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.*/
SELECT universidad.persona.nombre, persona.apellido1, persona.apellido2, departamento.nombre AS departament, asignatura.nombre AS asignatura FROM universidad.persona
INNER JOIN universidad.profesor ON profesor.id_profesor = persona.id
INNER JOIN universidad.departamento ON departamento.id = profesor.id_departamento
LEFT JOIN universidad.asignatura ON asignatura.id_profesor = profesor.id_profesor
WHERE universidad.asignatura.nombre IS NULL;