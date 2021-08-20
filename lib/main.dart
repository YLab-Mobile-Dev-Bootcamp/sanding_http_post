import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DataModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'HTTP POST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<DataModel?> submitData(String name, String job) async {
  var response = await http.post(Uri.https('reqres.in', 'api/users'), body: {
    "name": name,
    "job": job,
  });
  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    dataModelFromJson(responseString);
  } else
    return null;
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Masukkan Nama'),
              controller: nameController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Masukkan Pekerjaan'),
              controller: jobController,
            ),
            ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;

                  DataModel? data = await submitData(name, job);

                  setState(() {
                    _dataModel = data;
                  });
                },
                child: Text('Kirim')),
          ],
        ),
      ),
    );
  }
}
