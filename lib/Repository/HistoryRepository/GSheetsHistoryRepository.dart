import 'package:flutter/material.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Repository/HistoryRepository/HistoryRepository.dart';

class GSheetsHistoryRepository implements HistoryRepository {
  Future<Spreadsheet>? _spreadsheet;

  Future<Spreadsheet> get spreadsheet {
    _spreadsheet ??= GSheetsAPIConfig.gSheet
        .getSpreadsheet(GSheetsAPIConfig.HISTORY_SPREAD_ID);
    return _spreadsheet!;
    
  }

  @override
  Future<bool> appendData(List<History> histories) async {
    final Spreadsheet spreadsheet = await this.spreadsheet.catchError((_) {
      _spreadsheet = null;
      return this.spreadsheet;
    });
    Worksheet? worksheet = spreadsheet.getSheetsByIndex(0);

    if (worksheet != null) {
      List<List<String>> data = histories.map((e) => History.toRow(e)).toList();
      return worksheet.appendRow(data);
    } else {
      return Future(
        () => false,
      );
    }
  }
}
