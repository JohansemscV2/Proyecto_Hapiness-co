-- Creación de la base de datos
DROP DATABASE IF EXISTS happiness_co;
CREATE DATABASE happiness_co;
USE happiness_co;

-- 1. Crear tablas

CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE Galerias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id) ON DELETE CASCADE
);

CREATE TABLE Imagenes_galerias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    id_galeria INT NOT NULL,
    FOREIGN KEY (id_galeria) REFERENCES Galerias(id) ON DELETE CASCADE
);

CREATE TABLE Favoritos (
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id) ON DELETE CASCADE
);

-- 2. Inserción de Usuarios (al menos 3)
INSERT INTO Usuarios (nombre, email, password) VALUES
('Johan Sierra', 'johan@happiness.co', 'pass123'),
('Ana Gomez', 'ana@happiness.co', 'pass123'),
('Carlos Ruiz', 'carlos@happiness.co', 'pass123');

-- 3. Inserción de Eventos Obligatorios (Historial y Próximos)
-- NOTA: Formato de fecha YYYY-MM-DD
INSERT INTO Eventos (id, fecha, titulo, ubicacion, descripcion) VALUES
(1, '2026-01-01', 'Concierto de Año Nuevo Asturiano', 'Auditorio Príncipe Felipe, Oviedo', 'Celebración de la entrada del año con la Orquesta Sinfónica del Principado de Asturias.'),
(2, '2026-01-12', 'Muestra de Quesos Tradicionales', 'Plaza Mayor, Cangas de Onís', 'Degustación y venta de los mejores quesos de la región, destacando Gamoneo y Cabrales.'),
(3, '2026-01-24', 'Exposición "Memoria Minera"', 'Museo de la Minería, El Entrego', 'Rescate histórico y fotográfico sobre la vida en las cuencas mineras en el siglo XX.'),
(4, '2026-06-05', 'Festival de la Sidra Artesana', 'Puerto de Gijón', 'Cata de sidras, escanciado y música tradicional asturiana frente al mar.'),
(5, '2026-06-15', 'Ruta Senderista Románica', 'Santa María del Naranco, Oviedo', 'Visita cultural para conocer los secretos de la arquitectura prerrománica y senderismo.'),
(6, '2026-06-25', 'Certamen de Cine Celta', 'Casa de Cultura, Ribadesella', 'Proyección de cortometrajes independientes del arco atlántico.');

-- 4. Inserción de Galerías para los 3 eventos del historial
INSERT INTO Galerias (id, titulo, id_evento) VALUES
(1, 'Galería: Concierto de Año Nuevo', 1),
(2, 'Galería: Muestra de Quesos', 2),
(3, 'Galería: Memoria Minera', 3);

-- 5. Inserción de Imágenes (mínimo 3 por cada galería del historial)
INSERT INTO Imagenes_galerias (titulo, imagen, id_galeria) VALUES
('Orquesta Afinando', 'orquesta_1.jpg', 1),
('Público Entusiasmado', 'publico_oviedo.jpg', 1),
('Cierre Espectacular', 'cierre_concierto.jpg', 1),
('Stand de Cabrales', 'queso_cabrales.jpg', 2),
('Desgustación en la Plaza', 'degustacion_quesos.jpg', 2),
('Artesanos Queseros', 'artesanos_cangas.jpg', 2),
('Entrada de Mina', 'mina_antigua.jpg', 3),
('Herramientas Históricas', 'herramientas.jpg', 3),
('Fotografía de la Cuenca', 'foto_blanco_negro.jpg', 3);

-- 6. Inserción de Favoritos
-- Cada usuario debe tener al menos 3 favoritos, y al menos 2 del historial (IDs 1,2,3).
INSERT INTO Favoritos (id_usuario, id_evento) VALUES
-- Usuario 1 (Favoritos: 1, 2, 4): 2 historial, 1 futuro
(1, 1), (1, 2), (1, 4),
-- Usuario 2 (Favoritos: 2, 3, 5): 2 historial, 1 futuro
(2, 2), (2, 3), (2, 5),
-- Usuario 3 (Favoritos: 1, 3, 6): 2 historial, 1 futuro
(3, 1), (3, 3), (3, 6);


-- 7. Creación de las Vistas solicitadas

-- Vista 1: Devuelvan las galerías anteriores al 28-02-2026.
DROP VIEW IF EXISTS v_galerias_historicas;
CREATE VIEW v_galerias_historicas AS
SELECT g.id AS galeria_id, g.titulo AS galeria_titulo, e.fecha, e.titulo AS evento_titulo
FROM Galerias g
JOIN Eventos e ON g.id_evento = e.id
WHERE e.fecha < '2026-02-28';

-- Vista 2: Devuelvan los eventos favoritos del usuario 1.
DROP VIEW IF EXISTS v_favoritos_usuario_1;
CREATE VIEW v_favoritos_usuario_1 AS
SELECT f.id_usuario, e.id AS evento_id, e.titulo AS evento_titulo, e.fecha
FROM Favoritos f
JOIN Eventos e ON f.id_evento = e.id
WHERE f.id_usuario = 1;

-- Vista 3: Devuelvan las imágenes de la galería del evento del 12-01-2026 (usar su id para crear la vista, no la fecha).
-- El evento del 12-01-2026 tiene ID 2 (Muestra de Quesos Tradicionales).
DROP VIEW IF EXISTS v_imagenes_evento_12_01_2026;
CREATE VIEW v_imagenes_evento_12_01_2026 AS
SELECT ig.id AS imagen_id, ig.titulo AS imagen_titulo, ig.imagen, g.id_evento
FROM Imagenes_galerias ig
JOIN Galerias g ON ig.id_galeria = g.id
WHERE g.id_evento = 2;

-- Vista 4: Devuelvan los eventos favoritos del usuario 2 posteriores al 28-02-2026.
DROP VIEW IF EXISTS v_favoritos_usuario_2_futuros;
CREATE VIEW v_favoritos_usuario_2_futuros AS
SELECT f.id_usuario, e.id AS evento_id, e.titulo AS evento_titulo, e.fecha
FROM Favoritos f
JOIN Eventos e ON f.id_evento = e.id
WHERE f.id_usuario = 2 AND e.fecha > '2026-02-28';
