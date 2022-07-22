import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Provider/MemberProvider.dart';
import 'package:test_application/Provider/PostNotiProvider.dart';
import '../../Model/MemberModel.dart';

class Post_InputDataWidget extends StatefulWidget {
  const Post_InputDataWidget({Key? key}) : super(key: key);

  @override
  State<Post_InputDataWidget> createState() => _Post_InputDataWidgetState();
}

class _Post_InputDataWidgetState extends State<Post_InputDataWidget> {
  TextEditingController senderTextController = TextEditingController();
  TextEditingController countTextController = TextEditingController();

  PostNoti inputData = PostNoti(
      member: Member(phoneNumber: '', name: ''), postCount: "", sender: "");
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 10, left: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<MemberProvider>(context, listen: false)
                            .queryByName(value);
                      },
                      decoration: const InputDecoration(
                        labelText: "입주자 정보 검색",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 60, 0),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Name",
                          style: Constants.itemTextStyle,
                        ),
                        Text(
                          "Phone",
                          style: Constants.itemTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Consumer<MemberProvider>(
                        builder: (__, provider, aa) => ListView.builder(
                            controller: ScrollController(),
                            itemCount: provider.queriedMemberList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                height: 60,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      inputData.member =
                                          provider.queriedMemberList[index];
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            provider.queriedMemberList[index]
                                                .name,
                                            style: Constants.itemTextStyle),
                                      ),
                                      Flexible(
                                        child: Text(
                                            provider.queriedMemberList[index]
                                                .phoneNumber,
                                            style: Constants.itemTextStyle),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 5, 10),
                alignment: const Alignment(0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        "Name: " + inputData.member.name,
                        style: Constants.itemTextStyle,
                      ),
                    ),
                    Flexible(
                      child: Text("Phone: " + inputData.member.phoneNumber,
                          style: Constants.itemTextStyle),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  alignment: const Alignment(0.0, 0.0),
                  child: TextField(
                      onChanged: (value) {
                        inputData.sender = value;
                      },
                      controller: senderTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "우편물 발신인"))),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                  
                  child: TextField(
                      onChanged: (value) {
                        inputData.postCount = value;
                      },
                      controller: countTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "우편물 개수"))),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: const Alignment(0.0, 0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 80),
                    maximumSize: const Size(500, 120),
                  ),
                  onPressed: () {
                    Provider.of<PostNotiProvider>(context, listen: false)
                        .addNoti(PostNoti.clone(inputData));
                  },
                  child: const Text("등록하기"),
                ),
              ),
            ),
          ],
        ));
  }
}
