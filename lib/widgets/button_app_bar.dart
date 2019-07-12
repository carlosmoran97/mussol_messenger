import 'package:flutter/material.dart';

class ButtonAppBar extends StatelessWidget {

  final IconData iconData;
  final VoidCallback onPressed;
  ButtonAppBar({
    Key key,
    @required this.iconData,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: IconButton(
            icon: Icon(iconData),
            onPressed: onPressed,
            color: Color(0xff275664),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff70e3c9)
          ),
          height: 42.0,
          width: 42.0,
        ),
      ),
      height: 56.0,
      width: 56.0,
    );
  }
}
