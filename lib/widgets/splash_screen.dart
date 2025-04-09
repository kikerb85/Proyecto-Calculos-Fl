/* En proceso de realizacion de una pantalla de carga antes del homescreen
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo blanco para la pantalla
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Stocky',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Título en color azul
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Make it easy, do it with us",
              style: TextStyle(
                fontSize: 16,
                color:
                    Colors
                        .black87, // Texto en gris oscuro para mejor visibilidad
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Fondo azul para el botón "Login"
                foregroundColor: Colors.white, // Texto blanco para el botón
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                elevation: 1, // Elevación para darle un efecto de sombra
              ),
              onPressed: () {
                // Navegar a la pantalla de login cuando el botón es presionado
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Fondo blanco para el botón "Sign Up"
                foregroundColor: Colors.blue, // Texto azul para el botón
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                elevation: 1, // Elevación para darle un efecto de sombra
              ),
              onPressed: () {
                // Navegar a la pantalla de registro cuando el botón es presionado
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
