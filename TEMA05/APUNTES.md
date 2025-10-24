# Tema 5: Manejo de Conectores II (Bases de Datos Embebidas e Independientes)

---

## 1️⃣ Introducción
En esta unidad aprenderás a **diferenciar los tipos de sistemas de gestión de bases de datos (SGBD)** y a **configurar una base de datos embebida** dentro de una aplicación Java, especialmente con el framework **Spring Boot**.

📘 **Objetivos del tema:**
- Conocer las diferencias entre bases de datos **en memoria**,  **embebidas** e **independientes**.  
- Identificar los principales **motores embebidos** (HyperSQL, Derby, H2...).  
- Aprender a **configurar una base de datos H2** usando `application.properties`.  
- Comprender cómo iniciar y gestionar una base embebida desde una aplicación Java/Spring Boot.

---

## 2️⃣ Gestores de Bases de Datos Embebidos e Independientes

### 🔹 Bases de datos en memoria
- Almacenan toda la información en la **memoria RAM**.  
- Son **volátiles**: los datos se pierden al cerrar la aplicación.  
- Útiles para pruebas rápidas o datos temporales.

### 🔹 Bases de datos embebidas
- El **motor de base de datos forma parte de la aplicación Java** (JVM).  
- Se accede a través de un **driver JDBC**.  
- Son ligeras, rápidas y fáciles de distribuir.  
- No requieren instalación externa.

### 🔹 Bases de datos independientes
- Son sistemas **cliente-servidor** (MySQL, PostgreSQL, Oracle…).  
- Se ejecutan en **una máquina separada**.  
- Ideales para aplicaciones grandes y con muchos usuarios.  
- Requieren más mantenimiento y recursos.

---

## 3️⃣ Gestores Embebidos más Usados

| Gestor | Características destacadas |
|---------|-----------------------------|
| **HyperSQL (HSQLDB)** | Compatible con SQL 2011 y JDBC 4. Puede funcionar en modo embebido o servidor. Muy estable y desarrollado en Java. |
| **ObjectDB** | Base de datos orientada a objetos compatible con JPA2. Ideal para trabajar sin capa ORM. |
| **Java DB / Apache Derby** | 100% Java, ligera, compatible con JDBC y fácil de incluir con su `derby.jar`. |
| **H2 Database** | Muy rápida, ligera (≈2MB), modo memoria o disco, soporta MVCC y es ideal para aplicaciones web. |


📺 [Vídeo 1: Spring boot database](https://bit.ly/392FJTM)  
---

## 4️⃣ Caso Práctico 1: “Embebida o Independiente”

**Planteamiento:**  
José debe crear un sistema de reservas con pocas filas por día.  

**Solución:**  
Usar una **base de datos embebida**, ya que:
- Es un sistema pequeño.  
- No requiere un servidor aparte.  
- Puede ejecutarse dentro de la misma JVM sin complicaciones.

✅ En este caso, una base de datos como **H2 o Derby** es perfecta.

---

## 5️⃣ Comparativa de Bases de Datos

| Característica | H2 | Derby | HyperSQL | MySQL | PostgreSQL |
|----------------|----|--------|-----------|--------|-------------|
| Java Puro | ✅ | ✅ | ✅ | ❌ | ❌ |
| Modo Memoria | ✅ | ✅ | ✅ | ❌ | ❌ |
| Encriptación | ✅ | ✅ | ✅ | ❌ | ❌ |
| Driver ODBC | ✅ | ❌ | ❌ | ✅ | ✅ |
| Búsqueda Texto Completo | ✅ | ❌ | ❌ | ✅ | ✅ |
| Espacio (embebido) | ~2 MB | ~3 MB | ~1.5 MB | — | — |

📊 **Conclusión:** H2 es una de las mejores opciones por su ligereza, velocidad y flexibilidad.

---

## 6️⃣ Base de Datos Embebida con Spring Boot

Spring Boot facilita enormemente el trabajo con bases de datos embebidas.  
Vamos a configurar una **base de datos H2 en memoria** paso a paso 👇

---

### 🧩 Paso 1: Crear el Proyecto
1. Entra en 👉 [https://start.spring.io](https://start.spring.io)  
2. Configura las siguientes opciones:
   - **Project:** Maven  
   - **Language:** Java  
   - **Spring Boot Version:** la más estable  
   - **Packaging:** `.jar`  
   - **Java:** 8 o superior  
3. Añade las dependencias:
   - `Spring Web`
   - `H2 Database`
4. Pulsa **“Generate”** para descargar el proyecto.

---

### 🧩 Paso 2: Dependencia H2 en `pom.xml`

Spring Boot añade automáticamente la dependencia:

```xml
<dependency>
   <groupId>com.h2database</groupId>
   <artifactId>h2</artifactId>
   <scope>runtime</scope>
</dependency>
```

---

### 🧩 Paso 3: Configuración en `application.properties`

Ubicación:  
📁 `src/main/resources/application.properties`

#### 🟢 Base de datos en memoria (por defecto)
```properties
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
```

👉 Esta configuración crea una base de datos **en memoria**, temporal mientras la app esté activa.

---

#### 🟠 Base de datos embebida en disco (persistente)
Si quieres que los datos **se guarden físicamente** en tu equipo, cambia la URL:

```properties
spring.datasource.url=jdbc:h2:file:~/data/demo
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.sql.init.mode=always
```

Esto creará un archivo físico en `~/data/demo.mv.db`.

---

#### 🔵 Habilitar la consola H2 (modo web)
```properties
spring.h2.console.enabled=true
```

Luego accedes en el navegador a:  
👉 [http://localhost:8080/h2-console](http://localhost:8080/h2-console)

Allí podrás ejecutar consultas SQL y ver las tablas en tiempo real.

---

### 🧩 Paso 4: Inicializar la Base de Datos

Crea el archivo 📄 `data.sql` en `src/main/resources/` con contenido inicial:

```sql
DROP TABLE IF EXISTS RESERVATION;

CREATE TABLE RESERVATION (
  id INT AUTO_INCREMENT PRIMARY KEY,
  reservation_date TIMESTAMP NULL DEFAULT NULL,
  name VARCHAR(250) NULL,
  status VARCHAR(25) NOT NULL DEFAULT 'FREE'
);
```

Cada vez que arranque la app, Spring Boot ejecutará este script automáticamente.

---

## 7️⃣ Caso Práctico 2: “Cambio de Credenciales”

**Planteamiento:**  
El acceso a la base H2 falla porque se cambió la contraseña del usuario.

**Solución:**  
Editar el archivo `application.properties` y actualizar las credenciales:

```properties
spring.datasource.username=user
spring.datasource.password=1234Pass
```

Al reiniciar la aplicación, la conexión volverá a funcionar correctamente.

---

## 8️⃣ Resumen del Tema

| Concepto | Descripción |
|-----------|-------------|
| **Base embebida** | Ejecuta dentro de la aplicación (H2, Derby, HSQLDB). |
| **Base independiente** | Requiere servidor externo (MySQL, PostgreSQL, Oracle...). |
| **Archivo `application.properties`** | Controla la configuración de conexión, almacenamiento y consola. |
| **H2** | Base embebida ideal: ligera, rápida y compatible con Spring Boot. |
| **Consola H2** | Se accede en [http://localhost:8080/h2-console](http://localhost:8080/h2-console). |

---

### 🔗 Webgrafía
- [Spring Initializr](https://start.spring.io/)  
- [Documentación oficial de H2 Database](https://www.h2database.com/html/main.html)  
- [Spring Boot Docs – H2 Console](https://docs.spring.io/spring-boot/docs/current/reference/html/howto.html#howto-h2-console)

---
