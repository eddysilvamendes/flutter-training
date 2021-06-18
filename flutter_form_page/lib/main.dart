import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      performLogin();
    }
  }

  void performLogin() {
    final snackbar =
        SnackBar(content: Text("Email: $_email, password : $_password"));
    scaffoldKey.currentState!.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Form Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (val) =>
                    !val!.contains('@') ? 'Invalid Email' : null,
                onSaved: (val) => _email = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (val) =>
                    val!.length < 6 ? 'Password too short' : null,
                onSaved: (val) => _password = val!,
                obscureText: true,
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _submit,
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
