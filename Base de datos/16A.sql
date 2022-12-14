/*
Reportes parte 1: 
1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
alias para mostrar los nombres de las columnas en español. 
2. Obtener un listado que incluya nombre, apellido y correo electrónico de los 
clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las 
columnas en español. 
3. Obtener un listado de films incluyendo título, año y descripción de los films 
que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de 
mayor a menor. Utilizar alias para mostrar los nombres de las columnas en 
español. 
4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
mayo de 2005, incluir en el resultado todas las columnas disponibles.
*/
-- 1
select first_name as 'Primer nombre', last_name as Apellido from actor
limit 5;

-- 2
select first_name as 'Primer nombre', last_name as Apellido, email from customer
where active=0;

-- 3
select title as Titulo, release_year as 'Año lanzamiento', description as Descripción from film
where rental_duration>5
order by rental_duration desc;

-- 4
select * from rental
where return_date like '%2005-05%'
order by return_date ASC;

/*
Reportes parte 2: Sumemos complejidad 
Si llegamos hasta acá, tenemos en claro la estructura básica de un SELECT. En los siguientes reportes vamos a sumar complejidad. 
¿Probamos? 
1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”. 
2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo en una columna llamada “total”, 
junto a una columna con la cantidad de alquileres con el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler. 
3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen? 
4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres.
5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), la cantidad de alquileres y la suma total pagada (amount de tabla payment) 
para el año de alquiler 2005 (rental_date de tabla rental). 
6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). 
Para cada una de ellas indicar la cantidad de alquileres. 
*/
-- 1
select count(*) as Cantidad from rental;
-- 2
select count(*) as Cantidad, avg(amount) as 'Importe promedio', sum(amount) as Total from payment;
-- 3
select customer_id, SUM(amount) as Venta, count(rental_id) as 'Cantidad de alquileres' from payment
group by customer_id
order by Venta DESC
limit 10;
-- 4
select customer_id, count(rental_id) as 'Cantidad de alquileres', SUM(amount) as Venta from payment
group by customer_id
having Venta>150
order by Venta Desc;
-- 5
select date_format(rental.rental_date, '%M') as Mes, count(*) as Cantidad, sum(payment.amount) as Total from rental
join payment ON rental.rental_id=payment.rental_id
where rental_date like '%2005%'
group by Mes;
-- 6
select inventory_id, count(*) as Cantidad from rental
group by inventory_id
order by Cantidad DESC
limit 5

