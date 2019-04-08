import 'package:flutter/material.dart';
import 'Drawer/drawer.dart';
import 'Drawer/MyProfile.dart';
import 'Studyplans/studyplanPage.dart';
import 'Projects/projectsPage.dart';
import 'package:studieplaneraren/Home/HomePage.dart';

void main() => runApp(MyApp());

class UserLog {
  final Username = "hugo";
  final Fullname = "Hugo-Johnsson";
  final Password = "monsterwilliam";
  final School = "Polhemskolan, Lund";
  final Email = "elev.hugo.johnsson@skola.lund.se";
  final Color = Colors.orange;
}

class User {
  String username;
  String fullname;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        initialIndex: 1, //starts at page 1
        length: 4, //4 pages in total
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                  Icons.refresh, color: Colors.white,), onPressed: () {}),
          IconButton(
              icon: Icon(
                  Icons.account_circle, color: Colors.white,), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          })
        ],
        title: Text(
          "Studieplaneraren",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Colors.white
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.school,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: TabBarView(children: <Widget>[
        TheHomePage(), ProjectsPage(), StudyplanPage()
      ], controller: _tabController),
    );
  }
}


