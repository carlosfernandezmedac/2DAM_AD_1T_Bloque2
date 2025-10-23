-- 2. Creación de la base de datos (DDL)

drop database if exists tienda_db;
CREATE DATABASE IF NOT EXISTS tienda_db;
use tienda_db;

-- 3. Creación de las tablas

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  ciudad VARCHAR(50),
  edad INT
);

CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATE,
  id_cliente INT,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2)
);

CREATE TABLE detalle_pedido (
  id_pedido INT,
  id_producto INT,
  cantidad INT,
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- 4. Inserción de datos (DML)


INSERT INTO cliente (nombre, ciudad, edad) VALUES
('Ana López', 'Madrid', 30),
('Carlos Ruiz', 'Sevilla', 45),
('Lucía Gómez', 'Granada', 22);

INSERT INTO producto (nombre, precio) VALUES
('Portátil', 850.00),
('Ratón', 25.00),
('Teclado', 40.00);

INSERT INTO pedido (fecha, id_cliente) VALUES
('2024-01-10', 1),
('2024-01-11', 2);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES
(1, 1, 1),  -- Ana compra 1 portátil
(1, 2, 2),  -- Ana compra 2 ratones
(2, 3, 1);  -- Carlos compra 1 teclado

-- 5. Edición de datos (UPDATE / DELETE / REPLACE)

-- Cambiar la ciudad de Lucía
UPDATE cliente SET ciudad = 'Málaga' WHERE nombre = 'Lucía Gómez';


-- Mostrar todos los clientes
SELECT * FROM cliente;

-- Mostrar nombre y ciudad de clientes mayores de 25 años
SELECT nombre, ciudad FROM cliente WHERE edad > 25;

-- Mostrar pedidos con nombre del cliente
SELECT p.id_pedido, p.fecha, c.nombre
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;

-- Clientes cuyo nombre empieza por 'L'
SELECT * FROM cliente WHERE nombre LIKE 'L%';

-- Clientes entre 25 y 45 años ordenados alfabéticamente
SELECT * FROM cliente WHERE edad BETWEEN 25 AND 45 ORDER BY nombre ASC;

-- Productos con precio mayor a 30 €
SELECT nombre, precio FROM producto WHERE precio > 30 ORDER BY precio DESC;


-- Total gastado por cada cliente
SELECT c.nombre, SUM(pr.precio * d.cantidad) AS total_gastado
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido d ON p.id_pedido = d.id_pedido
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY c.nombre
ORDER BY total_gastado DESC;


-- 9.Transacciones (COMMIT / ROLLBACK / SAVEPOINT)
START TRANSACTION;

UPDATE producto SET precio = precio * 1.10; -- Subir precios 10%

SAVEPOINT antes_de_borrar;

DELETE FROM detalle_pedido WHERE cantidad < 2;

-- Algo sale mal... volvemos al punto anterior
ROLLBACK TO antes_de_borrar;

-- Finalmente confirmamos los cambios válidos
COMMIT;

select * from detalle_pedido;



/* ON UPDATE/DELETE CASCADE
Significa que si cambias el valor de la clave primaria en la tabla padre,
MySQL actualizará automáticamente ese valor en todas las tablas hijas que lo referencien.

Supongamos que quieres que, si cambia el id_cliente en la tabla cliente,
se actualicen automáticamente los registros relacionados en la tabla pedido.

Primero debes eliminar la restricción antigua y volver a crearla con ON UPDATE CASCADE*/

ALTER TABLE pedido
DROP FOREIGN KEY pedido_ibfk_1;  -- Elimina la FK anterior (nombre puede variar)

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
ON UPDATE CASCADE;


-- Mira cómo están ahora los datos:

SELECT * FROM cliente;
SELECT * FROM pedido;


-- Cambia el id_cliente de “Ana López” (por ejemplo, de 1 a 10):

UPDATE cliente SET id_cliente = 10 WHERE nombre = 'Ana López';


-- Verifica el resultado:

SELECT * FROM pedido;



