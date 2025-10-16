# Tema 4: Diseño Conceptual – Modelo Entidad/Relación

---

## 1. Introducción
El modelo **Entidad/Relación (E/R)** permite representar visualmente la realidad que queremos almacenar en una **base de datos**, identificando **entidades, atributos y relaciones** entre los datos.

**El modelo de datos actúa como un mapa, organizando la información que queremos almacenar.**

👉 Es la **fase de diseño conceptual**, donde se definen los elementos clave sin depender del SGBD.

![alt text](./img/er-intro.png)


## 2. El modelo de datos

### 2.1. Concepto
Un **modelo de datos** es un conjunto de herramientas conceptuales que permiten describir la información y su estructura. Nos ayuda a estructurar la realidad. Se compone de:
- **Estructura:** tipos de datos y relaciones.
- **Operaciones:** acciones que pueden realizarse.
- **Restricciones:** condiciones que aseguran la validez de los datos.

Para llevar a cabo la definición de la estructura, operaciones y restricciones, debemos hacer uso de dos de los

- **Lenguaje de Definición de Datos (DDL)**: Describe las estructuras de datos y las restricciones de integridad.
definiendo los elementos permitidos y cómo utilizarlos.
- **Lenguaje de Manipulación de Datos (DML)**: Describe las operaciones de manipulación de datos mediante expresiones y operadores.

![alt text](./img/modelo-esquema.png)

💡 **Diferencia clave:**
| Concepto | Definición |
|-----------|-------------|
| **Modelo de datos** | Herramienta conceptual para representar información. |
| **Esquema** | Aplicación del modelo de datos a un caso concreto. |

📘 Ejemplo:

**Modelo de datos**: Modelo E/R (entidades, relaciones, atributos).

**Esquema**: Entidades: Alumno, Profesor, Curso; Relaciones: Imparte, Matricula.

---

### 2.2. Tipos de modelos

| Tipo | Descripción | Ejemplo |
|------|--------------|---------|
| **Conceptual** | Representa la realidad sin depender del SGBD. | Modelo E/R |
| **Convencional (Lógico)** | Prepara los datos para implementarlos en un SGBD. | Modelo relacional |
| **Físico** | Define cómo se almacenan realmente los datos. | Archivos, índices |

---

## 3. Fases del diseño de una base de datos

1. **Análisis de requisitos** – Qué datos se necesitan.  
2. **Diseño conceptual** – Se elabora el **modelo E/R**.  
3. **Diseño lógico** – Se adapta al tipo de base de datos (relacional, orientada a objetos, etc.).  
4. **Diseño físico** – Se implementa en un SGBD concreto.

![alt text](./img/fases-diseno.png)

---

## 4. El modelo Entidad/Relación (E/R)

Creado por **Peter Chen (1976)**, este modelo representa los datos mediante tres elementos:
- **Entidades:** objetos o conceptos.  
- **Atributos:** características de esos objetos.  
- **Relaciones:** vínculos entre entidades.

![alt text](./img/modelo-er-esquema.png)

---

## 5. Las entidades

Una **entidad** representa un objeto del mundo real (persona, producto, curso…).

### Tipos de entidades
| Tipo | Descripción | Ejemplo |
|------|--------------|----------|
| **Fuerte** | Existe por sí misma. | LIBRO |
| **Débil** | Depende de otra entidad. | CAPÍTULO (depende de LIBRO) |


### Representación gráfica
- **Entidad fuerte:** rectángulo.  
- **Entidad débil:** doble rectángulo.

![alt text](./img/entidad-fuerte.png)

---

## 6. Los atributos

Los **atributos** describen las características de una entidad o relación. Ejemplo: ALUMNO (nombre, edad, DNI).

### 6.1. Dominio
Conjunto de valores permitidos para un atributo. Ejemplo: `edad → 0–120`.

### 6.2. Representación
- Elipse unida a la entidad o relación.

![alt text](./img/atributo-representacion.png)


### 6.3. Tipos de atributos
| Tipo | Descripción | Ejemplo |
|------|--------------|----------|
| **Identificativo** | Distingue una entidad de otra. | DNI |
| **Descriptivo** | Aporta información adicional. | Nombre |
| **Derivado** | Calculado a partir de otros. | Edad (fecha de nacimiento) |
| **Multivaluado** | Varios valores posibles. | Teléfono |
| **Compuesto** | Se divide en subatributos. | Dirección → calle, nº, ciudad |
| **Opcional** | Dato que puede ser nulo. | Correo (puede que no tengan) |

![alt text](./img/atributos-tipos.png)

---

## 7. Las relaciones

Representan asociaciones entre entidades. Se dibujan con **rombos**.

Ejemplo: AUTOR — PUBLICA — LIBRO

![alt text](./img/relaciones.png)

### 7.1. Grado de una relación
| Tipo | Descripción | Ejemplo |
|------|--------------|----------|
| **Binaria (2)** | Dos entidades | CLIENTE–PEDIDO |
| **Ternaria (3)** | Tres entidades | ALUMNO–ASIGNATURA–PROFESOR |
| **Reflexiva** | Una entidad consigo misma | EMPLEADO supervisa EMPLEADO |
| **dobles** | diferentes relaciones entre las mismas entidades | EMPLEADO supervisa EMPLEADO |

![alt text](./img/relaciones1.png)

**Ejemplo relación reflexiva**
- ¿Cuántos subordinados puede tener un jefe? Un jefe puede tener un mínimo de 1 y un máximo de n (1,n)
- ¿Cuántos jefes puede tener un subordinado? Un mínimo de 0 (un empleado sin jefes sería el responsable de una empresa) y un máximo de 1. (0,1)
- Por tanto la cardinalidadsería de 1:N

![alt text](./img/reflexiva1.png)

Normalmente definen el papel de una entidad en la relación.

Ejemplo: EMPLEADO (supervisor / supervisado)

![alt text](./img/reflexiva.png)


**Ejemplo de ralación ternaria**

| Entidad    | Interpretación                                                   | Participación | Cardinalidad                                         |
|-------------|------------------------------------------------------------------|----------------|------------------------------------------------------|
| **AUTOR**   | Un autor puede escribir varios libros en distintas editoriales. | Total (1,n)    | Un autor participa en una o más publicaciones.       |
| **LIBRO**   | Cada libro pertenece a un solo autor y una sola editorial.       | Total (1,1)    | Cada libro está asociado exactamente con un autor y una editorial. |
| **EDITORIAL** | Una editorial puede publicar muchos libros de distintos autores. | Total (1,n)    | Cada editorial participa en una o más publicaciones. |

Relación ternaria PUBLICA con cardinalidades (1 : n : n) entre AUTOR, LIBRO y EDITORIAL

![alt text](./img/ternaria.png)

### 7.2. Cardinalidad
Indica cuántas veces una entidad participa en una relación.

| Tipo | Descripción | Ejemplo |
|------|--------------|----------|
| **1:1** | Un elemento se relaciona con uno. | Persona–DNI |
| **1:N** | Uno con muchos. | PROFESOR–ASIGNATURA |
| **M:N** | Muchos con muchos. | ALUMNO–ASIGNATURA |


### 7.3. Cardinalidad mínima y máxima
Ejemplo: Un **autor** puede escribir *(1,N)* libros; un **libro** puede tener *(0,N)* autores.

![alt text](./img/cardinalidad-minmax.png)

---

## 10. Bibliografía y recursos
- Elmasri & Navathe (2007). *Fundamentos de sistemas de bases de datos*. Addison Wesley.  
- López, I., Castellano, M. J. & Ospino, J. (2011). *Bases de datos*. Garceta.  
- [TuInstitutoOnline – Tipos de atributos](https://www.tuinstitutoonline.com/cursos/baseavanzado1_v1606/03atributos.php)  
- [Helisulbaran – Diagrama Entidad Relación](https://helisulbaransistemas.blogspot.com/2016/11/modelo-entidad-relacion-el-modelo.html)

