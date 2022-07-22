import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        const Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              "구글시트 미리보기",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Name",
              style: Constants.itemTextStyle,
            ),
            Text(
              "Phone",
              style: Constants.itemTextStyle,
            ),
            Text(
              "From",
              style: Constants.itemTextStyle,
            ),
            Text(
              "Count",
              style: Constants.itemTextStyle,
            ),
          ],
        ),
        Flexible(
          flex: 7,
          fit: FlexFit.tight,
          child: Container(
            child: Consumer<PostNotiProvider>(
              builder: (context, provider, child) => ListView.builder(
                controller: ScrollController(),
                itemCount: provider.notifies.length,
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
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              provider.notifies[index].member.phoneNumber,
                              style: Constants.itemTextStyle,
                            ),
                          ),
                          Flexible(
                            child: Text(provider.notifies[index].member.name,
                                style: Constants.itemTextStyle),
                          ),
                          Flexible(
                            child: Text(provider.notifies[index].sender,
                                style: Constants.itemTextStyle),
                          ),
                          Flexible(
                            child: Text(provider.notifies[index].postCount,
                                style: Constants.itemTextStyle),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                provider.deleteNoti(index);
                              },
                              child: Text("삭제"))
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
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 80),
                        maximumSize: const Size(500, 100),
                      ),
                      onPressed: () {
                        Provider.of<PostNotiProvider>(context, listen: false)
                            .commit();
                      },
                      child: Text("구글시트 다운로드")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
