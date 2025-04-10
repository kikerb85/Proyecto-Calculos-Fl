import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart'; // Aquí está tu clase Producto

class ProductoConsultas {
  final CollectionReference inventario =
      FirebaseFirestore.instance.collection("productos");

  // Obtener todos los productos (sin filtros)
  Future<List<Producto>> getProductos() async {
    final snapshot = await inventario.get();

    return snapshot.docs.map((doc) {
      return Producto.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>, 
        null,
      );
    }).toList();
  }

  // Buscar por nombre
  Future<List<Producto>> buscarPorNombre(String texto) async {
    final snapshot = await inventario
        .where('nombre', isGreaterThanOrEqualTo: texto)
        .where('nombre', isLessThan: texto + 'z')
        .get();

    return snapshot.docs.map((doc) {
      return Producto.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>, 
        null,
      );
    }).toList();
  }

  // Filtrar por categoría
  Future<List<Producto>> filtrarPorCategoria(String categoria) async {
    final snapshot = await inventario
        .where('categoria', isEqualTo: categoria)
        .get();

    return snapshot.docs.map((doc) {
      return Producto.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>, 
        null,
      );
    }).toList();
  }

  // Buscar por nombre y filtrar por categoría
  Future<List<Producto>> buscarYFiltrar(String texto, String categoria) async {
    final snapshot = await inventario
        .where('categoria', isEqualTo: categoria)
        .where('nombre', isGreaterThanOrEqualTo: texto)
        .where('nombre', isLessThan: texto + 'z')
        .get();

    return snapshot.docs.map((doc) {
      return Producto.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>, 
        null,
      );
    }).toList();
  }
}
