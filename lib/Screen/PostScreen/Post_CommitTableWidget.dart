import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';


class Post_CommitTableWidget extends StatefulWidget {
  const Post_CommitTableWidget({Key? key}) : super(key: key);

  @override
  State<Post_CommitTableWidget> createState() => _Post_CommitTableWidgetState();
}

class _Post_CommitTableWidgetState extends State<Post_CommitTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
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
            children: const [
              Flexible(
                child: Text(
                  "Name",
                  style: Constants.itemTextStyle,
                ),
              ),
              Flexible(
                child: Text(
                  "Phone",
                  style: Constants.itemTextStyle,
                ),
              ),
              Flexible(
                child: Text(
                  "From",
                  style: Constants.itemTextStyle,
                ),
              ),
              Flexible(
                child: Text(
                  "Count",
                  style: Constants.itemTextStyle,
                ),
              ),
            ],
          ),
          Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(5)
              ),
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
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
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
            ),
          ),
        ],
      ),
    );
  }
}
