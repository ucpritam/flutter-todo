import 'package:flutter/material.dart';
import 'package:sqflitecurd/Pages/todoListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        primaryColorDark: Colors.redAccent,
        backgroundColor: Colors.white,
      ),
      home: ToDoHome(),
    );
  }
}
