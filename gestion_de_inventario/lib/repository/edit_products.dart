import 'package:flutter/material.dart';
import 'package:gestion_de_inventario/providers/product_provider.dart';
import 'package:provider/provider.dart';



//Obyener productos del inventario
class EditProducts extends StatefulWidget {
   @override
  _EditProductsState createState() => _EditProductsState();
  } 

class _EditProductsState extends State<EditProducts>{
  @override
  void initState(){
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).recuperarProductos();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Documentos')),
      body: productProvider.productos.isEmpty
            ? Center(child: productProvider.productos.isEmpty ? CircularProgressIndicator()
            : Text('No hay datos disponibles'))            
             :ListView.builder(
              itemCount: productProvider.productos.length,
              itemBuilder: (context, index) {
                final documento = productProvider.productos[index];
                final productos = documento.data() as Map<String, dynamic>;

                return InkWell(           // Esta forma de mostrar es provisional hasta que tengamos el diseño final
                  onTap: () {
                    productProvider.selectedProduc(documento);
                  },
                  child: Card(
                    color: productProvider.selectedDocumentId == documento.id ?
                    Colors.blue[100]: null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Producto ${documento.id}:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ...productos.entries.map((entry) => Text('${entry.key}: ${entry.value}')),
                        ],
                      ),)
                  ),);
                 },
                ),                 
              
      bottomSheet: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: productProvider.selectedDocumentId != null
          ? () => _mostrarDialogoActualizar(context, productProvider)
          : null,
          child: Text('Actualizar'),
        ),
        ElevatedButton(
          onPressed: productProvider.selectedDocumentId != null
          ? () => borrarProducto(context, productProvider)
          : null,          
          style: ElevatedButton.styleFrom(iconColor: Colors.red),
          child: Text('Borrar'),
        ),
        ElevatedButton(
          onPressed: productProvider.selectedDocumentId != null
          ? () => _mostrarDialogoAdd(context, productProvider)
          : null,          
          style: ElevatedButton.styleFrom(iconColor: Colors.red),
          child: Text('Agregar'),
        ),
      ],
    ),
      );       
  }

    void _mostrarDialogoActualizar(BuildContext context, ProductProvider productProvider) {
    // Aquí puedes crear un diálogo o una nueva pantalla para actualizar los datos.
    // Por simplicidad, aquí solo mostramos un diálogo con campos de texto.
    Map<String, TextEditingController> 
     controladores = {};                                                   
      productProvider.selectedProductData.forEach((key, value) {
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
                productProvider.actualizarProducto(nuevosDatos);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                 Text('Documento actualizado')));
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },);
    }

  void _mostrarDialogoAdd (BuildContext context, ProductProvider productProvider) {
    Map<String, TextEditingController> controladores = {      
      'nombre' : TextEditingController(),
      'categoria' : TextEditingController(),
      'descripcion' : TextEditingController(),
      'precio' : TextEditingController(),
      'stock' : TextEditingController()
    };
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Añadir Nuevo Documento'),
        content: SingleChildScrollView(
          child: Column(
            children: controladores.entries.map((entry){
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
             child:Text('Cancelar'),
             ),
            ElevatedButton(
              onPressed:() {
                Map<String, dynamic> nuevosDatos = {};
                controladores.forEach((key, controller){
                  nuevosDatos[key] = controller.text;
                });
                productProvider.agregarProducto(nuevosDatos);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text('Documento añadido')));                
              }, child: Text('Guardar'),
              ),
        ],
      );
    },);
    }

    // Borrar documento
  void borrarProducto(BuildContext context, ProductProvider productProvider) {
    showDialog(
      context: context, 
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('Confirmar Borrado'),
          content: Text('¿Estas seguro que quieres borrar este documento?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:Text('Cancelar'),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: (){
                productProvider.borrarProducto();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text('Documento Borrado')));
              },
              child: Text('Borrar'),
              ),
          ],
        );
      },);
  }
}
