import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thrown when database encryption key operations fail in production.
class DatabaseEncryptionException implements Exception {
  final String message;
  final Object? cause;

  const DatabaseEncryptionException(this.message, [this.cause]);

  @override
  String toString() =>
      'DatabaseEncryptionException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Helper to generate, store, and retrieve the database encryption key.
class DatabaseEncryptionHelper {
  static const FlutterSecureStorage _defaultStorage = FlutterSecureStorage();
  static const _keyName = 'kashkool_db_encryption_key';
  static String? _cachedKey;
  static FlutterSecureStorage? _customStorageForTesting;

  /// Sets an explicit key for testing purposes.
  @visibleForTesting
  static void setKeyForTesting(String? key) {
    _cachedKey = key;
  }

  /// Injects a custom secure storage instance (e.g. mock) for testing.
  @visibleForTesting
  static void setStorageForTesting(FlutterSecureStorage? storage) {
    _customStorageForTesting = storage;
  }

  /// Clears the cached key and testing storage.
  @visibleForTesting
  static void resetForTesting() {
    _cachedKey = null;
    _customStorageForTesting = null;
  }

  /// Returns the encryption key for the database.
  /// If none exists, a cryptographically secure 256-bit key is generated and persisted.
  /// In release mode, failure to access secure storage strictly throws [DatabaseEncryptionException].
  static Future<String> getOrCreateKey({bool forceReleaseCheck = false}) async {
    if (_cachedKey != null) return _cachedKey!;

    final storage = _customStorageForTesting ?? _defaultStorage;

    try {
      final existingKey = await storage.read(key: _keyName);
      if (existingKey != null && existingKey.isNotEmpty) {
        _cachedKey = existingKey;
        return existingKey;
      }

      // Generate random 32-byte (256-bit) key
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      final newKey = base64Url.encode(values);

      await storage.write(key: _keyName, value: newKey);
      _cachedKey = newKey;
      return newKey;
    } catch (e) {
      if (kReleaseMode || forceReleaseCheck) {
        throw DatabaseEncryptionException(
          'Failed to securely retrieve or generate database encryption key.',
          e,
        );
      }
      // Fallback allowed ONLY for debug/test environments without keystore support
      const debugFallback = 'kashkool_debug_fallback_key_do_not_use_in_release';
      _cachedKey = debugFallback;
      return debugFallback;
    }
  }
}
