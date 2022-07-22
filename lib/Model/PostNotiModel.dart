import 'package:test_application/Model/NotifyModel.dart';

import 'MemberModel.dart';

class PostNoti extends NotifyModel {
  Member member;
  String postCount;
  String sender;

  PostNoti(
      {required this.member, required this.postCount, required this.sender});

  @override
  List<String> toRow() {
    return [
      member.phoneNumber,
      member.name,
      sender,
      postCount
    ];
  }

  factory PostNoti.clone(PostNoti data) {
    return PostNoti(
        member: Member.clone(data.member),
        postCount: data.postCount,
        sender: data.sender);
  }
}
