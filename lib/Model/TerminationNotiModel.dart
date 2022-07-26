import 'package:test_application/Model/NotifyModel.dart';

import 'MemberModel.dart';

class TerminationNoti extends NotifyModel {
  Member member;
  
  TerminationNoti(
      {required this.member});

  @override
  List<String> toRow() {
    return [
      member.name,
      member.phoneNumber,
      member.expireDate,
      member.moveInType
    ];
  }

  factory TerminationNoti.clone(TerminationNoti data) {
    return TerminationNoti(
        member: Member.clone(data.member)
    );
  }
}
