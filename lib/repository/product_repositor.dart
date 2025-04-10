import '../models/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





  final CollectionReference _inventario = FirebaseFirestore.instance.collection('productos');

  // Agregar productos a la colección

  Future<void> agregarProducto (Producto producto) async {
    try {
      await _inventario.add(producto.tofireStore());
    }catch (e){
      rethrow;
    }
  }

  Future<void> editarProducto (Producto producto) async{
   try{
    if (producto.id == null){
      throw ArgumentError('El ID del producto es necesrio para actualizar el producto');
    }
    await _inventario.doc(producto.id).update(producto.tofireStore());
   }catch (e){
    rethrow;
   }
  }
   
   Future<void> borrarProducto (Producto producto) async {
    try {
      await _inventario.doc(producto.id).delete();
    }catch (e){
      rethrow;
    }
   }

   Stream<List<Producto>> obtenerProductos() {
    return _inventario.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
    });
   }

   

 


