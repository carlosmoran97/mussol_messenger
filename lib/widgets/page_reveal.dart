import 'package:flutter/material.dart';
import 'dart:math';

class PageReveal extends StatelessWidget {

  final double revealPercent;
  final Widget child;

  PageReveal({
    this.revealPercent,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect>{
  final double revealPercent;
  CircleRevealClipper(this.revealPercent);
  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height * 0.9);
    // Calculate distance from epicenter to the top left corner to make sure we fill the screen.
    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);
    final radius = distanceToCorner * revealPercent;
    final diameter = radius * 2;
    return Rect.fromLTWH(
      epicenter.dx - radius,
      epicenter.dy - radius,
      diameter,
      diameter
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    
    return true;
  }

}