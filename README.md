# Map related Calculations Package for Flutter

This package provides a set of utility classes and functions for performing map-related calculations in a Flutter application.

## Installation

To use this package, add map_calculation as a dependency in your '**pubspec.yaml**' file:

```
    dependencies:
        flutter_geo_math: ^1.0.0
```

Then, run '**flutter pub get**' to install the package.

## Usage

Import the map_calculation package in your Dart code:

```dart
import 'package:map_calculation/map_calculation.dart';
```

### Calculating Distance Between Two Points

You can use the '**distanceBetween**' function to calculate the distance between two points on a map. The function takes five arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point and the units you want the distance in.

```dart
double distance = MapCalculation.distanceBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
    "meters"
);
```

Available return units are : meters, kilometers, yards and miles. Replace the **meters** from above example to your required units.

### Calculating Bearing Between Two Points

You can use the '**bearingBetween**' function to calculate the bearing between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns the bearing in degrees.

```dart
double bearing = MapCalculation.bearingBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
);
```

### Calculating Destination Point

You can use the '**destinationPoint**' function to calculate the destination point from a starting point, given a distance and a bearing. The function takes three arguments: the latitude and longitude of the starting point, the distance in meters, and the bearing in degrees. The function returns a LatLng object representing the destination point.

```dart
LatLng startingPoint = LatLng(37.4219999, -122.0840575);
double distance = 1000;
double bearing = 90;
LatLng destinationPoint = MapCalculation.destinationPoint(startingPoint, distance, bearing);
```

### Calculating Midpoint Between Two Points

You can use the '**midpointBetween**' function to calculate the midpoint between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns a LatLng object representing the midpoint.

```dart
LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = MapCalculation.midpointBetween(point1, point2);
```

## Contributing

We welcome contributions to this package. If you have an idea for a new feature or improvement, please open an issue on our <a href="https://github.com/Ujjwalsharma2210/flutter_geo_math" target="_blank">GitHub repository</a>. If you would like to contribute code, please fork the repository and submit a pull request. All contributions must adhere to our [code of conduct](https://github.com/Ujjwalsharma2210/flutter_geo_math/blob/main/CODE_OF_CONDUCT.md).

## License

This package is released under the <a href="https://opensource.org/license/mit/" target="_blank">MIT license</a>. See the <a href="https://github.com/Ujjwalsharma2210/flutter_geo_math/blob/main/LICENSE" target="_blank">LICENSE</a> file for details.
