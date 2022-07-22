import 'package:flutter/material.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';
import 'package:test_application/util/Util.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TerminationNotiProvier extends ChangeNotifier {
  final TableRepository _repository = GSheetsTableRepository();
  List<TerminationNoti> notifies = [];

  void addNoti(TerminationNoti noti) {
    notifies.add(noti);
    notifyListeners();
  }

  void deleteNoti(int index) {
    notifies.removeAt(index);
    notifyListeners();
  }

  void commit() {
    _repository.appendData(notifies).then((spreadsheetId) async {
      if (spreadsheetId != null) {
        String url = Util.generateSheetDownloadUrl(spreadsheetId);
        if (await canLaunchUrlString(url)) {
          launchUrlString(url).then((isSuccess) {
            if (isSuccess) {
              _repository.appendDataToHistory(notifies);
            }
          });
        }
      }
      notifyListeners();
    });
  }
}
