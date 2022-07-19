import '../../Model/TerminationNotiModel.dart';

abstract class TableRepository {
  Future<bool> appendData(List notifies);
}
