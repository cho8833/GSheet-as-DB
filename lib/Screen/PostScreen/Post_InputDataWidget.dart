import 'package:flutter/material.dart';

class Post_InputDataWidget extends StatelessWidget {
  const Post_InputDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const TextField(
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
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                          );
                        }),
                  )
                ],
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
                          labelText: additionalInputHint1))),
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
                          labelText: additionalInputHint2))),
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
        ));
  }
}
