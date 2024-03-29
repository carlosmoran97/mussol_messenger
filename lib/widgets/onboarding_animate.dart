import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:messenger/widgets/custom_route.dart';
import 'package:messenger/widgets/onboarding_code.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class OnboardingAnimate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlareActor(
            'assets/Background.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.cover,
            animation: 'Background loop',
          ),
          FlareActor(
            'assets/Animate 2.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.contain,
            animation: 'Animate OWL LOOP',
          ),
          Positioned(
            bottom: 0.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    '< BACK',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DotsIndicator(
                    numberOfDot: 3,
                    position: 1,
                    dotColor: Color(0xff411cf7),
                    dotActiveColor: Colors.white
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.push(context, CustomRoute(
                        builder: (BuildContext context){
                          return OnboardingCode();
                        }
                    ));
                  },
                  child: Text(
                    'NEXT >',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
