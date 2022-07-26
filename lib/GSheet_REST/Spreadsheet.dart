import 'dart:convert';

import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart';

class Spreadsheet {
  final String spreadsheetId;
  List<Worksheet> sheets;
  final String spreadsheetUrl;
  final AutoRefreshingAuthClient client;

  Spreadsheet(
      {required this.spreadsheetId,
      required this.sheets,
      required this.spreadsheetUrl,
      required this.client});

  factory Spreadsheet.fromJson(
      {required Map<String, dynamic> json,
      required AutoRefreshingAuthClient client}) {
    final String spreadsheetId = json['spreadsheetId'];
    final List<Worksheet> sheets = <Worksheet>[];
    final String spreadsheetUrl = json['spreadsheetUrl'];
    if (json['sheets'] != null) {
      json['sheets'].forEach((v) {
        sheets.add(Worksheet.fromJson(
            spreadsheetID: spreadsheetId, json: v, client: client));
      });
    }
    return Spreadsheet(
        spreadsheetId: spreadsheetId,
        sheets: sheets,
        spreadsheetUrl: spreadsheetUrl,
        client: client);
  }

  Worksheet? getSheetsByName(String name) {
    return sheets.firstWhere((element) => element.properties?.title == name);
  }

  Worksheet? getSheetsByIndex(int index) {
    return sheets.firstWhere((element) => element.properties?.index == index);
  }
}

class Worksheet {
  Properties? properties;
  final AutoRefreshingAuthClient client;
  String spreadsheetID;

  Worksheet(
      {required this.properties,
      required this.client,
      required this.spreadsheetID});

  factory Worksheet.fromJson(
      {required Map<String, dynamic> json,
      required AutoRefreshingAuthClient client,
      required String spreadsheetID}) {
    Properties? properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    return Worksheet(
        properties: properties, client: client, spreadsheetID: spreadsheetID);
  }

  Future<SheetData> allRows() async {
    int column = properties!.gridProperties!.columnCount!;
    int? row = properties?.gridProperties?.rowCount;

    String colRange = "";
    int carry = column ~/ 26;
    if (carry == 0) {
      colRange += String.fromCharCode(column + 64);
    } else {
      colRange += String.fromCharCode(carry + 64) +
          String.fromCharCode(column % 26 + 64);
    }

    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets/$spreadsheetID/values/A1:$colRange' +
            row.toString());
    return client.get(uri).then((value) {
      if (checkResponse(value)) {
        SheetData data = SheetData.fromJson(jsonDecode(value.body));
        return data;
      } else {
        return Future.error(Exception("error getting all Rows"));
      }
    });
  }

  Future<List<SheetData>> batchGet(List<String> ranges) {
    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets/$spreadsheetID/values:batchGet',
        queryParameters: {'ranges': ranges});
        
    return client.get(uri).then((response) {
      if (checkResponse(response)) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<SheetData> datas = [];
        body['valueRanges'].forEach((range) {
          datas.add(SheetData.fromJson(range));
        });
        return datas;
      } else {
        return Future.error(Exception("failed getting batch data"));
      }
    });
  }

  Future<String?> appendRow(List<List<String>> values) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'sheets.googleapis.com',
        path: '/v4/spreadsheets/$spreadsheetID/values/A1:append',
        queryParameters: {'valueInputOption': "RAW"});
    Map<String, dynamic> request = <String, dynamic>{};
    request['values'] = values;

    return client.post(uri, body: jsonEncode(request)).then((response) {
      if (checkResponse(response)) {
        return spreadsheetID;
      } else {
        return Future.error(Exception("error appending row"));
      }
    });
  }
}

class Properties {
  int? sheetId;
  String? title;
  int? index;
  String? sheetType;
  GridProperties? gridProperties;

  Properties({
    this.sheetId,
    this.title,
    this.index,
    this.sheetType,
    this.gridProperties,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    sheetId = json['sheetId'];
    title = json['title'];
    index = json['index'];
    sheetType = json['sheetType'];
    gridProperties = json['gridProperties'] != null
        ? GridProperties.fromJson(json['gridProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sheetId'] = sheetId;
    data['title'] = title;
    data['index'] = index;
    data['sheetType'] = sheetType;
    if (gridProperties != null) {
      data['gridProperties'] = gridProperties!.toJson();
    }
    return data;
  }
}

class GridProperties {
  int? rowCount;
  int? columnCount;
  bool? rowGroupControlAfter;

  GridProperties({this.rowCount, this.columnCount, this.rowGroupControlAfter});

  GridProperties.fromJson(Map<String, dynamic> json) {
    rowCount = json['rowCount'];
    columnCount = json['columnCount'];
    rowGroupControlAfter = json['rowGroupControlAfter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowCount'] = this.rowCount;
    data['columnCount'] = this.columnCount;
    data['rowGroupControlAfter'] = this.rowGroupControlAfter;
    return data;
  }
}

class Range {
  String? dimension;
  int? startIndex;
  int? endIndex;

  Range({this.dimension, this.startIndex, this.endIndex});

  Range.fromJson(Map<String, dynamic> json) {
    dimension = json['dimension'];
    startIndex = json['startIndex'];
    endIndex = json['endIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dimension'] = this.dimension;
    data['startIndex'] = this.startIndex;
    data['endIndex'] = this.endIndex;
    return data;
  }
}

class SheetData {
  String? range;
  String? majorDimension;
  List<List<String>> values = [];

  SheetData({this.range, this.majorDimension, required this.values});

  factory SheetData.fromJson(Map<String, dynamic> json) {
    SheetData data = SheetData(values: []);
    data.range = json['range'];
    data.majorDimension = json['majorDimension'];
    if (json['values'] != null) {
      data.values = <List<String>>[];
      json['values'].forEach((v) {
        data.values.add(List.from(v));
      });
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['range'] = this.range;
    data['majorDimension'] = this.majorDimension;
    if (this.values != null) {
      data['values'] = this.values;
    }
    return data;
  }
}

bool checkResponse(Response response) {
  if (response.statusCode == 200) {
    print(response.body);
    return true;
  } else {
    return false;
  }
}
