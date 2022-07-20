import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Provider/MemberProvider.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';

import '../../Model/MemberModel.dart';

class Post_InputDataWidget extends StatelessWidget {
  const Post_InputDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController senderTextController = TextEditingController();
    TextEditingController countTextController = TextEditingController();
    PostNoti inputData = PostNoti(
        member: Member(phoneNumber: '', name: ''), postCount: "", sender: "");

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
                    child: TextField(
                        onChanged: (value) {
                          Provider.of<MemberProvider>(context, listen: false)
                              .queryByName(value);
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: '이름 검색')),
                  ),
                  Expanded(
                    child: Consumer<MemberProvider>(
                      builder: (context, provider, child) => ListView.builder(
                          controller: ScrollController(),
                          itemCount: provider.queriedMemberList.length,
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
                                  inputData.member =
                                      provider.queriedMemberList[index];
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          provider.queriedMemberList[index]
                                              .phoneNumber,
                                          style: Constants.itemTextStyle),
                                      Text(
                                          provider
                                              .queriedMemberList[index].name,
                                          style: Constants.itemTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
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
                      onChanged: (value) {
                        inputData.sender = value;
                      },
                      controller: senderTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "우편물 발신인"))),
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
                      onChanged: (value) {
                        inputData.postCount = value;
                      },
                      controller: countTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "우편물 개수"))),
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
                  onPressed: () {
                    Provider.of<PostNotiProvider>(context,listen: false).addNoti(PostNoti.clone(inputData));
                  },
                  child: Text("등록하기"),
                ),
              ),
            ),
          ],
        ));
  }
}
