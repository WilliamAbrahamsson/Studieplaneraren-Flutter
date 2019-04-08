import 'package:studieplaneraren/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:studieplaneraren/main.dart';
import 'package:flutter/material.dart';
import 'projectsPage.dart';
import 'projectTask.dart';

class ProjectTask {
  final int id;
  final String description;
  final String state;
  final List assigned_users;
  final List subtasks;

  ProjectTask(this.id,
      this.description,
      this.state,
      this.assigned_users,
      this.subtasks);
}

class EveryProjectPage extends StatefulWidget {

  final Project project;
  final int id;

  EveryProjectPage(this.project, this.id);

  @override
  _EveryProjectPageState createState() =>
      _EveryProjectPageState(this.project, this.id);
}

class _EveryProjectPageState extends State<EveryProjectPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        initialIndex: 0, //starts at page 1
        length: 4, //4 pages in total
        vsync: this);
  }

  final Project project;
  final int id;

  _EveryProjectPageState(this.project, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("${project.title[0].toUpperCase()}${project.title.substring(1)}", style: TextStyle(
            color: Colors.white
        )),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              child: Text("Tasks", style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Tab(
              child: Text("Information", style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),),
            ),
          ],
        ),
      ),
      body: TabBarView(children: <Widget>[

        TasksController(this.id), InformationController(this.project)

      ], controller: _tabController),
    );
  }
}


class TasksController extends StatefulWidget {

  final int id;

  TasksController(this.id);

  @override
  _TasksControllerState createState() => _TasksControllerState(this.id);
}

class _TasksControllerState extends State<TasksController>
    with SingleTickerProviderStateMixin {

  Future<List<ProjectTask>> _getProjectTasks() async {
    var data = await http.get(
        "http://studieplaneraren.pythonanywhere.com/api/tasks/${id}/");
    var jsonData = json.decode(data.body); //an array of json objects

    List<ProjectTask> alltasks = [];

    for (var JData in jsonData) {
      ProjectTask projecttask = ProjectTask(
          JData["id"],
          JData["description"],
          JData["state"],
          JData["assigned_users"],
          JData["subtasks"]
      );

      alltasks.add(projecttask);
    }
    return alltasks;
  }

  final int id;

  _TasksControllerState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder(
              future: _getProjectTasks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                else if(snapshot.data.length == 0) {
                    return Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: 420,
                        height: 40,
                        child: Text("Your teacher has not added anything for you to do!",
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
                      ),
                    );

                }

                else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {

                        if(snapshot.data[index].state == "new") {

                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>projectTask(snapshot.data[index], Colors.red)));
                          },
                          title: Text("${snapshot.data[index].description[0]
                              .toString()
                              .toUpperCase()}"
                              "${snapshot.data[index].description.toString()
                              .substring(1)}"),
                          subtitle: Text("task"),
                          trailing: Card(
                              elevation: 4,
                              color: Colors.red,
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    snapshot.data[index].state.toString()
                                        .toLowerCase(),
                                    style: TextStyle(color: Colors.white),
                                  )
                              )
                          ),
                        );
                      }
                      else if(snapshot.data[index].state == "started") {
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>projectTask(snapshot.data[index], Colors.blue)));
                            },
                            title: Text("${snapshot.data[index].description[0]
                                .toString()
                                .toUpperCase()}"
                                "${snapshot.data[index].description.toString()
                                .substring(1)}"),
                            subtitle: Text("task"),
                            trailing: Card(
                                elevation: 4,
                                color: Colors.blue,
                                child: Container(
                                    padding: EdgeInsets.all(6),
                                    child: Text(
                                      snapshot.data[index].state.toString()
                                          .toLowerCase(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                )
                            ),
                          );
                      }
                      else if(snapshot.data[index].state == "done") {
                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>projectTask(snapshot.data[index], Colors.green
                            )));
                          },
                          title: Text("${snapshot.data[index].description[0]
                              .toString()
                              .toUpperCase()}"
                              "${snapshot.data[index].description.toString()
                              .substring(1)}"),
                          subtitle: Text("task"),
                          trailing: Card(
                              elevation: 4,
                              color: Colors.green,
                              child: Container(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    snapshot.data[index].state.toString()
                                        .toLowerCase(),
                                    style: TextStyle(color: Colors.white),
                                  )
                              )
                          ),
                        );
                      }

                      }
                  );
              }
          )
      ),
    );
  }

}


class InformationController extends StatefulWidget {

  final Project project;
  InformationController(this.project);

  @override
  _InformationControllerState createState() => _InformationControllerState(this.project);
}

class _InformationControllerState extends State<InformationController> {

  final Project project;
  _InformationControllerState(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 20, bottom: 3),
                    child: Text("${project.title[0].toUpperCase()}${project.title.substring(1)}", style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500
                    ),),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text("Your deadline is in ${project.days_left}"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(project.description),
                    padding: EdgeInsets.only(bottom: 15, left: 20),
                  ),
                  Container(),
                  Container()
                ],
              ),
            ),
          ),



          Container()

        ],
      ),
    );
  }
}


