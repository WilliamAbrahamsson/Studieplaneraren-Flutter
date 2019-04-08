import 'package:flutter/material.dart';
import 'package:studieplaneraren/main.dart';
import 'drawer.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.cyan,
        title: Text("${UserLog().Username}'s Profile", style: TextStyle(
          color: Colors.white
        ),),
        elevation: 1,
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Container(
              margin: EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: UserLog().Color,
                child: Text(UserLog().Username[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 30)),
                radius: 60,
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25),
              child: Text(UserLog().Fullname, style: TextStyle(
                color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500
              )),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              child: Text(UserLog().School, style: TextStyle(
                  color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500
              )),
            ),


          ],
        ),
      ),
    );
  }
}

