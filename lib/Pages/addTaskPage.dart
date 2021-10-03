import 'package:flutter/material.dart';
import 'package:sqflitecurd/Resources/database.dart';
import 'package:sqflitecurd/models/taskModels.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToDoPage extends StatefulWidget {
  final Function updateTaskList;
  final Task task;
  AddToDoPage({this.updateTaskList, this.task});

  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _title = widget.task.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _addTodo() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Task task = Task(title: _title);
      if (widget.task == null) {
        task.status = 0;
        DatabaseResource.instance.insertTask(task);
      } else {
        task.id = widget.task.id;
        task.status = widget.task.status;
        DatabaseResource.instance.updateTask(task);
      }
      widget.updateTaskList();
      Navigator.pop(context);
    }
  }

  void deleteToDo() {
    DatabaseResource.instance.deleteTask(widget.task.id);
    widget.updateTaskList();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: VStack(
              [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: widget.task == null
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.task == null ? " Add To Do" : "Update To Do",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: VStack([
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Task",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? "Please enter a Task Title"
                            : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.task == null
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                    onPressed: _addTodo,
                    child: Text(
                      widget.task == null ? "Add" : "Update",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                widget.task != null
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                            onPressed: deleteToDo,
                            child: Text(
                              "Delete",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      )
                    : SizedBox.shrink(),
              ],
              crossAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
