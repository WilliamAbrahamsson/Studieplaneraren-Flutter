import 'package:studieplaneraren/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:studieplaneraren/main.dart';
import 'package:flutter/material.dart';
import 'everyProjectPage.dart';

class Project {
  final int id;
  final String title;
  final String description;
  final String deadline;
  final String subject;
  final String days_left;
  final List users;

  Project(this.id, this.title, this.description, this.deadline, this.subject,
      this.days_left, this.users);
}

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProjectsBody());
  }
}

class ProjectsBody extends StatefulWidget {
  @override
  _ProjectsBodyState createState() => _ProjectsBodyState();
}

class _ProjectsBodyState extends State<ProjectsBody> {
  Future<List<Project>> _getProjects() async {
    var data = await http.get(
        "http://studieplaneraren.pythonanywhere.com/api/projects/${UserLog().Username}/?format=json");
    var jsonData = json.decode(data.body); //an array of json objects

    List<Project> allProjects = [];

    for (var JData in jsonData) {
      Project project = Project(
          JData["id"],
          JData["title"],
          JData["description"],
          JData["deadline"],
          JData["subject"],
          JData["days_left"],
          JData["users"]);

      allProjects.add(project);
    }
    return allProjects;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _getProjects(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            } else
              return ListView.builder(
                  padding:
                      EdgeInsets.only(top: 10, left: 2, right: 2, bottom: 5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EveryProjectPage(
                                    snapshot.data[index],
                                    snapshot.data[index].id)));
                      },
                      child: Container(
                          margin:
                              EdgeInsets.only(right: 5, left: 5, bottom: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white,
                            elevation: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 0, bottom: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 18, top: 24, right: 18),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[index].title,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 18, top: 4, right: 18),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Deadline is in ${snapshot.data[index].days_left}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 18, top: 10, right: 18),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[index].description,
                                      maxLines: 4,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 18, right: 15, top: 5),
                                    height: 50,
                                    child: FutureBuilder(
                                        future: _getProjects(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.data == null) {
                                            return Container(
                                              color: Colors.white,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.all(4),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            );
                                          } else
                                            return ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: snapshot
                                                    .data[index].users.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.orange,
                                                      child: Text(
                                                        "H",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                });
                                        }),
                                  )
                                ],
                              ),
                            ),
                          )),
                    )
                  });
          }),
    );
  }
}
