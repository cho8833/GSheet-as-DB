import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int color = 0;
  final itemTextStyle = TextStyle(fontSize: 20, color: Color(0xFF000000));
  String Hint1 = "우편물 발신인";
  String Hint2 = "우편물 개수";
  final List<String> names = <String>[
    '조영진',
    '조현빈',
    '강호동',
    '김문수',
    '조영진',
    '조현빈',
    '강호동',
    '김문수',
    '조영진',
    '조현빈',
    '강호동',
    '김문수',
    '조영진',
    '조현빈',
    '강호동',
    '김문수',
  ];
  final List<String> company = <String>[
    '카카오',
    '이상한컴퍼니',
    '천하장사컴퍼니',
    '도지사컴퍼니',
    '카카오',
    '이상한컴퍼니',
    '천하장사컴퍼니',
    '도지사컴퍼니',
    '카카오',
    '이상한컴퍼니',
    '천하장사컴퍼니',
    '도지사컴퍼니',
    '카카오',
    '이상한컴퍼니',
    '천하장사컴퍼니',
    '도지사컴퍼니',
  ];
  final List<String> phone = <String>[
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
    '010-9989-0285',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("패스파인더 알림톡"),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        Hint1 = "우편물 발신인";
                        Hint2 = "우편물 개수";
                      });
                    },
                    child: Text("우편물")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        Hint1 = "입구유형";
                        Hint2 = "계약종료 월/일";
                      });
                    },
                    child: Text("계약종료")),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '이름 검색')),
                          ),
                          Expanded(
                            child: ListView.builder(
                                controller: ScrollController(),
                                itemCount: names.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 1,
                                      ),
                                    ),
                                    height: 60,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          color = 0xff488ede;
                                        });
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${names[index]}",
                                                style: itemTextStyle),
                                            Text("${company[index]}",
                                                style: itemTextStyle),
                                            Text("${phone[index]}",
                                                style: itemTextStyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                    // child: Center(
                                    //   child: Text(
                                    //     '${names[index]} ${company[index]} ${phone[index]}',
                                    //     style: TextStyle(
                                    //         color: Colors.black,
                                    //         fontSize: 25,
                                    //         fontWeight: FontWeight.w400,
                                    //         letterSpacing: 2.0),
                                    //   ),
                                    // ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Text(""),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                        alignment: Alignment(0.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: Hint1))),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                        alignment: Alignment(0.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: Hint2))),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          maximumSize: const Size(200, 50),
                        ),
                        onPressed: () {},
                        child: Text("등록하기"),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Container(
              child: Column(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  child: Center(
                    child: Text(
                      "OutPut",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: ListView.builder(
                      controller: ScrollController(),
                      itemCount: names.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 1,
                            ),
                          ),
                          height: 50,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${names[index]}",
                                  style: itemTextStyle,
                                ),
                                Text("${company[index]}", style: itemTextStyle),
                                Text("${phone[index]}", style: itemTextStyle)
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          maximumSize: const Size(200, 50),
                        ),
                        onPressed: () {},
                        child: Text("구글시트 다운로드")),
                  ),
                ),
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
