import 'package:cloud_firestore/cloud_firestore.dart';


class Producto {

 final String id;
 final String nombre;
 final String categoria;
 final String descripcion;
 final double precio;
 final int stock;

 Producto ({
  this.id ='',
  required this.nombre,
  required this.categoria,
  required this.descripcion,
  required this.precio,
  required this.stock,
 });

 Map<String, dynamic> toFirestore(){
  return{
    'nombre' : nombre,
    'categoria' : categoria,
    'descripcion' : descripcion,
    'precio' : precio,
    'stock' : stock,    
  };
 }
factory Producto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc){

  final data = doc.data();
  return Producto(
    id: doc.id,
    nombre: data? ['nombre'] ?? '' , 
    categoria: data? ['categoria'] ?? '', 
    descripcion: data?['descripcion'] ?? '', 
    precio: (data? ['precio'] ?? 0.0).toDouble(), 
    stock: data? ['stock'] ?? '',
    );
}

}