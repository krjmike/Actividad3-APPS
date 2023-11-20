import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen(this.username);

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _logout(BuildContext context) async {
    // Eliminar el usuario de SharedPreferences al cerrar sesión
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');

    // Volver a la pantalla de inicio de sesión
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio - $username'),
      ),
      body: Center(
        child: Text('Bienvenido, $username'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menú'),
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showToast('Realizado por Maykel Rhenals'),
        child: Icon(Icons.add),
      ),
    );
  }
}