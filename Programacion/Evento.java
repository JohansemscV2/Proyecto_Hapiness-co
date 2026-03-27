package Programacion;

import java.util.ArrayList;

public class Evento {
    private int id;
    private String fecha;
    private String titulo;
    private String ubicacion;
    private String descripcion;
    private ArrayList<Galeria> galerias;

    public Evento(int id, String fecha, String titulo, String ubicacion, String descripcion) {
        this.id = id;
        this.fecha = fecha;
        this.titulo = titulo;
        this.ubicacion = ubicacion;
        this.descripcion = descripcion;
        this.galerias = new ArrayList<>();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getUbicacion() { return ubicacion; }
    public void setUbicacion(String ubicacion) { this.ubicacion = ubicacion; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public ArrayList<Galeria> getGalerias() { return galerias; }
    public void setGalerias(ArrayList<Galeria> galerias) { this.galerias = galerias; }

    @Override
    public String toString() {
        return "Evento{id=" + id + ", fecha='" + fecha + "', titulo='" + titulo + "', ubicacion='" + ubicacion + "', descripcion='" + descripcion + "', galerias=" + galerias + "}";
    }
}
