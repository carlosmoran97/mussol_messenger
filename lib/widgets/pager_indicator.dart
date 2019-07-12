import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:messenger/widgets/page.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;

  PagerIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; ++i) {
      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            pages[i].icon,
            pages[i].color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    const BUBBLE_WIDTH = 65.0;
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);
    if(viewModel.slideDirection == SlideDirection.leftToRight){
      translation  += BUBBLE_WIDTH*viewModel.slidePercent;
    }else if(viewModel.slideDirection == SlideDirection.rightToLeft){
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Transform(
          transform: Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.0,
      height: 65.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: lerpDouble(
              20.0,
              45.0,
              viewModel.activePercent,
            ),
            width: lerpDouble(
              20.0,
              45.0,
              viewModel.activePercent,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isHollow
                  ? Color(0x88FFFFFF)
                      .withAlpha((0x88 * viewModel.activePercent).round())
                  : Color(0x88FFFFFF),
              border: Border.all(
                  color: viewModel.isHollow
                      ? Color(0x88FFFFFF).withAlpha(
                          (0x88 * (1 - viewModel.activePercent)).round())
                      : Colors.transparent,
                  width: 3.0),
            ),
            child: Opacity(
              opacity: viewModel.activePercent,
              child: Image.asset(
                viewModel.iconAssetPath,
                color: viewModel.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      this.iconAssetPath, this.color, this.isHollow, this.activePercent);
}
