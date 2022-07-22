import 'package:test_application/Model/NotifyModel.dart';

import '../../Model/TerminationNotiModel.dart';

abstract class TableRepository {
  Future<String?> appendData(List<NotifyModel> notifies);
  Future<bool> deleteSheet();
  Future<String?> appendDataToHistory(List<NotifyModel> notifies);
}
