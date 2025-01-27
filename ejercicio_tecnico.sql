/* EJERCICIOS
ACLARACIÓN:
clasificación es rating y categoría es el name de la tabla category.
*/

-- ===================================
-- Base de datos utilizada: sakila
-- ===================================

USE sakila;

-- 01. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT
    title
FROM
    film;

-- 02. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title, rating
FROM
    film
WHERE
    rating = 'PG-13'; -- donde X sea Y


-- 03. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title, description
FROM
    film
WHERE
    description LIKE '%amazing%'; -- donde X contenga Y

-- 04. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title, length
FROM
    film
WHERE length>120; -- 120 no incluidos

-- 05. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame
-- ----nombre_actor y contenga nombre y apellido.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_actor
FROM
    actor; 

-- 06. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    last_name LIKE '%Gibson%'; -- donde X contenga Y

-- 07. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    first_name, actor_id
FROM
    actor
WHERE
    actor_id BETWEEN 10 AND 20;

-- 08. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title
FROM
    film
WHERE
    rating NOT IN ('PG-13' , 'R');

-- 09. Encuentra la cantidad total de películas en cada clasificación(rating) de la tabla film y muestra la
-- --- clasificación junto con el recuento.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    rating, COUNT(rating) AS total_peliculas
FROM
    film
GROUP BY rating; -- primero marcamos pq queremos agrupar (rating) luego le pedimos que cuente cuantas hay de cada tipo.

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
-- --- nombre y apellido junto con la cantidad de películas alquiladas.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_peliculas
FROM
    customer c
	JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la
-- --- categoría junto con el recuento de alquileres.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    c.name AS categorias,
    COUNT(r.rental_id) AS numero_alquileres
FROM 
	category c
	INNER JOIN film_category fc 
    ON c.category_id = fc.category_id
	INNER JOIN inventory i 
    ON i.film_id = fc.film_id
	INNER JOIN rental r 
    ON r.inventory_id = i.inventory_id
GROUP BY categorias;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- --- muestra la clasificación junto con el promedio de duración.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    rating AS clasificacion, 
    AVG(length) AS promedio_duracion
FROM
    film
GROUP BY rating
ORDER BY promedio_duracion;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    a.first_name AS nombre_actor,
    a.last_name AS apellido_actor
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.title = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
title AS titulo_pelicula
FROM film
WHERE
	description LIKE '%dog%'
	OR description LIKE '%cat%';

-- para comprobar:
SELECT 
title AS titulo_pelicula,
description AS descripcion_dog_cat
FROM film
WHERE description REGEXP 'dog|cat';

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    a.actor_id AS id_actor,
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id IS NULL;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title
FROM
    film
WHERE
    release_year BETWEEN 2005 AND 2010;
    
    -- verificar
  SELECT 
    title, release_year
FROM
    film
WHERE
    release_year BETWEEN 2005 AND 2010;  
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    c.name AS categoria,
    f.title AS titulo_pelicula
FROM 
    category c
INNER JOIN 
    film_category fc 
    ON c.category_id = fc.category_id
INNER JOIN 
    film f 
    ON fc.film_id = f.film_id
WHERE 
    c.name = 'Family';
    
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    a.first_name AS nombre_actor,
    a.last_name AS apellido_actor,
    COUNT(fa.film_id) AS numero_peliculas
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id, a.first_name, a.last_name
HAVING 
    COUNT(fa.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title AS titulo_pelicula
FROM 
    film
WHERE 
    rating = 'R' 
    AND length > 120;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120
-- --- minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    c.name AS categoria,
    AVG(f.length) AS promedio_duracion
FROM 
    category c
INNER JOIN 
    film_category fc ON c.category_id = fc.category_id
INNER JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
HAVING 
    AVG(f.length) > 120;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor
-- --- junto con la cantidad de películas en las que han actuado.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    a.first_name AS nombre_actor,
    COUNT(fa.film_id) numero_peliculas
FROM
    actor a
        INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY nombre_actor
HAVING numero_peliculas > 5
ORDER BY nombre_actor DESC;

-- 22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una
-- --- subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona
-- --- las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia entre una
-- --- fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    title
FROM
    film
WHERE
    film_id NOT IN (SELECT 
            film_id
        FROM
            inventory
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    rental
                WHERE
                    DATEDIFF(return_date, rental_date) > 5));
 
-- --- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la
-- --- categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en
-- --- películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    a.first_name AS nombre, a.last_name AS apellidos
FROM
    actor a
WHERE
    a.actor_id NOT IN (SELECT 
            fa.actor_id
        FROM
            film_actor fa
        WHERE
            fa.film_id IN (SELECT 
                    fc.film_id
                FROM
                    film_category fc
                WHERE
                    fc.category_id IN (SELECT 
                            c.category_id
                        FROM
                            category c
                        WHERE
                            name = 'Horror')));


-- -----
-- 🎁 BONUS
-- -----
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180
-- --- minutos en la tabla film con subconsultas.
-- ---------------------------------------------------------------------------------------------------------------------
SELECT 
    f.title
FROM
    film f
WHERE
    length > 180
        AND f.film_id IN (SELECT 
            fc.film_id
        FROM
            film_category fc
        WHERE
            fc.category_id IN (SELECT 
                    c.category_id
                FROM
                    category c
                WHERE
                    name = 'comedy'));

-- 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La
-- --- consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que
-- --- han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un
-- --- alias diferente.
-- ---------------------------------------------------------------------------------------------------------------------


SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_actor;
SELECT * FROM film_category;


-- ✅ Verify results:
SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE DATEDIFF(return_date, rental_date) > 5)
        );








