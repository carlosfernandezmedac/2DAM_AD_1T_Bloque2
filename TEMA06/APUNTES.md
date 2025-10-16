**Tema 6: Manejo de Conectores III – Sentencias**

---

### 1️⃣ Introducción
En este tema se estudian las **sentencias SQL** que permiten definir, manipular y consultar datos en una base de datos.  
Además, se introduce el concepto de **transacciones** y el uso de la interfaz `Statement` en Java para ejecutar sentencias.

💡 **Objetivos del tema:**
- Aprender las principales **sentencias de definición y manipulación de datos**.  
- Conocer cómo realizar **consultas básicas con SELECT y WHERE**.  
- Comprender el funcionamiento de las **transacciones (COMMIT, ROLLBACK, SAVEPOINT)**.  
- Entender cómo ejecutar estas sentencias desde Java mediante la interfaz **Statement**.

---

### 2️⃣ Sentencias de Definición de Datos (DDL)

Estas sentencias sirven para **crear y modificar la estructura** de bases de datos y tablas.

| Comando | Descripción | Ejemplo |
|----------|--------------|----------|
| **CREATE DATABASE** | Crea una nueva base de datos. | `CREATE DATABASE EmpresaDB;` |
| **ALTER DATABASE** | Modifica características de la base de datos. | `ALTER DATABASE EmpresaDB CHARACTER SET utf8mb4;` |
| **CREATE TABLE** | Crea una nueva tabla con sus campos. | `CREATE TABLE Clientes (id INT PRIMARY KEY, nombre VARCHAR(50));` |
| **ALTER TABLE** | Modifica una tabla existente (añadir/eliminar columnas, índices…). | `ALTER TABLE Clientes ADD COLUMN edad INT;` |
| **DROP TABLE** | Elimina una o varias tablas permanentemente. | `DROP TABLE Clientes;` |
| **RENAME TABLE** | Cambia el nombre de una tabla. | `RENAME TABLE Clientes TO ClientesAntiguos;` |

⚠️ Estas operaciones requieren **permisos de administrador** y son **irreversibles**.

---

### 3️⃣ Sentencias de Manipulación de Datos (DML)

Se usan para **insertar, actualizar o borrar registros** dentro de las tablas.

| Comando | Función | Ejemplo |
|----------|----------|----------|
| **INSERT** | Inserta nuevos registros. | `INSERT INTO Clientes (nombre, ciudad) VALUES ('Lucía', 'Madrid');` |
| **UPDATE** | Modifica registros existentes. | `UPDATE Clientes SET ciudad='Sevilla' WHERE id=1;` |
| **DELETE** | Elimina registros según una condición. | `DELETE FROM Clientes WHERE ciudad='Madrid';` |
| **REPLACE** | Inserta o actualiza registros con clave primaria duplicada. | `REPLACE INTO Clientes (id, nombre) VALUES (1, 'Ana');` |
| **TRUNCATE** | Vacía completamente una tabla. | `TRUNCATE TABLE Clientes;` |

---

### 4️⃣ Sentencias de Consulta (SELECT)

Permiten **leer y filtrar datos** de una o más tablas.

```sql
SELECT columna1, columna2
FROM tabla
WHERE condición
ORDER BY columna ASC|DESC;
```

#### Cláusulas más usadas:
- **WHERE** → Filtra resultados (`WHERE edad > 30;`).  
- **LIKE** → Búsquedas parciales (`WHERE nombre LIKE 'A%';`).  
- **BETWEEN** → Rango de valores (`WHERE edad BETWEEN 20 AND 40;`).  
- **IN** → Valores específicos (`WHERE ciudad IN ('Madrid','Sevilla');`).  
- **ORDER BY** → Ordena resultados (`ORDER BY nombre DESC;`).  
- **DISTINCT** → Evita duplicados (`SELECT DISTINCT ciudad FROM Clientes;`).

📘 **Ejemplo completo:**
```sql
SELECT nombre, edad, ciudad
FROM Clientes
WHERE edad > 40
ORDER BY nombre ASC;
```

---

### 5️⃣ Gestión de Transacciones

Una **transacción** es un conjunto de operaciones SQL que se ejecutan como una unidad indivisible.

**Objetivos:**
- Mantener la **consistencia** de la base de datos.  
- Permitir **deshacer cambios** en caso de error.  

#### Comandos principales:
| Comando | Descripción |
|----------|-------------|
| **COMMIT** | Guarda los cambios definitivamente. |
| **ROLLBACK** | Revierte los cambios desde el último COMMIT. |
| **SAVEPOINT** | Crea un punto de guardado para volver atrás parcialmente. |

🧩 *Ejemplo:*
```sql
START TRANSACTION;
UPDATE Clientes SET ciudad='Málaga' WHERE id=5;
DELETE FROM Pedidos WHERE idCliente=5;
ROLLBACK; -- Deshace ambas operaciones
```

---

### 6️⃣ Interfaz `Statement` (Java)

La clase `Statement` ejecuta las sentencias SQL en una aplicación Java.

```java
Statement st = conexion.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM Clientes");
while (rs.next()) {
  System.out.println(rs.getString("nombre"));
}
```

- **executeQuery(String sql)** → Ejecuta `SELECT` y devuelve un `ResultSet`.  
- **executeUpdate(String sql)** → Ejecuta `INSERT`, `UPDATE` o `DELETE`.  
- **execute(String sql)** → Ejecuta cualquier tipo de sentencia.

---

### 7️⃣ Casos prácticos

#### 🧩 Caso 1: Insertando datos
```sql
INSERT INTO CUSTOMER (First_Name, Last_Name, Age, City)
VALUES ('Juan', 'López', 20, 'Málaga');
```

#### 🧩 Caso 2: Consultando clientes mayores de 40 años
```sql
SELECT * FROM CUSTOMER
WHERE Age > 40
ORDER BY First_Name ASC;
```

---

### 8️⃣ Resumen del tema

✅ Aprendimos a:
- Definir estructuras con **DDL** (`CREATE`, `ALTER`, `DROP`).  
- Manipular registros con **DML** (`INSERT`, `UPDATE`, `DELETE`).  
- Consultar información con **SELECT** y sus cláusulas.  
- Controlar transacciones con **COMMIT** y **ROLLBACK**.  
- Ejecutar comandos SQL desde Java con la interfaz `Statement`.

---

### 🔗 Webgrafía
- [Oracle SQL Reference](https://docs.oracle.com/cd/E11882_01/server.112/e41084/toc.htm)  
- [Manual MySQL – Definición de datos](https://manuales.guebs.com/mysql-5.0/sql-syntax.html#data-definition)



