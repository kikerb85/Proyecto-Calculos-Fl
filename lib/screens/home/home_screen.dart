import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INVENTORY'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Agregar funcionalidad para el botón de agregar
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Agregar funcionalidad para la pantalla de productos
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('PRODUCTS'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Agregar funcionalidad para agregar stock
              },
              icon: const Icon(Icons.add_box),
              label: const Text('ADD STOCK'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Agregar funcionalidad para remover stock
              },
              icon: const Icon(Icons.remove_circle_outline),
              label: const Text('REMOVE STOCK'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}