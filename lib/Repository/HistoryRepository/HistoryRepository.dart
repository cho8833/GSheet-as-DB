import 'package:test_application/Model/HistoryModel.dart';

abstract class HistoryRepository {
  Future<String?> appendData(List<History> histories);
}
