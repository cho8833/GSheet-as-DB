import 'package:googleapis_auth/auth_io.dart';
import 'package:test_application/Constants/GSheetsAPIConfig.dart';

class GSheet_auth {
  static Future<AutoRefreshingAuthClient> auth({
    required final Future<AutoRefreshingAuthClient>? client,
  }) {
    if (client != null) {
      return client;
    }
    ServiceAccountCredentials credentials =
        ServiceAccountCredentials.fromJson(GSheetsAPIConfig.credentials);
    return clientViaServiceAccount(credentials, GSheetsAPIConfig.scopes);
  }
}
