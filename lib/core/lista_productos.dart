import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_de_inventario/models/producto.dart';



class ListaProductosScreen extends StatelessWidget {
  
  final CollectionReference _inventario = FirebaseFirestore.instance.collection('productos');

  
  Stream<List<Producto>> obtenerProductos() {
    return _inventario.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Producto.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: StreamBuilder<List<Producto>>(
        stream: obtenerProductos(),
        builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los productos: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles.'));
          }

          List<Producto> productos = snapshot.data!;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(producto.id),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
                    children: [
                    Text('Nombre: ${producto.nombre}'),  
                    Text('Categoria: ${producto.categoria}'),
                    Text('Descripcion: ${producto.descripcion}'),
                    Text('Precio: ${producto.precio.toDouble()} €'),
                    Text('Stock: ${producto.stock} unidades'),                   
                    
      ],
    ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}