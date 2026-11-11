import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'cloud_config.dart';
import 'cloud_session_store.dart';
import '../../l10n/l10n.dart';

/// Error from the Kashkool backend (or the network), with an Arabic message for the user.
class CloudApiException implements Exception {
  final int? statusCode;
  final String code;
  final String message;
  const CloudApiException(this.code, this.message, {this.statusCode});

  @override
  String toString() => 'CloudApiException($code, $statusCode): $message';
}

class PullPage {
  final List<Map<String, dynamic>> changes;
  final int cursor;
  final bool hasMore;
  const PullPage(this.changes, this.cursor, this.hasMore);
}

/// Thin HTTP client for the Kashkool backend (see backend/README.md).
/// Refreshes the access token automatically once when it expires.
class CloudApi {
  final CloudSessionStore _store;
  final http.Client _http;
  final String _baseUrl;

  CloudApi(this._store, {http.Client? client, String? baseUrl})
      : _http = client ?? http.Client(),
        _baseUrl = baseUrl ?? CloudConfig.baseUrl;

  static const _timeout = Duration(seconds: 45);

  Future<dynamic> _send(String method, String path, {Object? body, bool auth = true, bool isRetry = false}) async {
    if (_baseUrl.isEmpty) {
      throw CloudApiException('not_configured', L10n.t.cloudApi1);
    }
    final headers = <String, String>{'Content-Type': 'application/json', 'Accept': 'application/json'};
    CloudSession? session;
    if (auth) {
      session = await _store.read();
      if (session == null) throw CloudApiException('signed_out', L10n.t.cloudApi2, statusCode: 401);
      headers['Authorization'] = 'Bearer ${session.accessToken}';
    }

    final request = http.Request(method, Uri.parse('$_baseUrl$path'))..headers.addAll(headers);
    if (body != null) request.body = jsonEncode(body);

    http.Response response;
    try {
      response = await http.Response.fromStream(await _http.send(request).timeout(_timeout));
    } on SocketException {
      throw CloudApiException('network', L10n.t.cloudApi3);
    } on TimeoutException {
      throw CloudApiException('timeout', L10n.t.cloudApi4);
    } on http.ClientException {
      throw CloudApiException('network', L10n.t.cloudApi3);
    }

    if (response.statusCode == 401 && auth && !isRetry) {
      await _refresh(session!);
      return _send(method, path, body: body, auth: auth, isRetry: true);
    }

    dynamic decoded;
    if (response.body.isNotEmpty) {
      try {
        decoded = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (_) {
        decoded = null;
      }
    }
    if (response.statusCode >= 400) {
      final code = decoded is Map ? (decoded['error'] as String? ?? 'error') : 'error';
      throw CloudApiException(code, _arabicMessage(code, response.statusCode), statusCode: response.statusCode);
    }
    return decoded;
  }

  Future<void> _refresh(CloudSession session) async {
    try {
      final res = await _send('POST', '/v1/auth/refresh', body: {'refreshToken': session.refreshToken}, auth: false) as Map;
      await _store.write(session.copyWith(
        accessToken: res['accessToken'] as String,
        refreshToken: res['refreshToken'] as String,
      ));
    } on CloudApiException catch (e) {
      if (e.statusCode == 401) {
        await _store.clear();
        throw CloudApiException('signed_out', L10n.t.cloudApi5, statusCode: 401);
      }
      rethrow;
    }
  }

  static String _arabicMessage(String code, int status) {
    switch (code) {
      case 'shop_id_taken':
        return L10n.t.cloudApi6;
      case 'subscription_required':
        return L10n.t.cloudApi7;
      case 'rate_limited':
        return L10n.t.cloudApi8;
      case 'unauthorized':
        return L10n.t.cloudApi9;
      case 'google_not_configured':
        return L10n.t.cloudApi10;
      case 'email_taken':
        return L10n.t.cloudApiEmailTaken;
      case 'invalid_credentials':
        return L10n.t.cloudApiInvalidCredentials;
    }
    if (status >= 500) return L10n.t.cloudApi11;
    return L10n.t.cloudApi12(code);
  }

  /// Exchanges a Google ID token for Kashkool tokens and saves the session.
  Future<CloudSession> loginWithGoogle(String idToken, {String? deviceLabel}) async {
    final res = await _send('POST', '/v1/auth/google',
        body: {'idToken': idToken, if (deviceLabel != null) 'deviceLabel': deviceLabel}, auth: false) as Map;
    final user = res['user'] as Map;
    final previous = await _store.read();
    final sameUser = previous?.userId == user['id'];
    final session = CloudSession(
      accessToken: res['accessToken'] as String,
      refreshToken: res['refreshToken'] as String,
      userId: user['id'] as String,
      email: user['email'] as String,
      name: user['name'] as String?,
      linkedShopId: sameUser ? previous?.linkedShopId : null,
      lastBackupAt: sameUser ? previous?.lastBackupAt : null,
      lastBackupStartedAt: sameUser ? previous?.lastBackupStartedAt : null,
    );
    await _store.write(session);
    return session;
  }

  Future<void> logout() async {
    final session = await _store.read();
    if (session != null) {
      try {
        await _send('POST', '/v1/auth/logout', body: {'refreshToken': session.refreshToken}, auth: false);
      } catch (_) {
        // Signing out locally still works offline.
      }
    }
    await _store.clear();
  }

  /// Permanently deletes the account and the cloud data of the shops it owns (Google Play
  /// account-deletion requirement). Data on this phone is not touched.
  Future<void> deleteAccount() async {
    await _send('DELETE', '/v1/me', body: {'confirm': 'DELETE'});
    await _store.clear();
  }

  Future<List<Map<String, dynamic>>> listShops() async {
    final res = await _send('GET', '/v1/shops') as Map;
    return (res['shops'] as List).cast<Map<String, dynamic>>();
  }

  /// Registers the local shop on the server (safe to call every time).
  Future<Map<String, dynamic>> registerShop({
    required String id,
    required String name,
    required String type,
    String? phone,
    String? address,
    String? shopCode,
  }) async {
    final res = await _send('POST', '/v1/shops', body: {
      'id': id,
      'name': name,
      'type': type,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (address != null && address.isNotEmpty) 'address': address,
      if (shopCode != null && RegExp(r'^[A-Za-z0-9]{4,12}$').hasMatch(shopCode)) 'shopCode': shopCode,
    }) as Map;
    return (res['shop'] as Map).cast<String, dynamic>();
  }

  /// Uploads up to 500 changes. Returns one result per change, in order.
  Future<List<Map<String, dynamic>>> push(String shopId, String deviceId, List<Map<String, dynamic>> changes) async {
    final res = await _send('POST', '/v1/shops/${Uri.encodeComponent(shopId)}/sync/push',
        body: {'deviceId': deviceId, 'changes': changes}) as Map;
    return (res['results'] as List).cast<Map<String, dynamic>>();
  }

  Future<PullPage> pull(String shopId, {int since = 0, int limit = 1000}) async {
    final res = await _send('GET', '/v1/shops/${Uri.encodeComponent(shopId)}/sync/pull?since=$since&limit=$limit') as Map;
    return PullPage(
      (res['changes'] as List).cast<Map<String, dynamic>>(),
      (res['cursor'] as num).toInt(),
      res['hasMore'] as bool,
    );
  }
}
