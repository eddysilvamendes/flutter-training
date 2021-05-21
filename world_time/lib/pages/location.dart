import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {


  List<WorldTIme> locations = [
    WorldTIme(url: 'Atlantic/Cape_Verde', location: 'Cabo Verde', flag: 'cv.png'),
    WorldTIme(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTIme(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTIme(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTIme(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTIme(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTIme(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTIme(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTIme(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async{
    WorldTIme instance = locations[index];
    await instance.getTime();

    //Navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder:(context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0 , horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),

            ),
          );
        } ,
      ),
    );
  }
}
