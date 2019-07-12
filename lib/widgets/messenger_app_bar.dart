import 'package:flutter/material.dart';
import 'package:messenger/widgets/button_app_bar.dart';

class MessengerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 0.0,
      color: Color(0xff00f7bd),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonAppBar(
            iconData: Icons.favorite,
            onPressed: () {},
          ),
          ButtonAppBar(
            iconData: Icons.send,
            onPressed: () {},
          ),
          Container(
            height: 48.0,
            width: 48.0,
          ),
          ButtonAppBar(
            iconData: Icons.access_time,
            onPressed: () {},
          ),
          Container(
            height: 48.0,
            width: 48.0,
          ),
        ],
      ),
    );
  }
}
