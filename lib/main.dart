import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Provider/HistoryProvider.dart';
import 'package:test_application/Provider/MemberProvider.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';
import 'package:test_application/Screen/PostScreen/PostScreen.dart';
import 'package:test_application/Screen/TerminationScreen/TerminationScreen.dart';

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
        ChangeNotifierProvider(create: (_) => TerminationNotiProvier()),
        ChangeNotifierProvider(create: (_) => PostNotiProvider())
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
  int _selectedIndex = 0;
  static const List<Widget> screens = <Widget>[
    PostScreen(),
    TerminationScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("패스파인더 알림톡"),
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 9,
              child: screens.elementAt(_selectedIndex),
            )
          ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
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
