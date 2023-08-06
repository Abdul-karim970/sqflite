import 'package:db/sqflite/student/db_helper.dart';
import 'package:db/sqflite/student/student.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController insertIdController;
  late TextEditingController insertNameController;
  late TextEditingController insertFeeController;

  List<Student> students = [
    Student('Ak', 0, 0.0),
    Student('Ak', 1, 0.0),
  ];

  @override
  void initState() {
    insertIdController = TextEditingController();
    insertNameController = TextEditingController();
    insertFeeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DBHelper dbHelper = DBHelper();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: insertIdController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: insertNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: insertFeeController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: students.length,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(students[index].name),
                    leading: Text(students[index].rollNo.toString()),
                    trailing: Text(students[index].fee.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            onPressed: () async {
              // dbHelper.insertStudent(Student('Ak', 7010, 650525));
              dbHelper.updateStudent(Student('Karim', 33, 333333), 2);
              // dbHelper.deleteStudent(33);
            },
          ),
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () async {
              List<Student> studentsList = await dbHelper.fetchStudent();
              setState(() {
                students = studentsList;
              });
              print(studentsList.length);
            },
          ),
        ],
      ),
    );
  }
}
/**FutureBuilder(
              builder: (context, snapshot) {
                var students = snapshot.data!;

                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(students[index].name),
                    leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text(
                          students[index].rollNo.toString(),
                          style: TextStyle(color: Colors.blueGrey.shade100),
                        )),
                    trailing: Text(
                      students[index].fee.toString(),
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                );
              },
              future: dbHelper.fetchStudents(),
            ) */