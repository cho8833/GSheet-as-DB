import 'package:flutter/material.dart';
import 'package:test_application/Repository/TableRepository/GSheetsTableRepository.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Constants/Constants.dart';
import '../Model/PostNotiModel.dart';

class PostNotiProvider extends ChangeNotifier {
  final List<PostNoti> _notifies = [];
  final TableRepository _repository = GSheetsTableRepository();

  void addNoti(PostNoti noti) {
    _notifies.add(noti);
    _notifies.forEach((element) {
    });
    notifyListeners();
  }

  List<PostNoti> get notifies => _notifies;

  void deleteNoti(int index) {
    _notifies.removeAt(index);
    notifyListeners();
  }

  void commit() {
    _repository.appendData(_notifies).then((spreadsheetId) async {
      if (spreadsheetId != null) {
        String url = Constants.generateSheetDownloadUrl(spreadsheetId);
        if (await canLaunchUrlString(url)) {
          launchUrlString(url);
        }
      }
      notifyListeners();
    });
  }
}
