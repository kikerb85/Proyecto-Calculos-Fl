import 'package:cloud_firestore/cloud_firestore.dart';


class Producto {
 
 String id;
 String nombre;
 String categoria;
 String descripcion;
 double precio;
 int stock;

 Producto ({
  this.id = '', 
  required this.nombre, 
  required this.categoria, 
  required this.descripcion, 
  required this.precio, 
  required this.stock,});

  Map<String, dynamic> toFirestore(){
    return {
      'nombre': nombre, 
      'categoria': categoria, 
      'descripcion': descripcion, 
      'precio': precio, 
      'stock': stock,
    };
  }
  factory Producto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,SnapshotOptions? options) {

    final data = snapshot.data();
    return Producto(
      id: data?['id'],
      nombre: data?['nombre'],
      categoria: data?['categoria'],
      descripcion:data?['descripcion'],
      precio: data?['precio'],
      stock: data?['stock'],
    );
  }
}