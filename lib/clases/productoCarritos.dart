import 'package:flutter/material.dart';

class ProductoCarrito {
  String imagen, nombre, descripcion;
  String  material;
  String precio;
  String categoria;
  String key;
  String cantidad;

  ProductoCarrito(this.imagen,this.nombre,this.descripcion,this.precio,this.material,this.categoria,this.key,this.cantidad);

  Map<String, String> toMap() {
    final Map<String, String> data = Map<String, String>();
    data['imagen'] = this.imagen;
    data['nombre'] =  this.nombre;
    data['cantidad'] = this.cantidad;
    return data;
  }

}