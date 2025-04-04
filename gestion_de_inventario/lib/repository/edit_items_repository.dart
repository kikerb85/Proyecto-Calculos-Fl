import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




final inventario = FirebaseFirestore.instance.collection('productos');

//Obyener productos del inventario
class EditItems extends StatelessWidget {

   final inventario = FirebaseFirestore.instance.collection('productos');
   final String documentId = '';
   final Map<String, dynamic> datos = {};
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Documentos')),
      body: StreamBuilder<QuerySnapshot>(    // Se recogen todos los productos del inventario
        stream: inventario.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar datos'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final documentos = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documentos.length,
              itemBuilder: (context, index) {
                final documento = documentos[index];
                final productos = documento.data() as Map<String, dynamic>;

                return Card(           // Esta forma de mostrar es provisional hasta que tengamos el diseño final
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Producto ${documento.id}:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...productos.entries.map((entry) => Text('${entry.key}: ${entry.value}')),
                      ],                      
                    ))
                    );
            },
            );
          }

          return Center(child: Text('No hay datos disponibles'));
        },
      ),
      bottomSheet: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _mostrarDialogoActualizar(context),
          child: Text('Actualizar'),
        ),
        ElevatedButton(
          onPressed: () => _borrarDocumento(context),
          child: Text('Borrar'),
          style: ElevatedButton.styleFrom(iconColor: Colors.red),
        ),
      ],
    ),
      );       
  }

    void _mostrarDialogoActualizar(BuildContext context) {
    // Aquí puedes crear un diálogo o una nueva pantalla para actualizar los datos.
    // Por simplicidad, aquí solo mostramos un diálogo con campos de texto.
    Map<String, TextEditingController> 
     controladores = {'nombre' : TextEditingController(),
                      'categoria' : TextEditingController(),
                      'descripcion' : TextEditingController(),
                      'precio' : TextEditingController(),
                      'stock' : TextEditingController()};                                                   
      datos.forEach((key, value) {
       controladores[key] = TextEditingController(text: value.toString());
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar Documento'),
          content: SingleChildScrollView(
            child: Column(
              children: controladores.entries.map((entry) {
                return TextField(
                  controller: entry.value,
                  decoration: InputDecoration(labelText: entry.key),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> nuevosDatos = {};
                controladores.forEach((key, controller) {
                  nuevosDatos[key] = controller.text;
                });
                _actualizarDocumento(context, nuevosDatos);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },);
    }



  
   
  // Actualizar Inventario
  void _actualizarDocumento(BuildContext context, Map<String, dynamic> nuevosDatos) {
    inventario.doc(documentId).update(nuevosDatos).then((_) {
      Navigator.pop(context); // Cerrar el diálogo
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Documento actualizado')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    });
  }

  // Borrar documento
  void _borrarDocumento(BuildContext context) {
    FirebaseFirestore.instance.collection('miColeccion').doc(documentId).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Documento borrado')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
    });
  }
}