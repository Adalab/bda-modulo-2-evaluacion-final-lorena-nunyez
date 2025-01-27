
-- ===================================
-- EJERCICIO TÉCNICO MÓDULO 2
-- ===================================

/* Se han utilizado:
	BASE DE DATOS: 
		USE sakila;
	TABLAS:
		SELECT * FROM film;
		SELECT * FROM film_actor;
		SELECT * FROM actor;
        SELECT * FROM customer;
		SELECT * FROM rental;
		SELECT * FROM category;
*/

USE sakila;

-- 🔘  01. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- ---------------------------------------------------------------------------------------------------------------------
-- DISTINCT elimina los registros repetidos.
SELECT DISTINCT
    title
FROM
    film;


-- 🔘  02. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- ---------------------------------------------------------------------------------------------------------------------
-- Se incluye 'rating' para verificar que la calificación es correcta.
SELECT 
    title, rating
FROM
    film
WHERE
    rating = 'PG-13';


-- 🔘  03. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se utiliza LIKE con comodines '%' para buscar coincidencias parciales.
SELECT 
    title, description
FROM
    film
WHERE
    description LIKE '%amazing%';


-- 🔘  04. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se incluye 'length' para verificar los resultados.
SELECT 
    title, length
FROM
    film
WHERE
    length > 120;


-- 🔘  05. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame
-- --- nombre_actor y contenga nombre y apellido.
-- ---------------------------------------------------------------------------------------------------------------------
-- CONCAT combina 'first_name' y 'last_name' en una columna.
SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_actor
FROM
    actor; 

-- 🔘  06. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se utiliza LIKE con comodines '%' para buscar coincidencias parciales.
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    last_name LIKE '%Gibson%'; 


-- 🔘  07. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- ---------------------------------------------------------------------------------------------------------------------
-- BETWEEN incluye los valores desde 10 hasta 20.
SELECT 
    first_name, actor_id
FROM
    actor
WHERE
    actor_id BETWEEN 10 AND 20;


-- 🔘  08. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".
-- ---------------------------------------------------------------------------------------------------------------------
-- NOT IN excluye las clasificaciones 'PG-13' Y 'R'.
SELECT 
    title
FROM
    film
WHERE
    rating NOT IN ('PG-13' , 'R');


-- 🔘  09. Encuentra la cantidad total de películas en cada clasificación(rating) de la tabla film y muestra la
-- --- clasificación junto con el recuento.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se usa GROUP BY para agrupar por 'rating' y COUNT para contar cuántas películas hay en cada grupo.
SELECT 
    rating, COUNT(rating) AS total_peliculas
FROM
    film
GROUP BY rating;


-- 🔘  10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
-- --- nombre y apellido junto con la cantidad de películas alquiladas.
-- ---------------------------------------------------------------------------------------------------------------------
-- JOIN conecta las tablas customer y rental, y GROUP BY agrupa por cliente.
-- COUNT para contar la cantidad de alquileres de cada cliente.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_peliculas
FROM
    customer c
        JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id , c.first_name , c.last_name;


-- 🔘  11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la
-- --- categoría junto con el recuento de alquileres.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se usa una correlación de uniones entre tablas hasta llegar al recuento de alquileres por categoría.
SELECT 
    c.name AS categorias,
    COUNT(r.rental_id) AS numero_alquileres
FROM
    category c
        INNER JOIN
    film_category fc ON c.category_id = fc.category_id
        INNER JOIN
    inventory i ON i.film_id = fc.film_id
        INNER JOIN
    rental r ON r.inventory_id = i.inventory_id
GROUP BY categorias;


-- 🔘  12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- --- muestra la clasificación junto con el promedio de duración.
-- ---------------------------------------------------------------------------------------------------------------------
-- AVG calcula el promedio.
SELECT 
    rating AS clasificacion, 
    AVG(length) AS promedio_duracion
FROM
    film
GROUP BY rating
ORDER BY promedio_duracion;


-- 🔘  13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- ---------------------------------------------------------------------------------------------------------------------
-- JOIN conecta las tablas 'actor', 'film_actor' y 'film' hasta llegar a la correlación titulo de la pelicula y actores relaconados.
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


-- 🔘  14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se usa LIKE y REGEXP para ofrecer dos alternativas de solución.
SELECT 
    title AS titulo_pelicula
FROM
    film
WHERE
    description LIKE '%dog%'
	OR description LIKE '%cat%';

-- otra forma de solucionarlo y también para verificar:
SELECT 
    title AS titulo_pelicula, description AS descripcion_dog_cat
FROM
    film
WHERE
    description REGEXP 'dog|cat';


-- 🔘  15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
-- ---------------------------------------------------------------------------------------------------------------------
-- LEFT JOIN asegura que todos los actores estén incluidos, incluso si no tienen películas.
-- La condición 'fa.film_id IS NULL' identifica actores sin películas.
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


-- 🔘  16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se incluye 'release_year' para verificar los resultados.
SELECT 
    title, release_year
FROM
    film
WHERE
    release_year BETWEEN 2005 AND 2010;
 
    
-- 🔘  17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- ---------------------------------------------------------------------------------------------------------------------
-- Se utilizado un INNER JOIN para hacer una combinación category, film_category. Con el filtro WHERE, se muestran solo
-- las que pertenecen a la categoría 'Family'.
SELECT 
    c.name AS categoria, f.title AS titulo_pelicula
FROM
    category c
        INNER JOIN
    film_category fc ON c.category_id = fc.category_id
        INNER JOIN
    film f ON fc.film_id = f.film_id
WHERE
    c.name = 'Family';
    
    
-- 🔘  18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se realiza un INNER JOIN entre las tablas actor y film_actor para contar en cuántas películas ha actuado cada actor. 
-- Utilizamos COUNT para obtener solo los actores que han participado en más de 10 películas.
-- Utilizamos HAVING (en lugar de WHERE) actua sobre resultados procesados.
SELECT 
    a.first_name AS nombre_actor,
    a.last_name AS apellido_actor,
    COUNT(fa.film_id) AS numero_peliculas
FROM
    actor a
        INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id , a.first_name , a.last_name
HAVING COUNT(fa.film_id) > 10;


-- 🔘  19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
-- ---------------------------------------------------------------------------------------------------------------------
-- Se realiza una consulta simple, en la solo se tiene en cuenta 'rating' y la duración.
SELECT 
    title AS titulo_pelicula
FROM
    film
WHERE
    rating = 'R' AND length > 120;


-- 🔘  20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120
-- --- minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se hace una combinación (INNER JOIN) entre las tablas category, film_category y film para sacar el promedio.
SELECT 
    c.name AS categoria, 
    AVG(f.length) AS promedio_duracion
FROM
    category c
        INNER JOIN
    film_category fc ON c.category_id = fc.category_id
        INNER JOIN
    film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;


-- 🔘  21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor
-- --- junto con la cantidad de películas en las que han actuado.
-- ---------------------------------------------------------------------------------------------------------------------
-- COUNT, cuenta 
SELECT 
    a.first_name AS nombre_actor,
    COUNT(fa.film_id) numero_peliculas
FROM
    actor a
        INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY nombre_actor
HAVING numero_peliculas > 5;


-- 🔘  22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una
-- --- subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona
-- --- las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia entre una
-- --- fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)
-- ---------------------------------------------------------------------------------------------------------------------
-- El Left Join permite unir las tablas para relacionar colunnas y obtener el resultado.
-- Subconsultas con la función DATEDIFF (calcula la diferencia entre feechas de alquiler).
                    
SELECT 
    title
FROM
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE 
    DATEDIFF(r.return_date, r.rental_date) > 5
    AND r.rental_id IS NOT NULL;

 
-- 🔘  23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la
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
-- 🔘  24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180
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

-- 🔘  25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La
-- --- consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que
-- --- han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un
-- --- alias diferente.
-- ---------------------------------------------------------------------------------------------------------------------
-- Se utiliza un JOIN de la tabla film_actor consigo misma con un  alias para encontrar a los actores que han 
-- trabajado juntos en al menos una película.
SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor_1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor_2,
    COUNT(fa1.film_id) AS numero_peliculas_juntos
FROM
    film_actor fa1
        JOIN
    film_actor fa2 ON fa1.film_id = fa2.film_id
        JOIN
    actor a1 ON fa1.actor_id = a1.actor_id
        JOIN
    actor a2 ON fa2.actor_id = a2.actor_id
GROUP BY a1.actor_id , a1.first_name , a1.last_name , 
		 a2.actor_id , a2.first_name , a2.last_name;

------------------------------------------------------------------------------------------------------------------------