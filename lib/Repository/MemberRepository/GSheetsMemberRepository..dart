import 'package:flutter/foundation.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Repository/MemberRepository/MemberRepository.dart';

import '../../Model/MemberModel.dart';

class GSheetsMemberRepository implements MemberRepository {
  Future<Spreadsheet>? _spreadsheet;

  Future<Spreadsheet> get spreadsheet {
    _spreadsheet ??= GSheetsAPIConfig.gSheet
        .getSpreadsheet(GSheetsAPIConfig.MEMBER_SPREAD_ID);

    return _spreadsheet!;
  }

  @override
  Future<List<Member>> getAllData() async {
    final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
      _spreadsheet = null;
      return this.spreadsheet;
    });
    Worksheet? worksheet = spreadsheet.getSheetsByIndex(0);

    if (worksheet != null) {
      return worksheet.allRows().then((value) {
        return value.values.map((e) => Member.fromData(e)).toList();
      });
    } else {
      return Future.error(Exception('no worksheet'));
    }
  }
}
