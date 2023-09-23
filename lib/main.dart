import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method Channel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String?> _sendAndReceiveString(String message) async {
    try {
      const MethodChannel dataChannel =
          MethodChannel('com.example/data_channel');
      final String? response =
          await dataChannel.invokeMethod('concatenateString', message);
      return response;
    } on PlatformException catch (e) {
      print('Error al enviar y recibir cadena: ${e.message}');
      return null;
    }
  }

  Future<void> _showAlertDialog(BuildContext context, String? message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Respuesta desde el Código Nativo'),
          content:
              Text(message ?? 'No se recibió respuesta del código nativo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channels in Flutter'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await _sendAndReceiveString('Hello Flutter');
            _showAlertDialog(context, result);
          },
          child: const Text('Enviar y Recibir Cadena'),
        ),
      ),
    );
  }
}
