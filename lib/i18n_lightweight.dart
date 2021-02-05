library i18n_lightweight;

class StringFormatter {
  final String toFormat;
  final List<dynamic> values;

  const StringFormatter(this.toFormat, [this.values = const []]);

  String get formatted {
    if (toFormat == null) {
      return null;
    }
    String result = toFormat;
    for (int i = 0; i < values.length; ++i) {
      result = result.replaceAll("\$$i", values[i].toString());
    }
    return result;
  }
}

class ValueProvider {
  final Map<String, dynamic> map;
  final String key;

  ValueProvider(this.map, this.key);

  dynamic get value {
    dynamic result = map;
    List<String> keyParts = key.split(".");
    for (String part in keyParts) {
      int intKey = int.tryParse(part);
      result = (intKey != null ? result[intKey] : null) ?? result[part];
      if (result == null) break;
    }
    return result;
  }
}
