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

  // @override
  // Future<List<Member>> getAllData() async {
  //   final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
  //     _spreadsheet = null;
  //     return this.spreadsheet;
  //   });
  //   Worksheet? worksheet = spreadsheet.getSheetsByIndex(0);

  //   if (worksheet != null) {
  //     return worksheet.allRows().then((value) {
  //       return value.values.map((e) => Member.fromData(e)).toList();
  //     });
  //   } else {
  //     return Future.error(Exception('no worksheet'));
  //   }
  // }
  @override
  Future<List<Member>> getAllMember() async {
    final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
      _spreadsheet = null;
      return this.spreadsheet;
    });
    Worksheet? worksheet =
        spreadsheet.getSheetsByName(GSheetsAPIConfig.MEMBER_WORKSHEET_TITLE);
    if (worksheet != null) {
      String columnRange =
          (worksheet.properties!.gridProperties!.columnCount!).toString();
      return worksheet.batchGet([
        "C6:C$columnRange",
        "D6:D$columnRange",
        "M6:M$columnRange",
        "G6:6$columnRange"
      ]).then((datas) {
        List<Member> result = [];
        for (int i = 0; i < datas[0].values.length; i++) {
          List<String> temp = [];
          for (int j = 0; j < 4; j++) {
            temp.add(datas[j].values[i][0]);
          }
          result.add(Member.fromData(temp));
        }
        return result;
      });
    } else {
      return Future.error(Exception("error getting all member"));
    }
  }
}
