import 'package:flutter/material.dart';
import 'package:studieplaneraren/main.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: TheList()
    );
  }
}

class TheList extends StatefulWidget {
  @override
  _TheListState createState() => _TheListState();
}

class _TheListState extends State<TheList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            onDetailsPressed: () {},
            accountName: Text(UserLog().Username),
            accountEmail: Text(UserLog().Email),
            currentAccountPicture: CircleAvatar(child: Text(UserLog().Username[0].toUpperCase(), style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white
            )), backgroundColor: Color(0xFFFFB74D),),
          )
        ],
      ),
    );
  }
}

