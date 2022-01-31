import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_code_generator_scanner/pages/qr_create_page.dart';
import 'package:flutter_qr_code_generator_scanner/pages/qr_read_page.dart';
import 'package:flutter_qr_code_generator_scanner/widget/button_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'QR Code Scanner';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: "Create QR Code",
              onClicked: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const QrCreatePage(),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ButtonWidget(
              text: "Scan QR Code",
              onClicked: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const QRScanPage(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
