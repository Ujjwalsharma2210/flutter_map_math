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
