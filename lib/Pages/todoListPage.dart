import 'package:flutter/material.dart';
import 'package:sqflitecurd/Pages/addTaskPage.dart';
import 'package:sqflitecurd/Resources/database.dart';
import 'package:sqflitecurd/models/taskModels.dart';
import 'package:velocity_x/velocity_x.dart';

class ToDoHome extends StatefulWidget {
  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  Future<List<Task>> _taskList;

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
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            trailing: HStack([
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
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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

          return ListView.builder(
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2),
                  child: Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
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
