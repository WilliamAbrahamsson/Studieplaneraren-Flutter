import 'package:studieplaneraren/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:studieplaneraren/main.dart';
import 'package:flutter/material.dart';
import 'everyProjectPage.dart';

class projectTask extends StatefulWidget {

  final ProjectTask task;
  final Color appBarColor;
  projectTask(this.task, this.appBarColor);

  @override
  _projectTaskState createState() => _projectTaskState(this.task, this.appBarColor);
}

class _projectTaskState extends State<projectTask> {

  final ProjectTask task;
  final Color appBarColor;
  _projectTaskState(this.task, this.appBarColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(task.description, style: TextStyle(color: Colors.white),),
      )
    );
  }
}

