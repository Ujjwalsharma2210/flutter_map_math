## 0.0.1

### Calculating Distance Between Two Points

You can use the '**distanceBetween**' function to calculate the distance between two points on a map. The function takes five arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point and the units you want the distance in.

```dart
double distance = FlutterMapMath.distanceBetween(
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
double bearing = FlutterMapMath.bearingBetween(
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
LatLng destinationPoint = FlutterMapMath.destinationPoint(startingPoint, distance, bearing);
```

### Calculating Midpoint Between Two Points

You can use the '**midpointBetween**' function to calculate the midpoint between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point. The function returns a LatLng object representing the midpoint.

```dart
LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = FlutterMapMath.midpointBetween(point1, point2);
```

## 0.0.2

updated docs

## 0.0.3

updated docs

## 0.0.4

fixes

## 0.0.5

fixes

## 0.0.6

added comments for better readability.

## 0.0.7

fixes

## 0.0.8

fixes

## 0.0.9

fixes

## 0.1.0

added 'calculateIntersection' function to find the intersection point of two lines.

## 0.1.1

Added proximity detection function

## 0.1.2

Added function to create virtual boundaries

## 0.1.3

Added function to find area of the shape
