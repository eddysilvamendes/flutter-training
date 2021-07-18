import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

class PickButton extends StatefulWidget {
  const PickButton({Key? key}) : super(key: key);

  @override
  _PickButtonState createState() => _PickButtonState();
}

class _PickButtonState extends State<PickButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            height: 50,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Size"),
                    content: Text("Choose the size"),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: blue),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            color: white,
            textColor: grey,
            elevation: 0.2,
            child: Row(
              children: [
                Expanded(
                  child: Text("Size"),
                ),
                Expanded(
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            height: 50,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Colors"),
                    content: Text("Choose a Color"),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: blue),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            color: white,
            textColor: grey,
            elevation: 0.2,
            child: Row(
              children: [
                Expanded(
                  child: Text("Color"),
                ),
                Expanded(
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            height: 50,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Qauntity"),
                    content: Text("Choose the Quantity"),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(color: blue),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            color: white,
            textColor: grey,
            elevation: 0.2,
            child: Row(
              children: [
                Expanded(
                  child: Text("Qty"),
                ),
                Expanded(
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SubmitDetailButton extends StatefulWidget {
  const SubmitDetailButton({Key? key}) : super(key: key);

  @override
  _SubmitDetailButtonState createState() => _SubmitDetailButtonState();
}

class _SubmitDetailButtonState extends State<SubmitDetailButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
              height: 50,
              onPressed: () {},
              color: red,
              textColor: white,
              elevation: 0.2,
              child: Text("Buy now")),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_shopping_cart,
            color: red,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
            color: red,
          ),
        )
      ],
    );
  }
}
