import 'package:googleapis_auth/auth_browser.dart';
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

  static Future<AutoRefreshingAuthClient> obtainCredentials({
    required final Future<AutoRefreshingAuthClient>? client,
  }) async {
    if (client != null) {
      return client;
    }
    final flow = await createImplicitBrowserFlow(
        ClientId(GSheetsAPIConfig.clientId), GSheetsAPIConfig.scopes);
    try {
      return await flow.clientViaUserConsent();
    } finally {
      flow.close();
    }
  }
}
