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

  factory TerminationNoti.clone(TerminationNoti data) {
    return TerminationNoti(
        member: Member.clone(data.member),
        moveInType: data.moveInType,
        date: data.date);
  }
}
