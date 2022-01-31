import 'package:clock_app/app/data/data.dart';
import 'package:clock_app/app/model/enums.dart';
import 'package:clock_app/app/model/menu_info.dart';
import 'package:clock_app/app/pages/alarm_page.dart';
import 'package:clock_app/app/pages/clock_page.dart';
import 'package:clock_app/app/pages/clock_view.dart';
import 'package:clock_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatedTime = DateFormat("HH:mm").format(now);
    var formatedDate = DateFormat("EEE, d MMM").format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = "+";
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems.map((e) => buildMenuButton(e)).toList()),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfor>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.timer)
                  return Container(
                    child: Text(
                      "Timer",
                      style: TextStyle(
                          fontFamily: "avenir",
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  );
                else if (value.menuType == MenuType.stopwatch)
                  return Container(
                    child: Text(
                      "StopWatch",
                      style: TextStyle(
                          fontFamily: "avenir",
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  );
                else
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Clock",
                            style: TextStyle(
                                fontFamily: "avenir",
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 24),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatedTime,
                                style: TextStyle(
                                    fontFamily: "avenir",
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 64),
                              ),
                              Text(
                                formatedDate,
                                style: TextStyle(
                                    fontFamily: "avenir",
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                              size: MediaQuery.of(context).size.height / 3,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Timezone",
                                style: TextStyle(
                                    fontFamily: "avenir",
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "UTC" + offsetSign + timezoneString,
                                    style: TextStyle(
                                        fontFamily: "avenir",
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfor currentMenuInfo) {
    // ignore: deprecated_member_use
    return Consumer<MenuInfor>(
      builder: (context, value, child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfor>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource ?? "",
                scale: 1.5,
              ),
              SizedBox(height: 10),
              Text(
                currentMenuInfo.title ?? "",
                style: TextStyle(
                    fontFamily: "avenir", color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
