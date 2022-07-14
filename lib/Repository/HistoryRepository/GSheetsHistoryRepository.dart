import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Model/HistoryModel.dart';
import 'package:test_application/Repository/HistoryRepository/HistoryRepository.dart';

class GSheetsHistoryRepository implements HistoryRepository {
  Spreadsheet? _spreadsheet;
  Worksheet? _worksheet;

  void initialize(Spreadsheet spreadsheet) {
    _spreadsheet = spreadsheet;
    _worksheet = _spreadsheet
        ?.worksheetByTitle(GSheetsAPIConfig.HISTORY_WORKSHEET_TITLE);
  }

  @override
  Future<bool> appendData(History history) {
    if (_worksheet != null) {
      return _worksheet!.values.appendRow(History.toRow(history));
    } 
    else {
      return Future(
        () => false,
      );
    }
  }
}
