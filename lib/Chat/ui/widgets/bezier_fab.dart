import 'package:flutter/material.dart';

class BezierFab extends StatelessWidget {

  final IconData iconData;
  final VoidCallback onPressed;

  BezierFab({
    Key key,
    @required this.iconData,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: ClipPath(
        child: Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Center(
            child: FloatingActionButton(
              child: Icon(
                iconData,
                color: Color(0xff275664),
              ),
              onPressed: onPressed,
              backgroundColor: Color(0xff70e3c9),
              elevation: 0.0,
            ),
          ),
          width: 84,
          height: 72,
          //color: Color(0xff00f7bd),
          color: Color(0xff00f7bd),
        ),
        clipper: BottomWaveClipper(),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 20);

    // First bezier curve

    var firstControlPoint = new Offset(size.width * 0.5 , 0.0);
    var firstEndPoint = new Offset(0.0, 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
