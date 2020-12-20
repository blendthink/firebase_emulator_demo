import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Emulator Suite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Local Emulator Suite Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TODO: databaseURL は自分のローカルのURLを指定する
  final _databaseReference = FirebaseDatabase(
    app: Firebase.app(),
    databaseURL: 'http://127.0.0.1:9000/?ns=fir-emulator-demo-48f2b',
  ).reference();

  void _addItem() {
    _databaseReference.push().set('add item');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FirebaseAnimatedList(
        query: _databaseReference.orderByKey(),
        padding: const EdgeInsets.all(8.0),
        reverse: false,
        itemBuilder: (_, snapshot, animation, x) {
          return ListTile(
            title: Text(snapshot.value.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
