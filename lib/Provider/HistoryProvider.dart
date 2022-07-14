import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:test_application/Constants/GsheetsAPIConfig.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Repository/HistoryRepository/GSheetsHistoryRepository.dart';

class HistoryProvider extends ChangeNotifier {
  List<History> historyList = [];
  final GSheetsHistoryRepository _repository = GSheetsHistoryRepository();
  Status status = Status.failed;

  HistoryProvider(Spreadsheet spreadsheet) {
    _repository.initialize(spreadsheet);
  }
  void addHistory(History history) {
    status = Status.loading;
    notifyListeners();

    _repository.appendData(history).then((result) {
      if (result) {
        status = Status.successed;
        notifyListeners();
      } else {
        status = Status.failed;
        notifyListeners();
      }
    });
  }
}
