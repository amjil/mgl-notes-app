import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'nomio_noop_url.dart'
    if (dart.library.html) 'nomio_web_url.dart' as web_url;

/// Small Dart boundary for platform APIs that are awkward to express in CLJD.
class NomioPlatform {
  NomioPlatform._();

  static final AppLinks _appLinks = AppLinks();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const WebOptions _webOptions =
      WebOptions(useSessionStorage: true, publicKey: 'NomioSession');
  static final StreamController<String> _links =
      StreamController<String>.broadcast();

  static StreamSubscription<Uri>? _linkSubscription;
  static bool _initialized = false;
  static String? _pendingInitialLink;

  static Stream<String> get links async* {
    final initial = _pendingInitialLink;
    _pendingInitialLink = null;
    if (initial != null) yield initial;
    yield* _links.stream;
  }

  /// Starts callback delivery early enough to catch cold-start links.
  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    final initial = await _appLinks.getInitialLink();
    if (initial != null) {
      _pendingInitialLink = initial.toString();
    }
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) => _links.add(uri.toString()),
      onError: _links.addError,
    );
  }

  static Future<bool> openAuthorizationUrl(String url) {
    final uri = Uri.parse(url);
    return launchUrl(
      uri,
      mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      webOnlyWindowName: kIsWeb ? '_self' : null,
    );
  }

  static Future<String?> readSecret(String key) {
    return _storage.read(key: key, webOptions: _webOptions);
  }

  static Future<void> writeSecret(String key, String value) {
    return _storage.write(key: key, value: value, webOptions: _webOptions);
  }

  static Future<void> deleteSecret(String key) {
    return _storage.delete(key: key, webOptions: _webOptions);
  }

  static String randomBase64Url(int byteCount) {
    final random = Random.secure();
    final bytes = List<int>.generate(byteCount, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  static String codeChallenge(String verifier) {
    return base64UrlEncode(sha256.convert(utf8.encode(verifier)).bytes)
        .replaceAll('=', '');
  }

  static String buildUrl(String base, Map<String, String> parameters) {
    final uri = Uri.parse(base);
    return uri.replace(queryParameters: parameters).toString();
  }

  static String authorizationUrl(
    String endpoint,
    String clientId,
    String redirectUri,
    String scope,
    String state,
    String challenge,
  ) {
    return buildUrl(endpoint, <String, String>{
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'scope': scope,
      'state': state,
      'code_challenge': challenge,
      'code_challenge_method': 'S256',
    });
  }

  static String authorizationCodeBody(
    String clientId,
    String code,
    String redirectUri,
    String verifier,
  ) {
    return formEncode(<String, String>{
      'grant_type': 'authorization_code',
      'client_id': clientId,
      'code': code,
      'redirect_uri': redirectUri,
      'code_verifier': verifier,
    });
  }

  static String refreshTokenBody(String clientId, String refreshToken) {
    return formEncode(<String, String>{
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    });
  }

  static String revokeTokenBody(String clientId, String refreshToken) {
    return formEncode(<String, String>{
      'client_id': clientId,
      'token': refreshToken,
      'token_type_hint': 'refresh_token',
    });
  }

  static void clearOAuthParameters() {
    web_url.clearOAuthParameters();
  }

  static String formEncode(Map<String, String> parameters) {
    return parameters.entries
        .map((entry) =>
            '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}')
        .join('&');
  }

  @visibleForTesting
  static Future<void> dispose() async {
    await _linkSubscription?.cancel();
    _linkSubscription = null;
    _initialized = false;
  }
}
