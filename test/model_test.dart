import 'package:flutter_test/flutter_test.dart';
import 'package:maps/data/models/places_model.dart';

void main() {
  group("Places Model Test", () {
    PlusCodeModel p;
    p = PlusCodeModel();
    test("compoundCode Check", () {
      expect(p.compoundCode, null);
    });
    test("globalCode Check", () {
      expect(p.globalCode, null);
    });
  });
}
