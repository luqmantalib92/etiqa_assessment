import 'package:flutter/material.dart';

import 'colour.dart';

class WidgetDialog {
  // Display revoke dialog
  Future<dynamic> basic(
      BuildContext context, String title, String desc, Function onPress) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
        content: Text(
          desc,
          style: TextStyle(fontSize: 12),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CANCEL",
              style: TextStyle(fontSize: 12, color: Colour().primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "DELETE",
              style: TextStyle(fontSize: 12, color: Colour().tertiary),
            ),
            onPressed: onPress,
          )
        ],
      ),
    );
  }
}
