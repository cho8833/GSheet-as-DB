import 'package:flutter/foundation.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Repository/MemberRepository/GSheetsMemberRepository..dart';
import 'package:test_application/Repository/MemberRepository/MemberRepository.dart';

import '../Model/MemberModel.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> memberList = [];
  final MemberRepository _repository = GSheetsMemberRepository();
  
  void getAllMember() {
    _repository.getAllData().then((value) {
      memberList = value;
      notifyListeners();
    });
  }
}
