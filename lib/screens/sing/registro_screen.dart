import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_de_inventario/screens/login/login_screen.dart'; // Importa la pantalla de inicio de sesión

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _mostrarDialogoRegistroExitoso(context); // Muestra el diálogo de éxito
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Ocurrió un error.';
        if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es muy débil.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Ya existe una cuenta con ese correo electrónico.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  void _mostrarDialogoRegistroExitoso(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text('¡Tu registro se completó con éxito!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ); // Navega a la pantalla de inicio de sesión
              },
              child: const Text('Ir a Iniciar Sesión'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5FB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Registrarse',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A90E2),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registrarUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                  ),
                  child: const Text('Registrarse', style: TextStyle(fontSize: 16)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: const Text('¿Ya tienes una cuenta?'),
              ),
              const Text('¡Hazlo fácil, comienza con nosotros!'),
            ],
          ),
        ),
      ),
    );
  }
}