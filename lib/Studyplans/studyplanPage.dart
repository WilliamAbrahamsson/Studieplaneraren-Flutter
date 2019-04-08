import 'package:studieplaneraren/main.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:studieplaneraren/main.dart';
import 'package:flutter/material.dart';

class StudyplanPage extends StatefulWidget {
  @override
  _StudyplanPageState createState() => _StudyplanPageState();
}

class _StudyplanPageState extends State<StudyplanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: StudyplanBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      )
    );
  }
}

class StudyplanBody extends StatefulWidget {
  @override
  _StudyplanBodyState createState() => _StudyplanBodyState();
}

class _StudyplanBodyState extends State<StudyplanBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

