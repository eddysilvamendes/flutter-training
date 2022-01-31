import 'package:flutter/material.dart';
import 'package:flutter_qr_code_generator_scanner/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreatePage extends StatefulWidget {
  const QrCreatePage({Key? key}) : super(key: key);

  @override
  _QrCreatePageState createState() => _QrCreatePageState();
}

class _QrCreatePageState extends State<QrCreatePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
              ),
              const SizedBox(
                height: 40,
              ),
              buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintText: 'Enter the data',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            suffixIcon: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(
                Icons.done,
                size: 30,
              ),
              onPressed: () => setState(() {}),
            )),
      );
}
