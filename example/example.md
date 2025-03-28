```dart
double distance = FlutterMapMath.distanceBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
    "meters"
);

double bearing = FlutterMapMath.bearingBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
);

LatLng startingPoint = LatLng(37.4219999, -122.0840575);
double distance = 1000;
double bearing = 90;
LatLng destinationPoint = FlutterMapMath.destinationPoint(startingPoint, distance, bearing);

LatLng point1 = LatLng(37.4219999, -122.0840575);
LatLng point2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = FlutterMapMath.midpointBetween(point1, point2);
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

```dart
LatLng userLocation = LatLng(3.0, 5.0);
  List<LatLng> mapPoints = [
    LatLng(1.0, 1.0),
    LatLng(2.0, 2.0),
    LatLng(4.0, 4.0),
    LatLng(6.0, 6.0),
    LatLng(8.0, 8.0),
  ];

  double distanceThreshold = 3.0;

  List<LatLng> nearbyPoints = FlutterMapMath.detectProximity(userLocation, mapPoints, distanceThreshold);

```

```dart
LatLng center = LatLng(37.4219983, -122.084);
double radiusInMeters = 100.0;
Function isInBoundary = createBoundary(center, radiusInMeters);
LatLng userLocation = LatLng(37.422, -122.083);
bool isWithinBoundary = isInBoundary(userLocation);
```

```dart
import 'package:flutter_map_math/flutter_cluster.dart';

final points = <LatLng>[
    LatLng(37.7749, -122.4194), // San Francisco
    LatLng(37.7750, -122.4195), // Near San Francisco
    LatLng(37.8044, -122.2711), // Oakland
    LatLng(37.8045, -122.2712), // Near Oakland
    LatLng(37.6879, -122.4702), // Daly City
  ];

  // Define the parameters.
  // eps: maximum distance (in meters) to be considered neighbors.
  // minPoints: minimum number of points to form a dense region.
  const double eps = 100; // 100 meters
  const int minPoints = 2;

  // DBSCAN example.
  final clustersDBSCAN = FlutterCluster.dbscan(points, eps, minPoints);
```



```dart
import 'package:flutter_map_math/flutter_cluster.dart';

List<LatLng> mapPoints = [
    LatLng(1.0, 1.0),
    LatLng(2.0, 2.0),
    LatLng(2.1, 2.2),
    LatLng(4.0, 4.0),
    LatLng(6.0, 6.0),
    LatLng(8.0, 8.0),
  ];

  OPTICS optics = OPTICS(500, 2); // 500m radius, min 2 points
  List<LatLng> clusterOrder = optics.optics(mapPoints);

  print("Ordered Points:");
  for (var point in clusterOrder) {
    print("Lat: ${point.latitude}, Lng: ${point.longitude}");
  }
```


```dart
import 'package:flutter_map_math/flutter_cluster.dart';

List<LatLng> points = [
    LatLng(37.7749, -122.4194), // San Francisco
    LatLng(37.8044, -122.2711), // Oakland
    LatLng(37.6879, -122.4702), // Daly City
    LatLng(34.0522, -118.2437), // Los Angeles
    LatLng(36.1699, -115.1398), // Las Vegas
    LatLng(40.7128, -74.0060),  // New York City
    LatLng(42.3601, -71.0589),  // Boston
    LatLng(41.8781, -87.6298),  // Chicago
    LatLng(29.7604, -95.3698),  // Houston
    LatLng(25.7617, -80.1918),  // Miami
  ];

  // Instantiate the KMeans clustering algorithm with k = 3 clusters,
  // a maximum of 100 iterations, and a convergence tolerance of 1 meter.
  KMeans kmeans = KMeans(k: 3, maxIterations: 100, tolerance: 1.0);

  // Perform clustering.
  List<List<LatLng>> clusters = kmeans.cluster(points);
```
