import 'package:test_application/Model/NotifyModel.dart';

import 'MemberModel.dart';

class TerminationNoti extends NotifyModel {
  Member member;
  String moveInType;
  String date;
  TerminationNoti(
      {required this.member, required this.moveInType, required this.date});

  @override
  List<String> toRow() {
    return [
      member.phoneNumber,
      member.name,
      moveInType,
      date
    ];
  }

  factory TerminationNoti.clone(TerminationNoti data) {
    return TerminationNoti(
        member: Member.clone(data.member),
        moveInType: data.moveInType,
        date: data.date);
  }
}
