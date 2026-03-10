// For ClojureDart: convert Iterable<dynamic> to List<String> for Drift .isIn (Iterable<String>).

List<String> stringListFrom(Iterable<dynamic> source) => List<String>.from(source);
