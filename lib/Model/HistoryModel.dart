class History {
  final String name;
  final String phoneNumber;
  final List<String> additionalInfo;

  History({required this.name, required this.phoneNumber, required this.additionalInfo});
  factory History.fromData(List<String> data) {
    return History(name: data[0], phoneNumber: data[1], additionalInfo: data.sublist(2));
  }
  static List<String> toRow(History history) {
    return [history.name, history.phoneNumber] + history.additionalInfo;
  }
}
