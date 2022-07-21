import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Model/PostNotiModel.dart';
import 'package:test_application/Model/TerminationNotiModel.dart';
import 'package:test_application/Repository/TableRepository/TableRepository.dart';

class GSheetsTableRepository implements TableRepository {
  Future<Spreadsheet>? _spreadsheet;

  Future<Spreadsheet> get spreadsheet {
    _spreadsheet = GSheetsAPIConfig.gSheet.createSpreadsheet("generatedSheet");

    return _spreadsheet!;
  }

  @override
  Future<String?> appendData(List notifies) async {
    final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
      _spreadsheet = null;
      return this.spreadsheet;
    });
    return spreadsheet.getSheetsByIndex(0)!.appendRow(generateFormat(notifies));
  }

  Future<bool> deleteSheet() async {
    if (_spreadsheet != null) {
      return _spreadsheet!.then((spreadsheet) =>
        GSheetsAPIConfig.gSheet
            .deleteSpreadsheet(spreadsheet.spreadsheetId)
            .then((isSuccess) {
          return isSuccess;
        })
      );
    } 
    else {
      return Future.error(Exception('failed deleting spreadsheet'));
    }
  }

  List<List<String>> generateFormat(List notifies) {
    List<List<String>> values = [];
    if (notifies[0] is TerminationNoti) {
      values.addAll([
        ['채널', '@패스파인더'],
        ['템플릿 제목', '★계약종료 알림★'],
        ['수신번호', '#{이름}', '#{입주유형}', '#{계약종료_월_일}']
      ]);
      values.addAll(notifies.map((e) => TerminationNoti.toRow(e)));
      return values;
    } else {
      values.addAll([
        ['채널', '@패스파인더'],
        ['템플릿 제목', '★우편물 알림★'],
        ['수신번호', '#{이름}', '#{우편물 발신인}', '#{우편물 개수}']
      ]);
      values.addAll(notifies.map((e) => PostNoti.toRow(e)));
      return values;
    }
  }
}
