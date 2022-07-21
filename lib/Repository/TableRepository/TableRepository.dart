import '../../Model/TerminationNotiModel.dart';

abstract class TableRepository {
  Future<String?> appendData(List notifies);
  Future<bool> deleteSheet();
}
