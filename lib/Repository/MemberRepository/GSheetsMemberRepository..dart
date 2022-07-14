import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
import 'package:test_application/Repository/MemberRepository/MemberRepository.dart';

import '../../Model/MemberModel.dart';

class GSheetsMemberRepository implements MemberRepository {
  Spreadsheet? _spreadsheet;
  Worksheet? _worksheet;
  List<Member> memberList = [];

  void initialize(Spreadsheet spreadsheet) {
    _spreadsheet = spreadsheet;
    _worksheet =
        _spreadsheet?.worksheetByTitle(GSheetsAPIConfig.MEMBER_WORKSHEET_TITLE);
  }

  @override
  Future<List<Member>> getAllData() {
    if (_worksheet != null) {
      return _worksheet!.values.allRows().then((value) {
        return value.map((e) => Member.fromData(e)).toList();
      });
    } else {
      return Future.error(Exception('no worksheet'));
    }
  }
}