import 'package:flutter/material.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';

import '../Model/PostNotiModel.dart';

class PostNotiProvider extends ChangeNotifier {
  final List<PostNoti> _notifies = [];
  final TableRepository _repository = GSheetsTableRepository();

  void addNoti(PostNoti noti) {
    _notifies.add(noti);
    _notifies.forEach((element) {
      print(element.member.name +
          element.member.phoneNumber +
          element.sender +
          element.postCount);
    });
    notifyListeners();
  }

  List<PostNoti> get notifies => _notifies;
  
  void deleteNoti(int index) {
    _notifies.removeAt(index);
    notifyListeners();
  }

  void commit() {
    _repository.appendData(_notifies).then((isSuccess) {
      notifyListeners();
    });
  }
}
