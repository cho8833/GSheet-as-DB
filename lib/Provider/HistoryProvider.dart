import 'package:flutter/foundation.dart';
import 'package:test_application/Constants/GsheetsAPIConfig.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Repository/HistoryRepository/GSheetsHistoryRepository.dart';
import 'package:test_application/Repository/HistoryRepository/HistoryRepository.dart';

class HistoryProvider extends ChangeNotifier {
  List<History> historyList = [];
  final HistoryRepository _repository = GSheetsHistoryRepository();
  Status status = Status.failed;

  void addHistory(History history) {
    status = Status.loading;
    notifyListeners();

    _repository.appendData([history]).then((result) {
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
