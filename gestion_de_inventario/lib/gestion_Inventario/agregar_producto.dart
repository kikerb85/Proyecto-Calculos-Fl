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

  Map<String, dynamic> toMap(){
    return {
      'nombre': nombre, 
      'categoria': categoria, 
      'descripcion': descripcion, 
      'precio': precio, 
      'stock': stock,
    };
  }
  factory Producto.fromMap(Map<String, dynamic> map, String id) {
    return Producto(
      id: id,
      nombre: map['nombre'],
      categoria: map['categoria'],
      descripcion:map['descripcion'],
      precio: map['precio'],
      stock: map['stock'],
    );
  }
}

Future<void> _guardarProducto(Producto producto) async {
    final inventario = FirebaseFirestore.instance.collection('productos');
    if (widget.producto == null) {
      await inventario.add(producto.toMap());
    } else {
      await inventario.doc(producto.id).update(producto.toMap());
    }    
  }