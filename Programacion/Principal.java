package Programacion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Principal {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        HashMap<String, Usuario> usuarios = new HashMap<>();
        HashMap<Integer, Evento> eventos = new HashMap<>();
        HashMap<Integer, Galeria> galeriasGlobales = new HashMap<>();
        ArrayList<Favorito> favoritos = new ArrayList<>();

        int idEventoCounter = 0;
        int idGaleriaCounter = 0;

        int opcion = 0;
        do {
            System.out.println("\n--- MENU HAPPINESS&CO ---");
            System.out.println("1. Añadir usuario");
            System.out.println("2. Eliminar usuario");
            System.out.println("3. Añadir evento");
            System.out.println("4. Eliminar evento");
            System.out.println("5. Añadir galería");
            System.out.println("6. Eliminar galería");
            System.out.println("7. Añadir favorito");
            System.out.println("8. Eliminar favorito");
            System.out.println("9. Salir");
            System.out.print("Seleccione una opción: ");

            if (!scanner.hasNextInt()) {
                System.out.println("Opción inválida. Intente de nuevo.");
                scanner.next(); // descartar entrada inválida
                continue;
            }
            opcion = scanner.nextInt();
            scanner.nextLine(); // limpiar buffer

            switch (opcion) {
                case 1:
                    System.out.print("Ingrese nombre: ");
                    String nombre = scanner.nextLine();
                    System.out.print("Ingrese email: ");
                    String email = scanner.nextLine();
                    System.out.print("Ingrese password: ");
                    String password = scanner.nextLine();

                    if (usuarios.containsKey(email)) {
                        System.out.println("El usuario ya existe");
                    } else {
                        usuarios.put(email, new Usuario(nombre, email, password));
                        System.out.println("Usuario creado correctamente");
                    }
                    break;
                case 2:
                    System.out.print("Ingrese email del usuario que desea eliminar: ");
                    String emailEliminar = scanner.nextLine();
                    if (usuarios.containsKey(emailEliminar)) {
                        usuarios.remove(emailEliminar);
                        System.out.println("Usuario eliminado correctamente");
                    } else {
                        System.out.println("El usuario no existe");
                    }
                    break;
                case 3:
                    System.out.print("Ingrese fecha del evento: ");
                    String fecha = scanner.nextLine();
                    System.out.print("Ingrese título del evento: ");
                    String tituloEvento = scanner.nextLine();
                    System.out.print("Ingrese ubicación: ");
                    String ubicacion = scanner.nextLine();
                    System.out.print("Ingrese descripción: ");
                    String descripcion = scanner.nextLine();

                    Evento nuevoEvento = new Evento(idEventoCounter, fecha, tituloEvento, ubicacion, descripcion);
                    eventos.put(idEventoCounter, nuevoEvento);
                    idEventoCounter++;
                    System.out.println("Evento creado correctamente");
                    break;
                case 4:
                    if (eventos.isEmpty()) {
                        System.out.println("No hay eventos disponibles.");
                        break;
                    }
                    System.out.println("--- Listado de Eventos ---");
                    for (Evento e : eventos.values()) {
                        System.out.println("ID: " + e.getId() + " | Título: " + e.getTitulo());
                    }
                    System.out.print("Ingrese el ID del evento que desea eliminar: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idAEliminar = scanner.nextInt();
                    scanner.nextLine();

                    if (eventos.containsKey(idAEliminar)) {
                        eventos.remove(idAEliminar);
                        System.out.println("Evento eliminado correctamente");
                    } else {
                        System.out.println("El evento no existe");
                    }
                    break;
                case 5:
                    if (eventos.isEmpty()) {
                        System.out.println("No hay eventos disponibles para añadirles una galería.");
                        break;
                    }
                    System.out.println("--- Listado de Eventos ---");
                    for (Evento e : eventos.values()) {
                        System.out.println("ID: " + e.getId() + " | Título: " + e.getTitulo());
                    }
                    System.out.print("Ingrese el ID del evento del que se quiere crear una galería: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idEventoGaleria = scanner.nextInt();
                    scanner.nextLine();

                    if (!eventos.containsKey(idEventoGaleria)) {
                        System.out.println("Error: El ID introducido no corresponde a ningún evento.");
                    } else {
                        System.out.print("Ingrese título de la galería: ");
                        String tituloGaleria = scanner.nextLine();

                        Galeria nuevaGaleria = new Galeria(idGaleriaCounter, tituloGaleria, idEventoGaleria);
                        eventos.get(idEventoGaleria).getGalerias().add(nuevaGaleria);
                        galeriasGlobales.put(idGaleriaCounter, nuevaGaleria);
                        idGaleriaCounter++;
                        System.out.println("Galería creada correctamente");
                    }
                    break;
                case 6:
                    if (eventos.isEmpty()) {
                        System.out.println("No hay eventos.");
                        break;
                    }
                    System.out.println("--- Listado de Eventos ---");
                    for (Evento e : eventos.values()) {
                        System.out.println("ID: " + e.getId() + " | Título: " + e.getTitulo());
                    }
                    System.out.print("Ingrese el ID del evento del que se quiere eliminar una galería: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idEventoGaleriaEliminar = scanner.nextInt();
                    scanner.nextLine();

                    if (!eventos.containsKey(idEventoGaleriaEliminar)) {
                        System.out.println("Error: El ID introducido no corresponde a ningún evento.");
                        break;
                    }

                    Evento evento = eventos.get(idEventoGaleriaEliminar);
                    if (evento.getGalerias().isEmpty()) {
                        System.out.println("El evento seleccionado no tiene galerías.");
                        break;
                    }
                    System.out.println("--- Listado de Galerías del Evento ---");
                    for (Galeria g : evento.getGalerias()) {
                        System.out.println("ID Galería: " + g.getId() + " | Título: " + g.getTitulo());
                    }

                    System.out.print("Ingrese el ID de la galería que desea eliminar: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idGaleriaAEliminar = scanner.nextInt();
                    scanner.nextLine();

                    Galeria galeriaAEliminar = galeriasGlobales.get(idGaleriaAEliminar);

                    if (galeriaAEliminar != null && galeriaAEliminar.getIdEvento() == idEventoGaleriaEliminar) {
                        galeriasGlobales.remove(idGaleriaAEliminar);
                        evento.getGalerias().remove(galeriaAEliminar);
                        System.out.println("Galería eliminada correctamente");
                    } else {
                        System.out.println("La galería no existe");
                    }
                    break;
                case 7:
                    if (usuarios.isEmpty() || eventos.isEmpty()) {
                        System.out.println("Deben existir usuarios y eventos para crear un favorito.");
                        break;
                    }
                    System.out.println("--- Listado de Usuarios ---");
                    for (Usuario u : usuarios.values()) {
                        System.out.println("Email: " + u.getEmail() + " | Nombre: " + u.getNombre());
                    }
                    System.out.println("--- Listado de Eventos ---");
                    for (Evento e : eventos.values()) {
                        System.out.println("ID: " + e.getId() + " | Título: " + e.getTitulo());
                    }
                    
                    System.out.print("Ingrese el ID del evento: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idEventoFav = scanner.nextInt();
                    scanner.nextLine();
                    
                    System.out.print("Ingrese el correo del usuario: ");
                    String correoFav = scanner.nextLine();

                    if (!eventos.containsKey(idEventoFav) || !usuarios.containsKey(correoFav)) {
                        System.out.println("Error: Evento o correo incorrecto.");
                    } else {
                        favoritos.add(new Favorito(correoFav, idEventoFav));
                        System.out.println("Favorito creado correctamente");
                    }
                    break;
                case 8:
                    if (favoritos.isEmpty()) {
                        System.out.println("No hay favoritos.");
                        break;
                    }
                    System.out.println("--- Listado de Favoritos ---");
                    for (Favorito f : favoritos) {
                        System.out.println("Usuario: " + f.getCorreoUsuario() + " | ID Evento: " + f.getIdEvento());
                    }
                    
                    System.out.print("Ingrese el ID del evento para identificar el favorito que desea eliminar: ");
                    if (!scanner.hasNextInt()) {
                        System.out.println("Debe ingresar un número.");
                        scanner.next();
                        break;
                    }
                    int idEventoFavEliminar = scanner.nextInt();
                    scanner.nextLine();
                    
                    System.out.print("Ingrese el correo del usuario para identificar el favorito que desea eliminar: ");
                    String correoFavEliminar = scanner.nextLine();

                    Favorito aEliminar = null;
                    for (Favorito f : favoritos) {
                        if (f.getIdEvento() == idEventoFavEliminar && f.getCorreoUsuario().equals(correoFavEliminar)) {
                            aEliminar = f;
                            break;
                        }
                    }

                    if (aEliminar != null) {
                        favoritos.remove(aEliminar);
                        System.out.println("Favorito eliminado correctamente");
                    } else {
                        System.out.println("El favorito no existe");
                    }
                    break;
                case 9:
                    break;
                default:
                    System.out.println("Opción no válida.");
            }
        } while (opcion != 9);

        scanner.close();
    }
}
