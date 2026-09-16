// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

void clearOAuthParameters() {
  final uri = Uri.base;
  final parameters = Map<String, String>.from(uri.queryParameters)
    ..remove('code')
    ..remove('state')
    ..remove('error')
    ..remove('error_description');
  final clean = uri.replace(queryParameters: parameters.isEmpty ? null : parameters);
  html.window.history.replaceState(null, html.document.title, clean.toString());
}
