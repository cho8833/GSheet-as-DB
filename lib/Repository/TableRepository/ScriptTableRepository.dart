import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';
class ScriptRepository {
  final String scriptId =
      "AKfycbyJqzlfabAau0MTC6PsPWDrjX_jVmqgedE5ou7n7Ig3Ng0_rQcyjFGzPIPxJqHzFoYM";
  final String postFunctionName = "MakePostAndHistory";
  final String expireFunctionName = "MakeTermination";
  final String spreadsheetId = "1yOjT4GgLxK2FgrNsHZk8vuOYqeIEi3VslFW4qd-_DDQ";
  Future<String?> executePostProcess(List<List<String>> values) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'script.googleapis.com',
        path: '/v1/scripts/$scriptId:run');
    Map<String, dynamic> request = {
      "function": postFunctionName,
      "parameters": [spreadsheetId, values],
    };

    var client = await GSheetsAPIConfig.gSheet.client;
    return client.post(uri, body: jsonEncode(request)).then((response) {
      if (checkResponse(response)) {
        Map<String, dynamic> result = jsonDecode(response.body);
        return result['response']['result'];
      } 
      else {
        return Future.error(Exception('error executing Post Process'));
      }
    });
  }

  Future<String?> excuteExireProcess(List<List<String>> values) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'script.googleapis.com',
        path: '/v1/scripts/$scriptId:run');
    Map<String, dynamic> request = {
      "function": expireFunctionName,
      "parameters": [spreadsheetId, values]
    };
    var client = await GSheetsAPIConfig.gSheet.client;
    return client.post(uri, body: jsonEncode(request)).then((response) {
      if (checkResponse(response)) {
        Map<String, dynamic> result = jsonDecode(response.body);
        return result['response']['result'];
      } else {
        return Future.error(Exception('error executing Expire Process'));
      }
    });
  }

  bool checkResponse(Response response) {
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
