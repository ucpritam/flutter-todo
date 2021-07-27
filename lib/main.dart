import 'package:flutter/material.dart';
import 'package:sqflitecurd/Pages/todoListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //  accentColor: Colors.amber,
        primaryColor: Colors.green,
        primaryColorDark: Colors.redAccent,
        backgroundColor: Colors.white,
      ),
      home: ToDoHome(),
    );
  }
}
