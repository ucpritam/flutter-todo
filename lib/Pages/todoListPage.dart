import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflitecurd/Pages/addTaskPage.dart';
import 'package:sqflitecurd/Resources/database.dart';
import 'package:sqflitecurd/models/taskModels.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:async/async.dart';

class ToDoHome extends StatefulWidget {
  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat("MMM dd, yy");

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseResource.instance.getTaskList();
    });
  }

  // _deleteToDo() {
  //   DatabaseResource.instance.deleteTask(widget.task.id);
  //   widget.updateTaskList();
  //   Navigator.pop(context);
  // }

  Widget _buildTasks(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: VStack([
        Card(
          elevation: 5,
          child: ListTile(
            title: Text(
              "${task.title}",
              style: TextStyle(
                fontSize: 18,
                decoration: task.status == 0
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              "${_dateFormatter.format(task.date)} • ${task.priorty}",
              style: TextStyle(
                fontSize: 14,
                decoration: task.status == 0
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
            trailing: HStack([
              GestureDetector(
                onTap: () => deleteToDo,
                child: Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.redAccent,
                ),
              ),
              Checkbox(
                onChanged: (value) {
                  task.status = value ? 1 : 0;
                  DatabaseResource.instance.updateTask(task);
                  _updateTaskList();
                },
                activeColor: Theme.of(context).accentColor,
                value: task.status == 1 ? true : false,
              ),
            ]),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddToDoPage(
                    updateTaskList: _updateTaskList,
                    task: task,
                  ),
                )),
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColorDark,
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddToDoPage(
              updateTaskList: _updateTaskList,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Card(
                child: CircularProgressIndicator().p8(),
              ),
            );
          }

          final int completedTaskCount = snapshot.data
              .where((Task task) => task.status == 1)
              .toList()
              .length;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 60),
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2),
                  child: Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: VStack(
                      [
                        "Things To Do".text.black.size(40).make().p8(),
                        SizedBox(height: 10),
                        "$completedTaskCount of ${snapshot.data.length}"
                            .text
                            .gray700
                            .size(20)
                            .fontWeight(FontWeight.w600)
                            .make()
                            .p8(),
                      ],
                      crossAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                );
              }
              return _buildTasks(snapshot.data[index - 1]);
            },
          );
        },
      ),
    );
  }
}
