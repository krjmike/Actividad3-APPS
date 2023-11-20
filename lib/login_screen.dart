import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  void _login(BuildContext context) async {
    // Simulación de autenticación
    String username = _usernameController.text;
    // Guardar el usuario en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);

    // Navegar a la pantalla de inicio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.jpg', // Ruta de la imagen en tu proyecto
              width: 300,
              height: 300,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}