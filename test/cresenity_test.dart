import 'package:flutter_test/flutter_test.dart';

import 'package:cresenity/cresenity.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Cresenity();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });
}
