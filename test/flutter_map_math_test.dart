import 'dart:math';

import 'package:flutter_map_math/flutter_cluster.dart';
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

  print('Time Taken: ${stopwatch.elapsedMilliseconds} ms');
  print("Ordered Points:");
  for (var point in clusterOrder) {
    print("Lat: ${point.latitude}, Lng: ${point.longitude}");
  }
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
  print('Total Clusters Found: ${clustersDBSCAN.length}');
  print('Time Taken: ${stopwatch.elapsedMilliseconds} ms');
  for (var i = 0; i < clustersDBSCAN.length; i++) {
    print('Cluster ${i + 1}: ${clustersDBSCAN[i].length} points');
  }

}

/// TESTS
void main() {
  // testDBSCAN();
  testOPTICS();
}
