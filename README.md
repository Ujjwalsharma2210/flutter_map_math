# Map related Calculations Package for Flutter

This package provides a set of utility classes and functions for performing map-related calculations in a Flutter application.

## Installation

To use this package, add map_calculation as a dependency in your '**pubspec.yaml**' file:

```
    dependencies:
        flutter_map_math: ^0.2.4
```

Then, run '**flutter pub get**' to install the package.

## Usage

Import the map_calculation package in your Dart code:

```dart
import 'package:flutter_map_math/flutter_map_math.dart';
```

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

You can use the '**bearingBetween**' function to calculate the bearing between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point.
The function returns the bearing in degrees.

```dart
double bearing = FlutterMapMath.bearingBetween(
    37.4219999,
    -122.0840575,
    37.4220011,
    -122.0866519,
);
```

### Calculating Destination Point

You can use the '**destinationPoint**' function to calculate the destination point from a starting point, given a distance and a bearing. The function takes three arguments: the latitude and longitude of the starting point, the distance in meters, and the bearing in degrees.
The function returns a LatLng object representing the destination point.

```dart
LatLng startingPoint = LatLng(37.4219999, -122.0840575);
double distance = 1000;
double bearing = 90;
LatLng destinationPoint = FlutterMapMath.destinationPoint(startingPoint, distance, bearing);
```

### Calculating Midpoint Between Two Points

You can use the '**midpointBetween**' function to calculate the midpoint between two points on a map. The function takes four arguments: the latitude and longitude of the first point, and the latitude and longitude of the second point.
The function returns a LatLng object representing the midpoint.

```dart
LatLng location1 = LatLng(37.4219999, -122.0840575);
LatLng location2 = LatLng(37.4220011, -122.0866519);
LatLng midpoint = FlutterMapMath.midpointBetween(point1, point2);
```

### Calculating intersection point of two lines

You can use the '**calculateIntersection**' function to calculate the intersection of two lines on the map. The function takes six arguments: the latitude, longitude and bearing angle to first line, and the latitude, longitude and bearing angle of second line.
The function returns a LatLng object representing the intersection.

```dart
LatLng location1 = LatLng(40.7128, -74.0060); // New York City
double bearing1 = 45.0; // Degrees

LatLng location2 = LatLng(51.5074, -0.1278); // London
double bearing2 = 180.0; // Degrees

LatLng intersection = FlutterMapMath.calculateIntersection(location1, bearing1, location2, bearing2);
```

### Detecting proximity of points from one point

The **detectProximity** function calculates the geodesic distance between a given user location and a list of map points using the Haversine formula. It returns a list of points that are within a specified distance threshold.

Features

- Uses the Haversine formula to accurately compute distances on Earth.

- Takes into account the Earth's curvature for precise geolocation.

- Returns only the points that fall within the defined distance threshold.

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

  List<LatLng> detectProximity(
    LatLng userLocation, List<LatLng> mapPoints, double distanceThresholdKm)

```

### Creating virtual boundary around a point

the '**createBoundary**' function takes a '**LatLng**' object representing the center of the boundary and a '**double**' representing the radius of the
boundary in meters. It returns a function that takes a '**LatLng**' object representing a location and returns a boolean indicating whether
the location is within the boundary.<br>
You can use the '**createBoundary**' function to create multiple boundaries and then use the returned functions to check whether a user or object is within each boundary.

```dart
LatLng center = LatLng(37.4219983, -122.084);
double radiusInMeters = 100.0;
Function isInBoundary = createBoundary(center, radiusInMeters);
LatLng userLocation = LatLng(37.422, -122.083);
bool isWithinBoundary = isInBoundary(userLocation);
```

### Calculating the area of a shape

In this function, we first get the number of vertices of the shape and initialize the area to zero. We then loop over each pair of consecutive vertices, calculating the cross-product of the two vectors formed by the points. Finally, we divide the result by two to get the area of the shape.

Note that this function assumes that the vertices are ordered in a counterclockwise direction, and that the latitude and longitude values are stored in the '**latitude**' and '**longitude**' keys of each vertex dictionary, respectively. If the vertices are ordered clockwise, the calculated area will be negative, but we can simply take the absolute value to get the correct area.

```dart
List<Map<String, double>> rectangleVertices = [
    {'latitude': 37.7749, 'longitude': -122.4194}, // San Francisco, CA
    {'latitude': 37.7749, 'longitude': -122.4174},
    {'latitude': 37.7769, 'longitude': -122.4174},
    {'latitude': 37.7769, 'longitude': -122.4194},
  ];

  double rectangleArea = calculateArea(rectangleVertices);

  print('The area of the rectangle is $rectangleArea square degrees.');
```

### Finding Extremal Distance Points

You can use this function to find the pair of points with either the maximum or minimum distance between them.  
The function takes two arguments: a list of LatLng objects representing points on the map, and a DistanceType enum specifying whether to find the maximum or minimum distance.

```dart
List<LatLng> points = [
    LatLng(37.4219999, -122.0840575),
    LatLng(37.4220011, -122.0866519),
    LatLng(37.4200000, -122.0800000),
    // Add more points as needed
];

List<LatLng> extremalPoints = findExtremalDistancePoints(
    points,
    DistanceType.maximum,
);

print('Points with the maximum distance: $extremalPoints');
```

### Clustering using DBSCAN

DBSCAN is widely used for geospatial clustering. It groups together points that are closely packed (using a specified distance threshold and minimum points), and it works well with an appropriate geodesic distance measure (like the Haversine formula). Its ability to find arbitrarily shaped clusters without needing to specify the number of clusters is a major advantage.

```dart
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
print('DBSCAN clusters:');
for (var i = 0; i < clustersDBSCAN.length; i++) {
  print('Cluster ${i + 1}: ${clustersDBSCAN[i]}');
}
```

### Clustering using OPTICS

OPTICS is a density-based clustering algorithm that creates an ordered list of points based on their reachability distance. Unlike DBSCAN, it does not produce strict clusters but instead preserves the hierarchical structure of data points. This makes it useful for finding nested clusters and adjusting density thresholds dynamically.

```dart
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

### Clustering using K-means
K-Means is an unsupervised clustering algorithm that partitions a dataset into K distinct clusters based on similarity. It is widely used in machine learning, geospatial data clustering, and image segmentation.

```dart
List<LatLng> mapPoints = [
    LatLng(1.0, 1.0),
    LatLng(2.0, 2.0),
    LatLng(2.1, 2.2),
    LatLng(4.0, 4.0),
    LatLng(6.0, 6.0),
    LatLng(8.0, 8.0),
  ];

// Instantiate the KMeans clustering algorithm with k = 3 clusters,
// a maximum of 100 iterations, and a convergence tolerance of 1 meter.
KMeans kmeans = KMeans(k: 3, maxIterations: 100, tolerance: 1.0);

// Perform clustering.
List<List<LatLng>> clusters = kmeans.cluster(points);

// Print the clusters.
for (int i = 0; i < clusters.length; i++) {
  print('Cluster ${i + 1}:');
  for (var point in clusters[i]) {
    print('  (${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)})');
  }
  print('---------------------');
}
```

### Get the elevation
Simple method that returns the elevation of a given location in meters. Returns A Future<double?>.
Uses https://api.open-elevation.com api.


```dart
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:latlong2/latlong.dart';

void testElevation() async {
  LatLng location = LatLng(27.9881, 86.9250); // Everest Base Camp
  double? elevation = await FlutterMapMath.getElevation(location);
  print("Elevation: $elevation meters");
}

void main() {
  testElevation();
}
```

### Mercator Projection
Coordinate Projections (e.g., Mercator, UTM): This adds functionality to convert spherical coordinates (lat/lng) to flat map projections and vice-versa, useful for 2D visualizations.

```dart
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:latlong2/latlong.dart';

void testWebMercator() async {
  LatLng point = LatLng(37.7749, -122.4194); // San Francisco

  Point<double> projected = FlutterMapMath.projectMercator(point);
  print("Mercator X: ${projected.x}, Y: ${projected.y}");

  LatLng backToGeo = FlutterMapMath.unprojectMercator(projected);
  print("Back to LatLng: ${backToGeo.latitude}, ${backToGeo.longitude}");
}

void main() {
  testWebMercator();
}
```

### Heatmap generation
Applications may need to generate a heatmap of points or events on a map, which can be useful for visualizing patterns or clusters of activity.

```dart
import 'package:flutter_map_math/heat_map.dart';
import 'package:flutter_map_math/utils/models/heat_point.dart';

final points = [
  HeatPoint(28.6139, 77.2090),
  HeatPoint(28.6140, 77.2091),
  HeatPoint(28.6150, 77.2100),
];

final heat = HeatmapGenerator.generateHeatmap(
  points: points,
  radius: 300,
  resolution: 50,
);

heat.forEach((cell, intensity) {
  print('(${cell.x}, ${cell.y}) → ${intensity.toStringAsFixed(2)}');
});

```

OUTPUT:
```dart
(-5, 0) → 0.41
(-4, -3) → 0.46
(-4, -2) → 0.60
(-4, -1) → 0.71
(-4, 0) → 0.75
(-4, 1) → 0.71
(-4, 2) → 0.60
...
```

## TODOS

- Traveling Salesman Problem (TSP) for Path Optimization: This involves finding the optimal order to visit multiple points, minimizing total distance. It uses the existing distanceBetween function, implementing algorithms like nearest neighbor or 2-opt, purely based on coordinate math.<br>

- Buffer Zone Creation Around Lines or Polygons: This extends the createBoundary function, allowing offset areas around lines (e.g., roads) or polygons (e.g., regions), calculated by offsetting coordinates using bearing and distance, without external data.<br>

- Area calculation: Applications may need to calculate the area of a shape, such as a polygon or circle. This can be useful for measuring the size of a parcel of land or for calculating the coverage area of a wireless network.<br>

- Point-of-interest identification: Applications may need to identify nearby points of interest, such as restaurants, gas stations, or landmarks. This can be useful for providing recommendations or directions to users.<br>

## Contributing

We welcome contributions to this package. If you have an idea for a new feature or improvement, please open an issue on our <a href="https://github.com/Ujjwalsharma2210/flutter_map_math" target="_blank">GitHub repository</a>. If you would like to contribute code, please fork the repository and submit a pull request. All contributions must adhere to our [code of conduct](https://github.com/Ujjwalsharma2210/flutter_map_math/blob/main/CODE_OF_CONDUCT.md).

## License

This package is released under the <a href="https://opensource.org/license/mit/" target="_blank">MIT license</a>. See the <a href="https://github.com/Ujjwalsharma2210/flutter_map_math/blob/main/LICENSE" target="_blank">LICENSE</a> file for details.
