import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class AddToDo extends StatefulWidget {
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _important;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat("MMM dd, yy");
  final List<String> _importance = ["Low", "Medium", "High"];

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _addTodo() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("$_title,$_date,$_important");
      //Update Todo List Page
      Navigator.pop(context);
    }
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
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                "Add ToDos".text.bold.size(40).make(),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: VStack([
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Task Title",
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        onTap: _handleDatePicker,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Date",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: DropdownButtonFormField(
                        isDense: true,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_rounded,
                        ),
                        iconSize: 22,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        items: _importance.map((String _important) {
                          return DropdownMenuItem(
                            value: _important,
                            child: _important.text.black.size(18).make(),
                          );
                        }).toList(),
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Priority",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (input) => _important == null
                            ? "Please Select your importance level"
                            : null,
                        onChanged: (value) {
                          _important = value;
                        },
                        value: _important,
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: _addTodo,
                      child: "Add".text.white.size(20).makeCentered()),
                ),
              ],
              crossAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
