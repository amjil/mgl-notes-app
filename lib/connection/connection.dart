// Conditional export: use the right connection factory per platform.
export 'unsupported.dart'
    if (dart.library.js) 'web.dart'
    if (dart.library.ffi) 'native.dart';
