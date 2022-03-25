-- 1. __Birthyear__
-- Buscá todas las películas filmadas en el año que naciste.
SELECT name FROM movies where year = 1999;

-- 2. __1982__
-- Cuantas películas hay en la DB que sean del año 1982?
SELECT count(name) FROM movies where year = 1982;

-- 3. __Stacktors__
-- Buscá actores que tengan el substring `stack` en su apellido.
SELECT * FROM actors WHERE last_name LIKE "%stack%";

-- 4. __Fame Name Game__
-- Buscá los 10 nombres y apellidos más populares entre los actores. Cuantos actores tienen cada uno de esos nombres y apellidos?
SELECT first_name, last_name, COUNT(*) AS total
FROM actors
GROUP BY LOWER(first_name), LOWER(last_name)
ORDER BY total DESC
LIMIT 10;

-- > Esta consulta puede involucrar múltiples queries.

-- 5. __Prolific__
-- Listá el top 100 de actores más activos junto con el número de roles que haya realizado.
SELECT  actors.first_name, actors.last_name, COUNT(*) AS total_roles
FROM actors
JOIN roles ON actors.id = roles.actor_id
GROUP BY actors.id
ORDER BY total_roles DESC
LIMIT 100;

-- 6. __Bottom of the Barrel__
-- Cuantas películas tiene IMDB por género? Ordená la lista por el género menos popular
SELECT genre, COUNT(*)
FROM movies_genres
GROUP BY genre
ORDER BY COUNT(*) ASC

-- 7. __Braveheart__
-- Listá el nombre y apellido de todos los actores que trabajaron en la película "Braveheart" de 1995, ordená la lista alfabéticamente por apellido.
SELECT actors.first_name, actors.last_name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
WHERE movies.name = 'Braveheart' AND movies.year = 1995
ORDER BY actors.last_name ASC;

-- 8. __Leap Noir__
-- Listá todos los directores que dirigieron una película de género 'Film-Noir' en un año bisiesto (para reducir la complejidad, asumí que cualquier año divisible por cuatro es bisiesto). Tu consulta debería devolver el nombre del director, el nombre de la peli y el año. Todo ordenado por el nombre de la película.
SELECT directors.first_name, directors.last_name, movies.name, movies.year
FROM directors
JOIN movies_directors ON directors.id = movies_directors.director_id
JOIN movies ON movies.id = movies_directors.director_id
JOIN movies_genres ON movies.id = movies_genres.movie_id
WHERE movies_genres.genre = 'Film-Noir' AND movies.year % 4 = 0
ORDER BY movies.name ASC;

-- 9. __° Bacon__
-- Listá todos los actores que hayan trabajado con _Kevin Bacon_ en películas de Drama (incluí el título de la peli). Excluí al señor Bacon de los resultados.
SELECT actors .first_name, actors.last_name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
JOIN movies_genres ON movies_genres.movie_id = movies.id
WHERE movies_genres.genre = 'Drama' AND movies.id IN (
	SELECT movies.id
	FROM movies
	JOIN roles ON movies.id = roles.movie_id
	JOIN actors ON actors.id = roles.actor_id
	WHERE actors.first_name = 'Kevin' AND actors.last_name != 'Bacon'
) AND (actors.first_name != 'Kevin' AND actors.last_name != 'Bacon')
ORDER BY actors.first_name;
-- ## Índices

-- En el shell de sqlite, si usas el comando `.schema` en la tabla `actors` vas a ver que en la creación de la tabla se incluyeron:

-- ```
-- CREATE INDEX "actors_idx_first_name" ON "actors" ("first_name");
-- CREATE INDEX "actors_idx_last_name" ON "actors" ("last_name");
-- ```
-- 10. __Immortal Actors__
-- Qué actores actuaron en una película antes de 1900 y también en una película después del 2000?
SELECT *
FROM actors
WHERE id IN (
    SELECT roles.actor_id
    FROM roles
    JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year < 1900
) AND id IN (
    SELECT roles
    JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year > 2000
);



-- 11. __Busy Filming__
-- Buscá actores que actuaron en cinco o más roles en la misma película después del año 1990. Noten que los ROLES pueden tener duplicados ocasionales, sobre los cuales no estamos interesados: queremos actores que hayan tenido cinco o más roles DISTINTOS (DISTINCT cough cough) en la misma película. Escribí un query que retorne los nombres del actor, el título de la película y el número de roles (siempre debería ser > 5).
SELECT actors.first_name, actors.last_name, movies.name, COUNT(DISTINCT role) as total_roles
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON movies.id = roles.movie_id
WHERE movies.year > 1990
GROUP BY actors.id, movies.id
HAVING total_roles > 5;

-- 12. __♀__
-- Para cada año, contá el número de películas en ese años que _sólo_ tuvieron actrices femeninas.
SELECT year, movies.name, COUNT(DISTINCT id) as total_movies
FROM movies
WHERE idd NOT IN(
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.gender = 'M'
)
GROUP BY year
ORDER BY year DESC;


-- TIP: Podrías necesitar sub-queries. Lee más sobre sub-queries [acá](http://www.tutorialspoint.com/sqlite/sqlite_sub_queries.htm).