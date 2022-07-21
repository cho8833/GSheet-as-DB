import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';
import '../../Constants/Constants.dart';
import '../../Model/MemberModel.dart';

import '../../Model/PostNotiModel.dart';
import '../../Provider/MemberProvider.dart';

class Termination_InputDataWidget extends StatefulWidget {
  const Termination_InputDataWidget({Key? key}) : super(key: key);

  @override
  State<Termination_InputDataWidget> createState() =>
      _Termination_InputDataWidgetState();
}

class _Termination_InputDataWidgetState
    extends State<Termination_InputDataWidget> {
  TextEditingController senderTextController = TextEditingController();
  TextEditingController countTextController = TextEditingController();

  TerminationNoti inputData = TerminationNoti(
      member: Member(phoneNumber: '', name: ''), moveInType: "", date: "");

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
                      builder: (__, provider, aa) => ListView.builder(
                          controller: ScrollController(),
                          itemCount: provider.queriedMemberList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
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
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            provider
                                                .queriedMemberList[index].name,
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
                  alignment: const Alignment(0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      inputData.member.name,
                      style: Constants.itemTextStyle,
                    ),
                  ),
                  Flexible(
                    child: Text(inputData.member.phoneNumber,
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
                  alignment: Alignment(0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                      onChanged: (value) {
                        inputData.moveInType = value;
                      },
                      controller: senderTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "입주유형"))),
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
                        inputData.date = value;
                      },
                      controller: countTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "계약종료_월/일"))),
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
                    Provider.of<TerminationNotiProvier>(context, listen: false)
                        .addNoti(TerminationNoti.clone(inputData));
                  },
                  child: const Text("등록하기"),
                ),
              ),
            ),
          ],
        ));
  }
}
