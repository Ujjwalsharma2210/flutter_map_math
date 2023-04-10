import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_geo_math/flutter_geo_math.dart';

void main() {
  test('find distance between', () {
    final calculator = FlutterGeoMath();
    print(calculator.distanceBetween(
        37.4219999, -122.0840575, 37.4220011, -122.0866519, "meters"));
  });
}
