import 'package:flutter/material.dart';
import '../models/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventarioProvider extends ChangeNotifier {
  final CollectionReference _inventario =
      FirebaseFirestore.instance.collection('productos');

  List<Producto> _productos = [];
  List<Producto> get productos => _productos;

  Future<void> agregarProducto(Producto producto) async {
    try {
      final docRef = await _inventario.add(producto.toFirestore());
      final nuevoProducto = Producto.fromFirestore(
          await docRef.get() as DocumentSnapshot<Map<String, dynamic>>);
      _productos.add(nuevoProducto);
      notifyListeners(); // Notifica a los widgets que están escuchando
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editarProducto(Producto producto) async {
    try {
      await _inventario.doc(producto.id).update(producto.toFirestore());
      // Actualizar la lista local de productos
      final index = _productos.indexWhere((p) => p.id == producto.id);
      if (index != -1) {
        _productos[index] = producto;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> borrarProducto(String productoId) async {
    try {
      await _inventario.doc(productoId).delete();
      // Eliminar de la lista local
      _productos.removeWhere((p) => p.id == productoId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cargarProductosInicial() async {
    try {
      final snapshot = await _inventario.get();
      _productos = snapshot.docs.map((doc) => Producto.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
      notifyListeners();
    } catch (e) {
     
    }
  }

 
  Stream<List<Producto>> obtenerProductosStream() {
    return _inventario.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Producto.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
    });
  }

  InventarioProvider() {
    cargarProductosInicial(); 
  }
}
