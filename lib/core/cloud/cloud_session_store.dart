import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The signed-in cloud account and backup state on this phone.
class CloudSession {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String email;
  final String? name;

  /// Server shop this phone backs up to.
  final String? linkedShopId;

  /// When the last successful backup finished (shown to the user).
  final DateTime? lastBackupAt;

  /// When the last successful backup *started* (rows changed after this are uploaded next time).
  final DateTime? lastBackupStartedAt;

  const CloudSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
    this.name,
    this.linkedShopId,
    this.lastBackupAt,
    this.lastBackupStartedAt,
  });

  CloudSession copyWith({
    String? accessToken,
    String? refreshToken,
    String? linkedShopId,
    DateTime? lastBackupAt,
    DateTime? lastBackupStartedAt,
  }) {
    return CloudSession(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId,
      email: email,
      name: name,
      linkedShopId: linkedShopId ?? this.linkedShopId,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      lastBackupStartedAt: lastBackupStartedAt ?? this.lastBackupStartedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'userId': userId,
        'email': email,
        'name': name,
        'linkedShopId': linkedShopId,
        'lastBackupAt': lastBackupAt?.toIso8601String(),
        'lastBackupStartedAt': lastBackupStartedAt?.toIso8601String(),
      };

  factory CloudSession.fromJson(Map<String, dynamic> json) => CloudSession(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        userId: json['userId'] as String,
        email: json['email'] as String,
        name: json['name'] as String?,
        linkedShopId: json['linkedShopId'] as String?,
        lastBackupAt: DateTime.tryParse(json['lastBackupAt'] as String? ?? ''),
        lastBackupStartedAt: DateTime.tryParse(json['lastBackupStartedAt'] as String? ?? ''),
      );
}

/// Keeps the cloud session in the phone's secure storage (not in the app database,
/// so it is never included in local `.kashkool` backups or cloud uploads).
class CloudSessionStore {
  static const _key = 'kashkool_cloud_session_v1';
  final FlutterSecureStorage _storage;
  CloudSession? _cache;
  bool _loaded = false;

  CloudSessionStore([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  Future<CloudSession?> read() async {
    if (_loaded) return _cache;
    try {
      final raw = await _storage.read(key: _key);
      _cache = raw == null ? null : CloudSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _cache = null;
    }
    _loaded = true;
    return _cache;
  }

  Future<void> write(CloudSession session) async {
    _cache = session;
    _loaded = true;
    await _storage.write(key: _key, value: jsonEncode(session.toJson()));
  }

  Future<void> clear() async {
    _cache = null;
    _loaded = true;
    await _storage.delete(key: _key);
  }
}

/// In-memory store for tests.
class MemoryCloudSessionStore extends CloudSessionStore {
  CloudSession? _session;
  MemoryCloudSessionStore() : super();

  @override
  Future<CloudSession?> read() async => _session;

  @override
  Future<void> write(CloudSession session) async {
    _session = session;
  }

  @override
  Future<void> clear() async => _session = null;
}
