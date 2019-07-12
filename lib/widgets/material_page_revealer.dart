import 'package:flutter/material.dart';
import 'dart:async';
import 'package:messenger/widgets/page.dart';
import 'package:messenger/widgets/page_dragger.dart';
import 'package:messenger/widgets/page_reveal.dart';
import 'package:messenger/widgets/pager_indicator.dart';

class MaterialPageRevealer extends StatefulWidget {
  MaterialPageRevealer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MaterialPageRevealerState createState() => _MaterialPageRevealerState();
}

class _MaterialPageRevealerState extends State<MaterialPageRevealer> with TickerProviderStateMixin {

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  _MaterialPageRevealerState(){
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event){
      setState(() {
        if(event.updateType == UpdateType.dragging ){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
          if(slideDirection == SlideDirection.leftToRight){
            nextPageIndex = activeIndex - 1;
          }else if(slideDirection == SlideDirection.rightToLeft){
            nextPageIndex = activeIndex + 1;
          }else{
            nextPageIndex = activeIndex;
          }

        }else if(event.updateType == UpdateType.doneDragging){

          if(slidePercent > 0.2){
            animatedPageDragger = AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.open,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this
            );
          }else{
            animatedPageDragger = AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.close,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this
            );
            nextPageIndex = activeIndex;
          }


          animatedPageDragger.run();}
        else if( event.updateType == UpdateType.animating){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }else if(event.updateType == UpdateType.doneAnimating){
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length -1,
            slideUpdateStream: slideUpdateStream,
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}