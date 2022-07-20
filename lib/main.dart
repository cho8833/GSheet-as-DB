import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Provider/HistoryProvider.dart';
import 'package:test_application/Provider/MemberProvider.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';
import 'package:test_application/Provider/StatusProvider.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';
import 'package:test_application/Screen/PostScreen/PostScreen.dart';

import 'package:test_application/Screen/SelectScreenWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider()),
      ], child: const MyHomePage(title: 'Flutter Demo Home Page')),
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
  int color = 0;
  final itemTextStyle = TextStyle(fontSize: 20, color: Color(0xFF000000));
  String additionalInputHint1 = "우편물 발신인";
  String additionalInputHint2 = "우편물 개수";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("패스파인더 알림톡"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => StatusProvider(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Flexible(
                flex: 9,
                child: PostScreen(),
              )
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            
            label: Constants.postButtonTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: Constants.terminationButtonTitle,
          )
        ],
      ),
    );
  }
}
