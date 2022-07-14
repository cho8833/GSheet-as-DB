import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:test_application/Repository/MemberRepository/GSheetsMemberRepository..dart';

import '../Model/MemberModel.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> memberList = [];
  final GSheetsMemberRepository _repository = GSheetsMemberRepository();

  MemberProvider(Spreadsheet spreadsheet) {
    _repository.initialize(spreadsheet);
    getAllMember();
  }
  void getAllMember() {
    _repository.getAllData().then((value) {
      memberList = value;
      notifyListeners();
    });
  }
}
