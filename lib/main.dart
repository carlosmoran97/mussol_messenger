import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:messenger/widgets/onboarding_design.dart';



void main(){
  timeDilation = 0.5;
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff411cf7),
        accentColor: Color(0xff411cf7),
      ),
      home: AppSplashscreen(
        seconds: 6,
        nextPage: OnboardingDesign(),
      ),
    );
  }
}



class AppSplashscreen extends StatefulWidget {

  final int seconds;
  final Widget nextPage;
  AppSplashscreen({
    Key key,
    this.seconds,
    this.nextPage
  });

  @override
  State<StatefulWidget> createState() {
    return _AppSpashscreenState();
  }
}

class _AppSpashscreenState extends State<AppSplashscreen> {

  startTime()async{
    Duration duration = Duration(
      seconds: widget.seconds != null ? widget.seconds : 2
    );
    return Timer(
      duration,
      showNextPage
    );
  }

  void showNextPage(){
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context){
        return widget.nextPage;
      }
    ));
  }

  @override
  void initState() {

    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlareActor(
            'assets/Background.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.cover,
            animation: 'idle',
          ),
          FlareActor(
            'assets/Splash Screen.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.cover,
            animation: 'MUSSOL LOGO',
          ),
        ],
      ),
    );
  }

}

