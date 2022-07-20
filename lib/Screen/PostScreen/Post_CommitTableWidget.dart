import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';

class Post_CommitTableWidget extends StatefulWidget {
  const Post_CommitTableWidget({Key? key}) : super(key: key);

  @override
  State<Post_CommitTableWidget> createState() => _Post_CommitTableWidgetState();
}

class _Post_CommitTableWidgetState extends State<Post_CommitTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            child: Center(
              child: Text(
                "OutPut",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
            child: Consumer<PostNotiProvider>(
              builder: (context, provider, child) => ListView.builder(
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
                },
              ),
            ),
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
    );
  }
}