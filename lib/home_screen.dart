import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  HomeScreen(this.username);

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _convertToMorse() {
    String firstName = _firstNameController.text.toUpperCase();
    String lastName = _lastNameController.text.toUpperCase();

    String morseFirstName = _textToMorse(firstName);
    String morseLastName = _textToMorse(lastName);


    _showToast('Nombre en Morse: $morseFirstName');
    _showToast('Apellido en Morse: $morseLastName');
  }

  String _textToMorse(String text) {
    Map<String, String> morseCode = {
      'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
      'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
      'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--', 'Z': '--..',
      '1': '.----', '2': '..---', '3': '...--', '4': '....-', '5': '.....',
      '6': '-....', '7': '--...', '8': '---..', '9': '----.', '0': '-----',
      ' ': '/'
    };

    List<String> result = [];

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (morseCode.containsKey(char)) {
        result.add(morseCode[char]!);
      }
    }

    return result.join(' ');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertToMorse,
              child: Text('Convertir a Morse'),
            ),
          ],
        ),
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
        child: Icon(Icons.info),
      ),
    );
  }
}