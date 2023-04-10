<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

# Map Calculation Package for Flutter

This package provides a set of utility classes and functions for performing map-related calculations in a Flutter application.

## Installation

To use this package, add map_calculation as a dependency in your '**pubspec.yaml**' file:

'''
dependencies:
map_calculation: ^1.0.0
'''

Then, run flutter pub get to install the package.

## Usage

Import the map_calculation package in your Dart code:

'''dart
import 'package:map_calculation/map_calculation.dart';
'''

### Calculating Distance Between Two Points

You can use the distanceBetween function to calculate the distance between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns the distance in meters.

'''dart
double distance = MapCalculation.distanceBetween(
37.4219999,
-122.0840575,
37.4220011,
-122.0866519,
);
'''

### Calculating Bearing Between Two Points

You can use the bearingBetween function to calculate the bearing between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns the bearing in degrees.

'''dart
double bearing = MapCalculation.bearingBetween(
37.4219999,
-122.0840575,
37.4220011,
-122.0866519,
);
'''

### Calculating Destination Point

You can use the destinationPoint function to calculate the destination point from a starting point, given a distance and a bearing. The function takes three arguments: the latitude and longitude of the starting point, the distance in meters, and the bearing in degrees. The function returns a LatLng object representing the destination point.

'''dart
LatLng startingPoint = LatLng(37.4219999, -122.0840575);
double distance = 1000;
double bearing = 90;
LatLng destinationPoint = MapCalculation.destinationPoint(startingPoint, distance, bearing);
'''

### Calculating Midpoint Between Two Points

You can use the midpointBetween function to calculate the midpoint between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns a LatLng object representing the midpoint.

'''dart
LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = MapCalculation.midpointBetween(point1, point2);
'''

## Contributing

We welcome contributions to this package. If you have an idea for a new feature or improvement, please open an issue on our GitHub repository. If you would like to contribute code, please fork the repository and submit a pull request. All contributions must adhere to our code of conduct.

## License

This package is released under the MIT License. See the LICENSE file for details.
