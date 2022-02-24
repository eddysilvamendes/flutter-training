import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  int secound = 0, minute = 0, hour = 0;
  String digitSecound = "00", digitMinute = "00", digitHour = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      secound = 0;
      minute = 0;
      hour = 0;
      digitSecound = "00";
      digitMinute = "00";
      digitHour = "00";
      started = false;
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSecound = secound + 1;
      int localMinute = minute;
      int localHour = hour;

      if (localSecound > 59) {
        if (localMinute > 59) {
          localHour++;
          localMinute = 0;
        } else {
          localMinute++;
          localSecound = 0;
        }
      }
      setState(() {
        secound = localSecound;
        minute = localMinute;
        hour = localHour;
        digitSecound = (secound >= 10) ? "$secound" : "0$secound";
        digitMinute = (minute >= 10) ? "$minute" : "0$minute";
        digitHour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  void addLaps() {
    String lap = "$digitHour:$digitMinute:$digitSecound";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "StopWatch",
              style: TextStyle(
                  fontFamily: "avenir",
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 24),
            ),
            Center(
              child: Text(
                "$digitHour:$digitMinute:$digitSecound",
                style: TextStyle(
                    fontFamily: "avenir",
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 80),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF32F68),
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap nº ${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: laps.length,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started) ? "Start" : "Pause",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => addLaps(),
                  icon: Icon(
                    Icons.flag,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () => reset(),
                    fillColor: Colors.blue,
                    shape: StadiumBorder(),
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
