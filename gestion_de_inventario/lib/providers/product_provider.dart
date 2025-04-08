import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class ProductProvider extends ChangeNotifier{
  final _inventario = FirebaseFirestore.instance.collection('productos');

  List<DocumentSnapshot> _productos = [];
  String? _selectedDocumentId;
  Map<String, dynamic> _selectedProductData = {};

  List <DocumentSnapshot> get productos => _productos;
  String? get selectedDocumentId => _selectedDocumentId;
  Map<String, dynamic> get selectedProductData => _selectedProductData;

  Future<void> recuperarProductos() async {
    try {
      final snapshot = await _inventario.get();
      _productos = snapshot.docs;
      notifyListeners();      
    }catch (error) {
     print ('Error al cargar productos: $error');
    }
  }
  void selectedProduc(DocumentSnapshot? doc){
  if (doc!= null) {
     _selectedDocumentId = doc.id;
     _selectedProductData = doc.data() as Map<String, dynamic>;
  }else {
    _selectedDocumentId = null;
    _selectedProductData = {};
  }
  notifyListeners();
}

Future<void> actualizarProducto (Map<String, dynamic> nuevosDatos)async{
  if (_selectedDocumentId != null){
    try{
    await _inventario.doc(_selectedDocumentId).update(nuevosDatos);
    recuperarProductos();
    notifyListeners();
  }catch (error) {
     print ('Error al actualizar productos: $error');
    }
  } 
}

Future<void> borrarProducto () async{
  if(_selectedDocumentId != null){
    try{
      await _inventario.doc(_selectedDocumentId).delete();
      recuperarProductos();
      notifyListeners();
    }catch (error) {
     print ('Error al borrar productos: $error');
    }finally{
      _selectedDocumentId = null;
      _selectedProductData = {};
      notifyListeners();
    }
  }
}

Future<void> agregarProducto(Map<String, dynamic> nuevosDatos)async {
  try {
    await _inventario.add(nuevosDatos);
    recuperarProductos();
    notifyListeners();
  }catch (error) {
    print ('Error al agregar nuevo producto');
  }
 }

}