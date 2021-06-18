import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTIme {
  String location; // Location for the UI
  String time; // THe time in that location
  String flag; // URL for a asset flag icon
  String url; // location url
  bool isDayTime; // true or false if its day or not

  WorldTIme({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      // get propreties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      //print(datetime);
      //print(offset);

      //create DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //Set the Time proprety
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error: $e');
      time = 'Enable to load data';
    }
  }
}
