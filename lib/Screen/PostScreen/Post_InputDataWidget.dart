import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/Constants.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
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
  final TextEditingController _receiverTextController = TextEditingController();
  final TextEditingController _contentsTextController = TextEditingController();

  PostNoti inputData = PostNoti(
      member: Member(phoneNumber: '', name: '', expireDate: "", moveInType: ""),
      postCount: "",
      sender: "");
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Name',
                          style: Constants.itemTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Phone',
                          style: Constants.itemTextStyle,
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Consumer<MemberProvider>(
                        builder: (__, provider, aa) {
                          if (provider.status == Status.failed) {
                            return const Center(
                                child: Text("connection failed"));
                          } else if (provider.status == Status.loading) {
                            return SpinKitRotatingPlain(
                              itemBuilder: ((context, index) {
                                return const DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.blue));
                              }),
                            );
                          } else {
                            return ListView.separated(
                                controller: ScrollController(),
                                itemCount: provider.queriedMemberList.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      thickness: 1,
                                    ),
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          inputData.member =
                                              provider.queriedMemberList[index];
                                          _receiverTextController.text =
                                              inputData.member.name;
                                          _contentsTextController.text =
                                              inputData.member.phoneNumber;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                provider
                                                    .queriedMemberList[index]
                                                    .name,
                                                style: Constants.listTextStyle),
                                          ),
                                          Flexible(
                                            child: Text(
                                                provider
                                                    .queriedMemberList[index]
                                                    .phoneNumber,
                                                style: Constants.listTextStyle),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
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
                margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                alignment: const Alignment(0.0, 0.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            inputData.member.name = value;
                          },
                          controller: _receiverTextController,
                          decoration: const InputDecoration(
                            labelText: "우편물 수신인",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        onChanged: (value) {
                          inputData.member.phoneNumber = value;
                        },
                        controller: _contentsTextController,
                        decoration: const InputDecoration(
                          labelText: "수신인 번호",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
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
