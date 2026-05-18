import 'dart:convert';
import 'package:cryptography/cryptography.dart';

class CryptoService {
  static final _algorithm = AesGcm.with256bits();

  static Future<SecretKey> deriveKey(String passphrase, String url) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 10000,
      bits: 256,
    );
    // Use the URL as salt to ensure consistent key derivation for the same server
    final salt = utf8.encode(url);
    return await pbkdf2.deriveKeyFromPassword(
      password: passphrase,
      nonce: salt,
    );
  }

  static Future<String> encrypt(String plaintext, SecretKey key) async {
    final content = utf8.encode(plaintext);
    final secretBox = await _algorithm.encrypt(
      content,
      secretKey: key,
    );
    return jsonEncode({
      'nonce': base64Encode(secretBox.nonce),
      'ciphertext': base64Encode(secretBox.cipherText),
      'mac': base64Encode(secretBox.mac.bytes),
    });
  }

  static Future<String> decrypt(String encryptedJson, SecretKey key) async {
    try {
      final Map<String, dynamic> data = jsonDecode(encryptedJson);
      if (!data.containsKey('ciphertext') ||
          !data.containsKey('nonce') ||
          !data.containsKey('mac')) {
        // Fallback for plaintext data (pre-E2EE migration)
        return encryptedJson;
      }

      final secretBox = SecretBox(
        base64Decode(data['ciphertext']),
        nonce: base64Decode(data['nonce']),
        mac: Mac(base64Decode(data['mac'])),
      );

      final cleartext = await _algorithm.decrypt(
        secretBox,
        secretKey: key,
      );
      return utf8.decode(cleartext);
    } catch (e) {
      // If it's not valid JSON, it might be legacy plaintext
      try {
        jsonDecode(encryptedJson);
        return encryptedJson;
      } catch (_) {
        rethrow;
      }
    }
  }
}
