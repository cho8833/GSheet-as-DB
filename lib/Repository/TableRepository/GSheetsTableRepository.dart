import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';
import 'package:test_application/util/Util.dart';

import '../../Model/NotifyModel.dart';

class GSheetsTableRepository implements TableRepository {
  Future<Spreadsheet>? _spreadsheet;
  Future<Spreadsheet>? _historySpreadsheet;

  Future<Spreadsheet> get spreadsheet {
    _spreadsheet = GSheetsAPIConfig.gSheet.createSpreadsheet(Util.getDate());

    return _spreadsheet!;
  }

  Future<Spreadsheet> get historySpreadsheet {
    _historySpreadsheet ??= GSheetsAPIConfig.gSheet
        .getSpreadsheet(GSheetsAPIConfig.HISTORY_SPREAD_ID);
    return _historySpreadsheet!;
  }

  @override
  Future<String?> appendData(List<NotifyModel> notifies) async {
    final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
      _spreadsheet = null;
      return this.spreadsheet;
    });
    return spreadsheet.getSheetsByIndex(0)!.appendRow(generateFormat(notifies));
  }

  @override
  Future<String?> appendDataToHistory(List<NotifyModel> notifies) async {
    final Spreadsheet historySpreadsheet =
        await this.historySpreadsheet.catchError((_) {
      _historySpreadsheet = null;
      return this.historySpreadsheet;
    });
    return historySpreadsheet
        .getSheetsByIndex(0)!
        .appendRow(notifies.map((e) => e.toRow()).toList());
  }

  @override
  Future<bool> deleteSheet() async {
    if (_spreadsheet != null) {
      return _spreadsheet!.then((spreadsheet) => GSheetsAPIConfig.gSheet
              .deleteSpreadsheet(spreadsheet.spreadsheetId)
              .then((isSuccess) {
            return isSuccess;
          }));
    } else {
      return Future.error(Exception('failed deleting spreadsheet'));
    }
  }

  List<List<String>> generateFormat(List<NotifyModel> notifies) {
    List<List<String>> values = [];
    if (notifies[0] is TerminationNoti) {
      values.addAll([
        ['??????', '@???????????????'],
        ['????????? ??????', '??????????????? ?????????'],
        ['????????????', '#{??????}', '#{????????????}', '#{????????????_???_???}']
      ]);
      values.addAll(notifies.map((e) => e.toRow()));
      return values;
    } else {
      values.addAll([
        ['??????', '@???????????????'],
        ['????????? ??????', '???????????? ?????????'],
        ['????????????', '#{??????}', '#{????????? ?????????}', '#{????????? ??????}']
      ]);
      values.addAll(notifies.map((e) => e.toRow()));
      return values;
    }
  }
}
