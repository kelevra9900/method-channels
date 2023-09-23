import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method Channel',
      theme: ThemeData(
        primarySwatch: Colors
            .deepPurple, // Cambiar a primarySwatch para establecer el color principal
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MethodChannel _platformVersionChannel =
      const MethodChannel('com.example/platform_version');
  final MethodChannel dataChannel = const MethodChannel('com.example/data_channel');
  Future<void> _showPlatformVersion(BuildContext ctx) async {
    try {
      final platformVersion =
          await _platformVersionChannel.invokeMethod('getPlatformVersion');
      _showAlertDialog(ctx, platformVersion);
    } on PlatformException catch (e) {
      print('Error al obtener la versión de la plataforma: ${e.message}');
    }
  }

  Future<String?> _sendAndReceiveString(String message) async {
    try {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await _sendAndReceiveString('Hello Flutter');
                _showAlertDialog(context, result);
              },
              child: const Text('Enviar y Recibir Cadena'),
            ),
            const SizedBox(height: 16), // Espacio vertical entre los botones
            ElevatedButton(
              onPressed: () {
                _showPlatformVersion(context);
              },
              child: const Text('Obtener Versión de la Plataforma'),
            ),
          ],
        ),
      ),
    );
  }
}
