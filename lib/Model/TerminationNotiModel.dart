import 'MemberModel.dart';

class TerminationNoti {
  Member member;
  String moveInType;
  String date;
  TerminationNoti(
      {required this.member, required this.moveInType, required this.date});
  static List<String> toRow(TerminationNoti noti) {
    return [
      noti.member.phoneNumber,
      noti.member.name,
      noti.moveInType,
      noti.date
    ];
  }
}
