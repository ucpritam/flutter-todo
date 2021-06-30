import 'package:flutter/material.dart';
import 'package:sqflitecurd/Pages/addTaskPage.dart';
import 'package:velocity_x/velocity_x.dart';

class ToDoHome extends StatefulWidget {
  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  Widget _buildTasks(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: VStack([
        ListTile(
          title: "ToDo Title".text.make(),
          subtitle: "july 5, 2021 • High".text.make(),
          trailing: Checkbox(
            onChanged: (value) {
              print(value);
            },
            activeColor: Theme.of(context).primaryColor,
            value: true,
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
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
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddToDo(),
            )),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 60),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2),
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                child: VStack(
                  [
                    "Thinks To Do".text.black.size(40).make().p8(),
                    SizedBox(height: 10),
                    ""
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
          return _buildTasks(index);
        },
      ),
    );
  }
}
