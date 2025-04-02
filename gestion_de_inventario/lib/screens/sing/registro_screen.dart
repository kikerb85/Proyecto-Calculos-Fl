import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

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
        // Registro exitoso, puedes navegar a otra pantalla o mostrar un mensaje
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso!')),
        );
      } on FirebaseAuthException catch (e) {
        // Manejar errores de Firebase Authentication
        String errorMessage = 'Ocurrió un error.';
        if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es muy débil.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Ya existe una cuenta con ese correo electrónico.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _registrarUsuario,
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}