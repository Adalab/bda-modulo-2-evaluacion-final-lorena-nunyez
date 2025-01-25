/*
01. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
02. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
03. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en
su descripción.
04. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
05. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame
nombre_actor y contenga nombre y apellido.
06. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
07. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
08. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".
09. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento.
10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.
11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la
categoría junto con el recuento de alquileres.
12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.
13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120
minutos y muestra el nombre de la categoría junto con el promedio de duración.
21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor
junto con la cantidad de películas en las que han actuado.
22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona
las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia entre una
fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)
23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en
películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
tabla film.

BONUS
24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180
minutos en la tabla film con subconsultas.
25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La
consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que
han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un
alias diferente.
*/

-- ===================================
-- Base de datos utilizada: sakila
-- ===================================

USE sakila;

-- 01. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title
FROM film;

-- 02. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title, rating
FROM film
WHERE rating = 'PG-13';

select * from film

-- 03. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.



-- 04. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- 05. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame
-- ----nombre_actor y contenga nombre y apellido.











