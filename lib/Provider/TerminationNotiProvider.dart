import 'package:flutter/material.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/ScriptTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';
import 'package:test_application/util/Util.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TerminationNotiProvier extends ChangeNotifier {
  final ScriptRepository _repository = ScriptRepository();
  List<TerminationNoti> notifies = [];
  Status status = Status.idle;
  void addNoti(TerminationNoti noti) {
    notifies.add(noti);
    notifyListeners();
  }

  void deleteNoti(int index) {
    notifies.removeAt(index);
    notifyListeners();
  }

  void commit() {
    status = Status.loading;
    notifyListeners();

    List<List<String>> data = notifies.map((e) => e.toRow()).toList();
    _repository.executeExpireProcess(data).then((spreadsheetId) {
      if (spreadsheetId != null) {
        status = Status.successed;
        launchUrlString(Util.generateSheetDownloadUrl(spreadsheetId));
      } else {
        status = Status.failed;
      }
      notifyListeners();
    });
  }
}
