class History {
  late final String name;
  late final String phoneNumber;

  History({required this.name, required this.phoneNumber});
  factory History.fromData(List<String> data) {
    return History(name: data[0], phoneNumber: data[1]);
  }
  static List<String> toRow(History history) {
    return [history.name, history.phoneNumber];
  }
  
}
