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
import 'package:flutter_geo_math/flutter_geo_math.dart';
```

### Calculating Distance Between Two Points

You can use the '**distanceBetween**' function to calculate the distance between two points on a map. The function takes five arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point and the units you want the distance in.

```dart
double distance = FlutterGeoMath.distanceBetween(
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
double bearing = FlutterGeoMath.bearingBetween(
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
LatLng destinationPoint = FlutterGeoMath.destinationPoint(startingPoint, distance, bearing);
```

### Calculating Midpoint Between Two Points

You can use the '**midpointBetween**' function to calculate the midpoint between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns a LatLng object representing the midpoint.

```dart
LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = FlutterGeoMath.midpointBetween(point1, point2);
```

## TODOS

- Intersection calculation: Applications may need to calculate the intersection of two lines or the intersection of a line and a shape, such as a polygon or circle.<br>

- Geocoding: Applications may need to convert an address or place name into a latitude and longitude, or vice versa. This can be useful for finding the location of a place or for searching for nearby points of interest.<br>

- Routing: Applications may need to calculate the best route between two points on a map, taking into account factors such as traffic, road closures, and turn restrictions.<br>

- Area calculation: Applications may need to calculate the area of a shape, such as a polygon or circle. This can be useful for measuring the size of a parcel of land or for calculating the coverage area of a wireless network.<br>

- Elevation calculation: Applications may need to calculate the elevation of a point on a map, either as an absolute height above sea level or as a relative height above nearby terrain.<br>

- Heatmap generation: Applications may need to generate a heatmap of points or events on a map, which can be useful for visualizing patterns or clusters of activity.<br>

- Clustering: Applications may need to group nearby points on a map into clusters, which can be useful for reducing visual clutter or for identifying areas of high activity.<br>

- Proximity detection: Applications may need to detect when a user or object is within a certain distance of a point or area on a map, which can be useful for triggering location-based actions or notifications.<br>

- Geofencing: Applications may need to create a virtual boundary around a point or area on a map, and detect when a user or object enters or leaves that boundary. This can be useful for triggering location-based actions or notifications.<br>

- Tile generation: Applications may need to generate map tiles for use in custom map layers or overlays, which can be useful for adding custom data or visualizations to a map.<br>

- Point-of-interest identification: Applications may need to identify nearby points of interest, such as restaurants, gas stations, or landmarks. This can be useful for providing recommendations or directions to users.<br>

## Contributing

We welcome contributions to this package. If you have an idea for a new feature or improvement, please open an issue on our <a href="https://github.com/Ujjwalsharma2210/flutter_geo_math" target="_blank">GitHub repository</a>. If you would like to contribute code, please fork the repository and submit a pull request. All contributions must adhere to our [code of conduct](https://github.com/Ujjwalsharma2210/flutter_geo_math/blob/main/CODE_OF_CONDUCT.md).

## License

This package is released under the <a href="https://opensource.org/license/mit/" target="_blank">MIT license</a>. See the <a href="https://github.com/Ujjwalsharma2210/flutter_geo_math/blob/main/LICENSE" target="_blank">LICENSE</a> file for details.
