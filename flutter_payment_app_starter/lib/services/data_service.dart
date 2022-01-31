import 'dart:convert';
import 'package:flutter_payment_app/models/data_models.dart';
import 'package:http/http.dart' as http;

class DataServices {
  //localhost ios emulator 127.0.0.1 or localhost
  //localhost android emulator 10.0.2.2
  //localhost on real device mean different

  String _baseUrl = "http://192.168.1.81:9000";

  Future<List<DataModel>> getUsers() async {
    var apiUrl = '/api/billinfo';

    http.Response response = await http.get(Uri.parse(_baseUrl + apiUrl));

    try {
      if (response.statusCode == 200) {
        List<dynamic> list = await json.decode(response.body);
        print(list);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        {
          print("something is wrong");
          return <DataModel>[];
        }
      }
    } catch (e) {
      print(e);
      print("Api request fail");
      return <DataModel>[];
    }

    // var info = rootBundle.loadString("json/data.json");

    // List<dynamic> list = json.decode(await info);

    // return Future.delayed(
    //     Duration(seconds: 5), () => list.map((e) => e).toList());
  }
}
