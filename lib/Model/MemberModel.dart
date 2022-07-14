class Member {
  late final String name;
  late final String phoneNumber;

  Member({required this.name, required this.phoneNumber});
  factory Member.fromData(List<String> data) {
    return Member(name: data[0], phoneNumber: data[1]);
  }
}
