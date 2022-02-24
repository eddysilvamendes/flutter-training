import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration duration = Duration();
  Timer? timer;
  bool isCountDown = true;
  static final countDownDuration = Duration(minutes: 1);

  @override
  void initState() {
    super.initState();

    startTimer();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
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
              "CountDown Timer",
              style: TextStyle(
                  fontFamily: "avenir",
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 24),
            ),
            Center(child: buildTime()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {},
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

  buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minute = twoDigits(duration.inMinutes.remainder(60));
    final secound = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$hours:$minute:$secound",
      style: TextStyle(
          fontFamily: "avenir",
          fontWeight: FontWeight.w300,
          color: Colors.white,
          fontSize: 80),
    );
  }
}
