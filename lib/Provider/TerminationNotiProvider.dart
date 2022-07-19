import 'package:flutter/material.dart';
import 'package:test_application/Model/MemberModel.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';

class TerminationNotiProvier extends ChangeNotifier {
  final TableRepository _repository = GSheetsTableRepository();
  List<TerminationNoti> notifies = [];

  void addNoti(TerminationNoti noti) {
    notifies.add(noti);
  }

  void deleteNoti(int index) {
    notifies.removeAt(index);
  }

  void commit() {
    _repository.appendData(notifies).then((isSuccess) {
      notifyListeners();
    });
  }
}
