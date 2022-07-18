class Spreadsheet {
  String? spreadsheetId;
  List<Sheets>? sheets;
  String? spreadsheetUrl;

  Spreadsheet({this.spreadsheetId, this.sheets, this.spreadsheetUrl});

  Spreadsheet.fromJson(Map<String, dynamic> json) {
    spreadsheetId = json['spreadsheetId'];
    if (json['sheets'] != null) {
      sheets = <Sheets>[];
      json['sheets'].forEach((v) {
        sheets!.add(new Sheets.fromJson(v));
      });
    }
    spreadsheetUrl = json['spreadsheetUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spreadsheetId'] = this.spreadsheetId;
    if (this.sheets != null) {
      data['sheets'] = this.sheets!.map((v) => v.toJson()).toList();
    }
    data['spreadsheetUrl'] = this.spreadsheetUrl;
    return data;
  }

  Sheets? getSheetsByName(String name) {
    return sheets?.firstWhere((element) => element.properties?.title == name);
  }

  Sheets? getSheetsByIndex(int index) {
    return sheets?.firstWhere((element) => element.properties?.index == index);
  }
}

class Sheets {
  Properties? properties;
  List<RowGroups>? rowGroups;

  Sheets({this.properties, this.rowGroups});

  Sheets.fromJson(Map<String, dynamic> json) {
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    if (json['rowGroups'] != null) {
      rowGroups = <RowGroups>[];
      json['rowGroups'].forEach((v) {
        rowGroups!.add(RowGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    if (rowGroups != null) {
      data['rowGroups'] = rowGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String? getName() {
    return properties?.title;
  }
}

class Properties {
  int? sheetId;
  String? title;
  int? index;
  String? sheetType;
  GridProperties? gridProperties;
  String? spreadsheetId;

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

class RowGroups {
  Range? range;
  int? depth;

  RowGroups({this.range, this.depth});

  RowGroups.fromJson(Map<String, dynamic> json) {
    range = json['range'] != null ? new Range.fromJson(json['range']) : null;
    depth = json['depth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.range != null) {
      data['range'] = this.range!.toJson();
    }
    data['depth'] = this.depth;
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

  SheetData.fromJson(Map<String, dynamic> json) {
    range = json['range'];
    majorDimension = json['majorDimension'];
    if (json['values'] != null) {
      values = <List<String>>[];
      json['values'].forEach((v) {
        values.add(List.from(v));
      });
    }
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
