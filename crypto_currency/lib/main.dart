import 'package:crypto_currency/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  print(currencies);
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {

  final List _currencies;
  MyApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async{
  String cryptoUrl = "https://pro-api.coinmarketcap.com";
  http.Response response = await http.get(cryptoUrl,
      headers: {"X-CMC_PRO_API_KEY": "459e117f-62bd-49e0-8081-365ca9bc0cca"});
  print(response.body);
  return json.decode(response.body);

}