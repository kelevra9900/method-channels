import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MethodChannel Test', () {
    const channel = MethodChannel('com.example/data_channel');
    final List<MethodCall> methodCalls = <MethodCall>[];
    String? alertDialogMessage;

    setUp(() {
      channel.setMockMethodCallHandler((methodCall) async {
        methodCalls.add(methodCall);
        if (methodCall.method == 'concatenateString') {
          return 'Hello Flutter - Native';
        }
        return null;
      });
    });

    Future<String?> _sendAndReceiveString(String message) async {
      try {
        const MethodChannel dataChannel = MethodChannel('com.example/data_channel');
        final String? response = await dataChannel.invokeMethod('concatenateString', message);
        return response;
      } on PlatformException catch (e) {
        print('Error al enviar y recibir cadena: ${e.message}');
        return null;
      }
    }

    Future<void> _showAlertDialog(WidgetTester tester, String? message) async {
      return showDialog<void>(
        context: tester.element(find.text('Enviar y Recibir Cadena')),
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Respuesta desde el Código Nativo'),
            content: Text(message ?? 'No se recibió respuesta del código nativo.'),
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

    testWidgets('Test MethodChannel Communication', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                final result = await _sendAndReceiveString('Hello Flutter');
                _showAlertDialog(tester, result);
              },
              child: const Text('Enviar y Recibir Cadena'),
            ),
          ),
        ),
      ));

      // Tap the button to trigger MethodChannel communication
      await tester.tap(find.text('Enviar y Recibir Cadena'));
      await tester.pump();

      // Verify that the AlertDialog is shown
      expect(find.text('Respuesta desde el Código Nativo'), findsOneWidget);

      // Get the AlertDialog message
      alertDialogMessage = tester.widget<Text>(find.text('Hello Flutter - Native')).data;

      // Verify the expected message in AlertDialog
      expect(alertDialogMessage, 'Hello Flutter - Native');
      
      // Verify the method call
      expect(methodCalls, <Matcher>[
        isMethodCall('concatenateString', arguments: 'Hello Flutter'),
      ]);
    });
  });
}
