import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future share = SharedPreferences.getInstance() as SharedPreferences;
  Map counter = {"React": 0, "Flutter": 10, "Web": 20};

  var count = 0;

  setSharepreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      count++;
    });
    pref.setInt("count", count);
  }

  getSharepreference() async{
     SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      count = pref.getInt("count")??0;
    });
  }

  @override
  void initState() {
    getSharepreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sharepreference"),
        ),
        body: Column(children: [
          Column(
            children: counter
                .map((key, value) => MapEntry(
                    key,
                    Container(
                      child: Text(value.toString()),
                    )))
                .values
                .toList(),
          ),
          RaisedButton(
              child: Text("click"),
              onPressed: (){
                setState(() {
                  counter["React"]++;
                });
          }),
          Text("$count"),
          RaisedButton(onPressed: (){
            setSharepreference();
          })
        ]),
      ),
    );
  }
}
