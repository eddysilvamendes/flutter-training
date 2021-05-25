import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 250,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white70,
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 60,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          content,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          color: Colors.white,
                          child: Text(actionText),
                          onPressed: callback,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
