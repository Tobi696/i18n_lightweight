import 'package:flutter_test/flutter_test.dart';

import '../lib/i18n_lightweight.dart';

void main() {
  group("StringFormatter", () {
    test("Simple Test", () {
      expect(
        StringFormatter("Hello \$0!", ["Carl"]).formatted,
        "Hello Carl!",
      );
    });

    test("Two Parameters", () {
      expect(
        StringFormatter("Hello \$0! You are \$1 years old.", ["Carl", 16])
            .formatted,
        "Hello Carl! You are 16 years old.",
      );
    });

    test("Two Parameters, First used twice", () {
      expect(
        StringFormatter(
                "Hello \$0! You are \$1 years old. \$1 * 3 = 48", ["Carl", 16])
            .formatted,
        "Hello Carl! You are 16 years old. 16 * 3 = 48",
      );
    });

    test("Datetime", () {
      final then = DateTime(2001, 12, 24, 11, 30);
      expect(
        StringFormatter("Back then, the date was \$0", [then]).formatted,
        "Back then, the date was 2001-12-24 11:30:00.000",
      );
    });
  });

  group("ValueProvider", () {
    test("ValueProvider: Simple", () {
      expect(ValueProvider({"name": "Carl", "age": 16}, "name").value, "Carl");
      expect(ValueProvider({"name": "Carl", "age": 16}, "age").value, 16);
      expect(
        ValueProvider({"name": "Carl", "age": 16}, "non-existing").value,
        null,
      );
    });

    test("ValueProvider: Access Map", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": {"one": 100, "two": 200}
          }, "numbers")
              .value,
          {"one": 100, "two": 200});
    });

    test("ValueProvider: Access Element in Map string", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": {"one": 100, "two": 200}
          }, "numbers.two")
              .value,
          200);
    });

    test("ValueProvider: Access Element in Map numeric string", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": {"0": 100, "1": 200}
          }, "numbers.1")
              .value,
          200);
    });

    test("ValueProvider: Access Element in Map int", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": {1: 100, 2: 200}
          }, "numbers.1")
              .value,
          100);
    });

    test("ValueProvider: Access Array", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": [100, 200],
          }, "numbers")
              .value,
          [100, 200]);
    });

    test("ValueProvider: Access Element in Array", () {
      expect(
          ValueProvider({
            "name": "Carl",
            "age": 16,
            "numbers": [100, 200],
          }, "numbers.0")
              .value,
          100);
    });
  });
}
