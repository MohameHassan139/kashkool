import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Helper to generate, store, and retrieve the SQLCipher database encryption key.
class DatabaseEncryptionHelper {
  static const _storage = FlutterSecureStorage();
  static const _keyName = 'kashkool_db_encryption_key';
  static String? _cachedKey;

  /// Returns the encryption key for SQLCipher.
  /// If none exists, a cryptographically secure 256-bit key is generated and persisted.
  static Future<String> getOrCreateKey() async {
    if (_cachedKey != null) return _cachedKey!;

    try {
      final existingKey = await _storage.read(key: _keyName);
      if (existingKey != null && existingKey.isNotEmpty) {
        _cachedKey = existingKey;
        return existingKey;
      }

      // Generate random 32-byte (256-bit) key
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      final newKey = base64Url.encode(values);

      await _storage.write(key: _keyName, value: newKey);
      _cachedKey = newKey;
      return newKey;
    } catch (_) {
      // Fallback for environments without secure storage (e.g. testing)
      const fallback = 'kashkool_local_fallback_key_2026';
      _cachedKey = fallback;
      return fallback;
    }
  }
}
