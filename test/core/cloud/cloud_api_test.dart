import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kashkool/core/cloud/cloud_api.dart';
import 'package:kashkool/core/cloud/cloud_session_store.dart';

http.Response jsonResponse(Object body, [int status = 200]) =>
    http.Response.bytes(utf8.encode(jsonEncode(body)), status, headers: {'content-type': 'application/json'});

const _session = CloudSession(accessToken: 'old-access', refreshToken: 'old-refresh', userId: 'u1', email: 'a@test.com');

void main() {
  test('login saves the session', () async {
    final store = MemoryCloudSessionStore();
    final api = CloudApi(store, baseUrl: 'https://api.test', client: MockClient((req) async {
      expect(req.url.path, '/v1/auth/google');
      expect(jsonDecode(req.body)['idToken'], 'google-token');
      return jsonResponse({
        'user': {'id': 'u1', 'email': 'a@test.com', 'name': 'A'},
        'accessToken': 'access',
        'refreshToken': 'refresh',
      });
    }));
    final session = await api.loginWithGoogle('google-token');
    expect(session.email, 'a@test.com');
    expect((await store.read())!.accessToken, 'access');
  });

  test('expired access token is refreshed once and the request retried', () async {
    final store = MemoryCloudSessionStore();
    await store.write(_session);
    final calls = <String>[];
    final api = CloudApi(store, baseUrl: 'https://api.test', client: MockClient((req) async {
      calls.add('${req.method} ${req.url.path} ${req.headers['Authorization'] ?? ''}');
      if (req.url.path == '/v1/auth/refresh') {
        return jsonResponse({'accessToken': 'new-access', 'refreshToken': 'new-refresh'});
      }
      if (req.headers['Authorization'] == 'Bearer old-access') return jsonResponse({'error': 'unauthorized'}, 401);
      return jsonResponse({'shops': []});
    }));

    expect(await api.listShops(), isEmpty);
    expect(calls, [
      'GET /v1/shops Bearer old-access',
      'POST /v1/auth/refresh ',
      'GET /v1/shops Bearer new-access',
    ]);
    expect((await store.read())!.refreshToken, 'new-refresh');
  });

  test('a rejected refresh token signs the user out', () async {
    final store = MemoryCloudSessionStore();
    await store.write(_session);
    final api = CloudApi(store, baseUrl: 'https://api.test', client: MockClient((req) async {
      return jsonResponse({'error': 'unauthorized'}, 401);
    }));
    await expectLater(api.listShops(), throwsA(isA<CloudApiException>().having((e) => e.code, 'code', 'signed_out')));
    expect(await store.read(), isNull);
  });

  test('server errors become Arabic messages', () async {
    final store = MemoryCloudSessionStore();
    await store.write(_session);
    final api = CloudApi(store, baseUrl: 'https://api.test', client: MockClient((req) async {
      return jsonResponse({'error': 'shop_id_taken', 'message': 'x'}, 409);
    }));
    await expectLater(
      api.registerShop(id: 's1', name: 'n', type: 'grocery'),
      throwsA(isA<CloudApiException>().having((e) => e.message, 'message', contains('حساب جوجل تاني'))),
    );
  });

  test('not signed in', () async {
    final api = CloudApi(MemoryCloudSessionStore(), baseUrl: 'https://api.test', client: MockClient((_) async => jsonResponse({})));
    await expectLater(api.listShops(), throwsA(isA<CloudApiException>().having((e) => e.code, 'code', 'signed_out')));
  });
}
