import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/utils/DbHelper.dart';
import 'package:todoapp/views/addTodo.dart';
import 'package:todoapp/views/todoList.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = DbHelper();

  void add(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void delete(int id) async {
    await db.deleteTodo(id);
    setState(() {});
  }

  void checked(int id, bool value) async {
    await db.isCheckedTodo(id, value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO App"),
      ),
      body: Column(
        children: [
          TodoList(
            deleteFunction: delete,
            isChecked: checked,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addTodo(insertFunction: add),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.red,
      ),
    );
  }
}
