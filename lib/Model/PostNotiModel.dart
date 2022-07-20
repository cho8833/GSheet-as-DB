import 'MemberModel.dart';

class PostNoti {
  Member member;
  String postCount;
  String sender;

  PostNoti(
      {required this.member, required this.postCount, required this.sender});
  static List<String> toRow(PostNoti noti) {
    return [
      noti.member.phoneNumber,
      noti.member.name,
      noti.sender,
      noti.postCount
    ];
  }

  factory PostNoti.clone(PostNoti data) {
    return PostNoti(
        member: Member.clone(data.member),
        postCount: data.postCount,
        sender: data.sender);
  }
}
