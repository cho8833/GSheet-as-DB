import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Provider/TerminationNotiProvider.dart';
import '../../Constants/Constants.dart';
import '../../Model/MemberModel.dart';

import '../../Provider/MemberProvider.dart';

class Termination_InputDataWidget extends StatefulWidget {
  const Termination_InputDataWidget({Key? key}) : super(key: key);

  @override
  State<Termination_InputDataWidget> createState() =>
      _Termination_InputDataWidgetState();
}

class _Termination_InputDataWidgetState
    extends State<Termination_InputDataWidget> {
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _typeTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  TerminationNoti inputData = TerminationNoti(
      member:
          Member(phoneNumber: '', name: '', expireDate: "", moveInType: ""));

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
                      child:
                          Consumer<MemberProvider>(builder: (__, provider, aa) {
                        if (provider.status == Status.failed) {
                          return const Center(child: Text("connection failed"));
                        } else if (provider.status == Status.loading) {
                          return const Center(child: Text("loading"));
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
                                        _phoneNumberTextController.text =
                                            inputData.member.phoneNumber;
                                        _nameTextController.text =
                                            inputData.member.name;
                                        _typeTextController.text =
                                            inputData.member.moveInType;
                                        _dateTextController.text =
                                            inputData.member.expireDate;
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
                                              style: Constants.listTextStyle),
                                        ),
                                        Flexible(
                                          child: Text(
                                              provider.queriedMemberList[index]
                                                  .phoneNumber,
                                              style: Constants.listTextStyle),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
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
                margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                alignment: const Alignment(0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            inputData.member.name = value;
                          },
                          controller: _nameTextController,
                          decoration: const InputDecoration(
                            labelText: "수신인",
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
                        controller: _phoneNumberTextController,
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
                        inputData.member.moveInType = value;
                      },
                      controller: _typeTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "입주 유형"))),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                  child: TextField(
                      onChanged: (value) {
                        inputData.member.expireDate = value;
                      },
                      controller: _dateTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "계약 종료 날짜"))),
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
