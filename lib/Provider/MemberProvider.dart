import 'package:flutter/foundation.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Repository/MemberRepository/GSheetsMemberRepository..dart';
import 'package:test_application/Repository/MemberRepository/MemberRepository.dart';

import '../Model/MemberModel.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> memberList = [];
  final MemberRepository _repository = GSheetsMemberRepository();
  List<Member> queriedMemberList = [];
  Status status = Status.idle;

  MemberProvider() {
    getAllMember();
  }

  void queryByName(String name) {
    List<Member> result = [];
    for (var element in memberList) {
      if (element.name.contains(name)) {
        result.add(element);
      }
    }
    queriedMemberList = result;
    notifyListeners();
  }

  void getAllMember() {
    status = Status.loading;
    notifyListeners();

    _repository.getAllMember().then((value) {
      memberList = value;
      queriedMemberList = memberList;
      status = Status.successed;
      notifyListeners();

    }).catchError((_) {
      status = Status.failed;
      notifyListeners();
    });
  }
}
