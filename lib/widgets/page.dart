import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
    Color(0xff419efb),
    'assets/hotels.png',
    'Hotels',
    'All hotels andhostels are sorted by hospitality rating',
    'assets/fountain-pen.png',
  ),
  PageViewModel(
    Color(0xff411cf7),
    'assets/banks.png',
    'Banks',
    'We carefully verify all banks before adding them into the app',
    'assets/sun.png',
  ),
  PageViewModel(
      Color(0xffc558f9),
      'assets/stores.png',
      'Store',
      'All local stores are categorized for your convenience',
      'assets/laptop.png'),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({this.viewModel, this.percentVisible = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: viewModel.color,
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  viewModel.heroAssetPath,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  viewModel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRoma',
                    fontSize: 34.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 75.0),
              child: Text(
                viewModel.body,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String icon;

  PageViewModel(
      this.color, this.heroAssetPath, this.title, this.body, this.icon);
}
