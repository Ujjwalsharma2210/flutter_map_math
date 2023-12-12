import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_test/flutter_test.dart';

/// TESTS
void main() {
  test('find distance between', () {
    final calculator = FlutterMapMath();
    print(calculator.distanceBetween(
        37.4219999, -122.0840575, 37.4220011, -122.0866519, "meters"));
    print(calculator.bearingBetween(
        37.4219999, -122.0840575, 37.4220011, -122.0866519));
  });
}
