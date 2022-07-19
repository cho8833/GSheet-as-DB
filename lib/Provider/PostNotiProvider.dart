import 'package:flutter/material.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';

import '../Model/PostNotiModel.dart';

class PostNotiProvider extends ChangeNotifier {
  List<PostNoti> notifies = [];
  final TableRepository _repository = GSheetsTableRepository();

  void addNoti(PostNoti noti) {
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
