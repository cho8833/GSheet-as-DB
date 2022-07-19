import 'package:test_application/Model/HistoryModel.dart';

abstract class HistoryRepository {
  Future<bool> appendData(List<History> histories);
}
