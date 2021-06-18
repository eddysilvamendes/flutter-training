import 'package:flutter/material.dart';
import 'package:whats_app_ui_clone/models/chat_models.dart';

class CallsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => Column(
        children: [
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(dummyData[i].avatarUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dummyData[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.call_made,
                  color: Colors.green[800],
                ),
              ],
            ),
            subtitle: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    Text(
                      dummyData[i].time,
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                    Text(
                      ",",
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                    Text(
                      dummyData[i].date,
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
