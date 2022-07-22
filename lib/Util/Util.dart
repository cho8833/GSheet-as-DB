class Util {
  static String generateSheetDownloadUrl(String spreadsheetId) {
    return 'https://docs.google.com/spreadsheets/d/$spreadsheetId/export?format=xlsx&id=$spreadsheetId';
  }

  static String getDate() {
    DateTime now = DateTime.now();
    return now.year.toString() + now.month.toString() + now.day.toString();
  }
}