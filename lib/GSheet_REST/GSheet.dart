import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

import 'package:test_application/GSheet_REST/GSheet_auth.dart';
import 'package:test_application/GSheet_REST/Spreadsheet.dart';

class GSheet {
  Future<AutoRefreshingAuthClient>? _client;

  Future<AutoRefreshingAuthClient> get client {
    _client = GSheet_auth.obtainCredentials(client: _client) as Future<AutoRefreshingAuthClient>?;

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
      // check response
      return Spreadsheet.fromJson(json: jsonDecode(value.body), client: client);
    });
  }

  Future<Spreadsheet> createSpreadsheet(String title) async {
    final client = await this.client.catchError((_) {
      _client = null;
      return this.client;
    });
    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets');
    Map<String, dynamic> request = <String, dynamic>{};
    request['properties'] = {"title": "generateSheet"};
    return client.post(uri, body: jsonEncode(request)).then((response) {
      if (checkResponse(response)) {
        return Spreadsheet.fromJson(
            json: jsonDecode(response.body), client: client);
      } else {
        return Future.error(Exception("Error"));
      }
    });
  }
}

bool checkResponse(Response response) {
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
