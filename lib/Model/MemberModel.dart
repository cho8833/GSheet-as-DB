class Member {
  late String name;
  late String phoneNumber;
  late String expireDate;
  late String moveInType;

  Member(
      {required this.name,
      required this.phoneNumber,
      required this.expireDate,
      required this.moveInType});
  factory Member.fromData(List<String> data) {
    return Member(
        name: data[1],
        phoneNumber: data[3],
        expireDate: data[0],
        moveInType: data[2]);
  }
  factory Member.clone(Member data) {
    return Member(
        name: data.name,
        phoneNumber: data.phoneNumber,
        expireDate: data.expireDate,
        moveInType: data.moveInType);
  }
}
