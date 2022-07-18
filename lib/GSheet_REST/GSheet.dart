import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';

import 'package:test_application/GSheet_REST/GSheet_auth.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';

class GSheet {
  Future<AutoRefreshingAuthClient>? _client;

  Future<AutoRefreshingAuthClient> get client {
    _client = GSheet_auth.auth(client: _client);

    return _client!;
  }

  Future<void> close() async {
    final client = await _client;
    if (client == null) return;
    client.close();
    _client = null;
  }

  Future<Spreadsheet> getSpreadsheet(String spreadsheetID) async {
    final client = await this.client.catchError((_) {
      _client = null;
      return this.client;
    });
    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets/$spreadsheetID');
    return client.get(uri).then((value) {
      print(value.body);
      return Spreadsheet.fromJson(jsonDecode(value.body));
    });
  }

  Future<SheetData> allRows(Spreadsheet sheet, String name) async {
    final client = await this.client.catchError((_) {
      _client = null;
      return this.client;
    });
    int? column =
        sheet.getSheetsByName(name)?.properties?.gridProperties?.columnCount;
    int? row =
        sheet.getSheetsByName(name)?.properties?.gridProperties?.rowCount;
    late String colRange;
    try {
      colRange = String.fromCharCode(column! + 64);
    } catch (_) {
      colRange = String.fromCharCode(26);
    }
    String sheetID = sheet.spreadsheetId!;
    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets/$sheetID/values/A1:$colRange' + row.toString());
    return client.get(uri).then((value) {
      print(value.body);
      return SheetData.fromJson(jsonDecode(value.body));
    });

  }
}
