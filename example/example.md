```dart
double distance = FlutterGeoMath.distanceBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
    "meters"
);

double bearing = FlutterGeoMath.bearingBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
);

LatLng startingPoint = LatLng(37.4219999, -122.0840575);
double distance = 1000;
double bearing = 90;
LatLng destinationPoint = FlutterGeoMath.destinationPoint(startingPoint, distance, bearing);

LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = FlutterGeoMath.midpointBetween(point1, point2);
```

```dart
  double lat1 = 40.7128; // New York City
  double lon1 = -74.0060;
  double bearing1 = 45.0; // Degrees

  double lat2 = 51.5074; // London
  double lon2 = -0.1278;
  double bearing2 = 180.0; // Degrees

  LatLng intersection = calculateIntersection(lat1, lon1, bearing1, lat2, lon2, bearing2);
```
