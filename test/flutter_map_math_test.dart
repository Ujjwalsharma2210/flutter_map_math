import 'dart:math';

import 'package:flutter_map_math/flutter_cluster.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_map_math/heat_map.dart';
import 'package:flutter_map_math/utils/models/heat_point.dart';
import 'package:latlong2/latlong.dart';
import 'dart:core';

List<LatLng> generateRandomPoints(int count, double centerLat, double centerLng, double radius) {
  final random = Random();
  final points = <LatLng>[];

  for (int i = 0; i < count; i++) {
    final latOffset = (random.nextDouble() - 0.5) * radius * 0.01;
    final lngOffset = (random.nextDouble() - 0.5) * radius * 0.01;
    points.add(LatLng(centerLat + latOffset, centerLng + lngOffset));
  }

  return points;
}

void testOPTICS() {
  final points = generateRandomPoints(200, 40.7128, -74.0060, 5.0);
  OPTICS optics = OPTICS(500, 2); // 500m radius, min 2 points
  final stopwatch = Stopwatch()..start(); // Start the stopwatch
  List<LatLng> clusterOrder = optics.optics(points);
  stopwatch.stop();

  // print('Time Taken: ${stopwatch.elapsedMilliseconds} ms');
  // print("Ordered Points:");
  // for (var point in clusterOrder) {
  //   print("Lat: ${point.latitude}, Lng: ${point.longitude}");
  // }
}

void testDBSCAN() {
  // Sample geospatial points.
  // Generate 500 random points around New York City
  final points = generateRandomPoints(500, 40.7128, -74.0060, 5.0);

  // Define clustering parameters
  const double eps = 300;  // 200 meters radius
  const int minPoints = 5; // Minimum 5 points to form a cluster

  // DBSCAN example.
  final stopwatch = Stopwatch()..start(); // Start the stopwatch
  final clustersDBSCAN = FlutterCluster.dbscan(points, eps, minPoints);
  stopwatch.stop();
  // Print clusters
  // print('Total Clusters Found: ${clustersDBSCAN.length}');
  // print('Time Taken: ${stopwatch.elapsedMilliseconds} ms');
  // for (var i = 0; i < clustersDBSCAN.length; i++) {
  //   print('Cluster ${i + 1}: ${clustersDBSCAN[i].length} points');
  // }

}

void testKmeans() {
  // Example list of LatLng points across a large area.
  List<LatLng> points = generateRandomPoints(100, 40.7128, -74.0060, 5.0);

  // Instantiate the KMeans clustering algorithm with k = 3 clusters,
  // a maximum of 100 iterations, and a convergence tolerance of 1 meter.
  KMeans kmeans = KMeans(k: 3, maxIterations: 100, tolerance: 1.0);

  // Perform clustering.
  List<List<LatLng>> clusters = kmeans.cluster(points);

  // // Print the clusters.
  // for (int i = 0; i < clusters.length; i++) {
  //   print('Cluster ${i + 1}:');
  //   for (var point in clusters[i]) {
  //     print('  (${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)})');
  //   }
  //   print('---------------------');
  // }
}

void testElevation() async {
  LatLng location = LatLng(27.9881, 86.9250); // Everest Base Camp
  double? elevation = await FlutterMapMath.getElevation(location);
  // print("Elevation: $elevation meters");
}

void testWebMercator() async {
  LatLng point = LatLng(37.7749, -122.4194); // San Francisco

  Point<double> projected = FlutterMapMath.projectMercator(point);
  // print("Mercator X: ${projected.x}, Y: ${projected.y}");

  LatLng backToGeo = FlutterMapMath.unprojectMercator(projected);
  // print("Back to LatLng: ${backToGeo.latitude}, ${backToGeo.longitude}");
}

void testHeatMap() async {
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

  // heat.forEach((cell, intensity) {
  //   print('(${cell.x}, ${cell.y}) → ${intensity.toStringAsFixed(2)}');
    
  // });

}

/// TESTS
void main() {
  try {
    testDBSCAN();
    print("✅ testDBSCAN SUCCESS: $e");
  } catch (e) {
    print("❌ testDBSCAN ERROR: $e");
  }

  try {
    testOPTICS();
    print("✅ testOPTICS SUCCESS: $e");
  } catch (e) {
    print("❌ testOPTICS ERROR: $e");
  }

  try {
    testKmeans();
    print("✅ testKmeans SUCCESS: $e");
  } catch (e) {
    print("❌ testKmeans ERROR: $e");
  }

  try {
    testElevation();
    print("✅ testElevation SUCCESS: $e");
  } catch (e) {
    print("❌ testElevation ERROR: $e");
  }

  try {
    testWebMercator();
    print("✅ testWebMercator SUCCESS: $e");
  } catch (e) {
    print("❌ testWebMercator ERROR: $e");
  }

  try {
    testHeatMap();
    print("✅ testHeatMap SUCCESS: $e");
  } catch (e) {
    print("❌ testHeatMap ERROR: $e");
  }
}
