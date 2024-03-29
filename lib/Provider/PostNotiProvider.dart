import 'package:flutter/material.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/ScriptTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';
import 'package:test_application/util/Util.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Model/PostNotiModel.dart';

class PostNotiProvider extends ChangeNotifier {
  final List<PostNoti> _notifies = [];
  final ScriptRepository _repository = ScriptRepository();
  Status status = Status.idle;

  void addNoti(PostNoti noti) {
    _notifies.add(noti);
    notifyListeners();
  }

  List<PostNoti> get notifies => _notifies;

  void deleteNoti(int index) {
    _notifies.removeAt(index);
    notifyListeners();
  }

  void commit() {
    status = Status.loading;
    notifyListeners();

    List<List<String>> data = _notifies.map((e) => e.toRow()).toList();
    _repository.executePostProcess(data).then((value) {
      if (value != null) {
        status = Status.successed;
        launchUrlString(Util.generateSheetDownloadUrl(value));
      } else {
        status = Status.failed;
      }
      notifyListeners();
    });
  }
}
