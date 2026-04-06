-- Crear la base de datos y usarla
CREATE DATABASE IF NOT EXISTS happiness_co;
USE happiness_co;

-- --------------------------------------------------------
-- CREACIÓN DE TABLAS
-- --------------------------------------------------------

-- Tabla Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Tabla Eventos
CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    ubicacion VARCHAR(200) NOT NULL,
    descripcion TEXT
);

-- Tabla Galerías
CREATE TABLE galerias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES eventos(id) ON DELETE CASCADE
);

-- Tabla Imágenes de las galerías
CREATE TABLE imagenes_galerias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    id_galeria INT NOT NULL,
    FOREIGN KEY (id_galeria) REFERENCES galerias(id) ON DELETE CASCADE
);

-- Tabla Favoritos
CREATE TABLE favoritos (
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES eventos(id) ON DELETE CASCADE
);

-- --------------------------------------------------------
-- INSERCIÓN DE DATOS
-- --------------------------------------------------------

-- Usuarios (Mínimo tres usuarios)
INSERT INTO usuarios (nombre, email, password) VALUES
('Ana Martínez', 'ana@example.com', 'pass123'),
('Luis Gómez', 'luis@example.com', 'pass456'),
('Carlos Ruiz', 'carlos@example.com', 'pass789');

-- Eventos obligatorios (Seis eventos: tres del historial y tres próximos respecto a 28-02-2026)
-- Historial: 01-01-2026, 12-01-2026, 24-01-2026 (IDs 1, 2, 3)
-- Próximos: 05-06-2026, 15-06-2026, 25-06-2026 (IDs 4, 5, 6)
INSERT INTO eventos (fecha, titulo, ubicacion, descripcion) VALUES
('2026-01-01', 'Cena de Año Nuevo', 'Salón Mágico', 'Evento especial de año nuevo con cena y baile.'),
('2026-01-12', 'Concierto Acústico', 'Teatro Principal', 'Concierto íntimo de artistas locales.'),
('2026-01-24', 'Feria de Arte', 'Plaza Central', 'Exposición de arte contemporáneo al aire libre.'),
('2026-06-05', 'Festival de Verano', 'Parque de la Ciudad', 'Festival de música al aire libre.'),
('2026-06-15', 'Taller de Fotografía', 'Estudio Creativo', 'Taller práctico de fotografía de retratos.'),
('2026-06-25', 'Noche de Comedia', 'Club de la Comedia', 'Espectáculo de stand-up con comediantes invitados.');

-- Galerías (Los tres eventos mínimos del historial tendrán una galería cada uno)
-- Eventos del historial: ID 1, 2, 3
INSERT INTO galerias (titulo, id_evento) VALUES
('Fotos de Año Nuevo', 1),       -- ID 1
('Momentos del Concierto', 2),   -- ID 2
('Obras de la Feria', 3);        -- ID 3

-- Imágenes (Mínimo tres imágenes por cada galería)
INSERT INTO imagenes_galerias (titulo, imagen, id_galeria) VALUES
-- Galería 1 (Evento 1)
('Brindis', 'brindis.jpg', 1),
('Gente Bailando', 'baile.jpg', 1),
('Decoración', 'decoracion.jpg', 1),
-- Galería 2 (Evento 2)
('Cantante principal', 'cantante.jpg', 2),
('Público emocionado', 'publico.jpg', 2),
('Escenario iluminado', 'escenario.jpg', 2),
-- Galería 3 (Evento 3)
('Cuadro al óleo', 'cuadro1.jpg', 3),
('Escultura de bronce', 'escultura.jpg', 3),
('Artista pintando', 'artista.jpg', 3);

-- Favoritos (Cada usuario tendrá, al menos, tres eventos favoritos y, al menos, dos del historial)
-- Eventos Historial IDs: 1, 2, 3.  Eventos Próximos IDs: 4, 5, 6.
-- Usuario 1: 1, 2 (historial) y 4 (próximo)
INSERT INTO favoritos (id_usuario, id_evento) VALUES (1, 1), (1, 2), (1, 4);
-- Usuario 2: 2, 3 (historial) y 5 (próximo)
INSERT INTO favoritos (id_usuario, id_evento) VALUES (2, 2), (2, 3), (2, 5);
-- Usuario 3: 1, 3 (historial) y 6 (próximo)
INSERT INTO favoritos (id_usuario, id_evento) VALUES (3, 1), (3, 3), (3, 6);

-- --------------------------------------------------------
-- CREACIÓN DE VISTAS
-- --------------------------------------------------------

-- 1. Devuelvan las galerías anteriores al 28-02-2026.
CREATE OR REPLACE VIEW vista_galerias_historial AS
SELECT g.id, g.titulo AS titulo_galeria, e.fecha, e.titulo AS titulo_evento
FROM galerias g
JOIN eventos e ON g.id_evento = e.id
WHERE e.fecha < '2026-02-28';

-- 2. Devuelvan los eventos favoritos del usuario 1.
CREATE OR REPLACE VIEW vista_favoritos_usuario_1 AS
SELECT e.id, e.fecha, e.titulo, e.ubicacion, e.descripcion
FROM eventos e
JOIN favoritos f ON e.id = f.id_evento
WHERE f.id_usuario = 1;

-- 3. Devuelvan las imágenes de la galería del evento del 12-01-2026 (usar su id para crear la vista, no la fecha).
-- El evento del 12-01-2026 se corresponde con el id_evento = 2
CREATE OR REPLACE VIEW vista_imagenes_evento_2 AS
SELECT ig.id, ig.titulo, ig.imagen, ig.id_galeria
FROM imagenes_galerias ig
JOIN galerias g ON ig.id_galeria = g.id
WHERE g.id_evento = 2;

-- 4. Devuelvan los eventos favoritos del usuario 2 posteriores al 28-02-2026.
CREATE OR REPLACE VIEW vista_favoritos_usuario_2_proximos AS
SELECT e.id, e.fecha, e.titulo, e.ubicacion, e.descripcion
FROM eventos e
JOIN favoritos f ON e.id = f.id_evento
WHERE f.id_usuario = 2 AND e.fecha > '2026-02-28';
