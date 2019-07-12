import 'package:flutter/material.dart';
import 'package:messenger/Chat/ui/widgets/bezier_fab.dart';
import 'package:messenger/widgets/messenger_app_bar.dart';
import 'package:messenger/widgets/messenger_drawer.dart';
import 'package:flare_flutter/flare_actor.dart';

class InboxListScreen extends StatefulWidget {
  InboxListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InboxListScreenState createState() => _InboxListScreenState();
}

class _InboxListScreenState extends State<InboxListScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.autorenew,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: MessengerDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      body: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BezierFab(
          iconData: Icons.inbox,
          onPressed: () {},
        ),
        bottomNavigationBar: MessengerAppBar(),
        body: Stack(
          children: <Widget>[

          ],
        ),
      ),
    );
  }

}