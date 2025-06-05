import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../models/todo.dart';

class addTodo extends StatelessWidget {
  var judulController = TextEditingController();
  var deskripsiController = TextEditingController();
  final Function insertFunction;

  addTodo({required this.insertFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 20.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text('TODO App')),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Judul',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: deskripsiController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Deskripsi',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    var todo = Todo(
                      judul: judulController.text,
                      deskripsi: deskripsiController.text,
                      isDone: false,
                    );
                    insertFunction(todo);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Tambah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
