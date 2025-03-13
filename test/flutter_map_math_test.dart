import 'dart:math';

import 'package:flutter_map_math/flutter_cluster.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_test/flutter_test.dart';
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

void testClustering() {
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

  // // OPTICS example (stub implementation).
  // final clustersOPTICS = FlutterCluster.optics(points, eps, minPoints);
  // print('\nOPTICS clusters (stub):');
  // for (var i = 0; i < clustersOPTICS.length; i++) {
  //   print('Cluster ${i + 1}: ${clustersOPTICS[i]}');
  // }

  // // HDBSCAN example (stub implementation).
  // final clustersHDBSCAN = FlutterCluster.hdbscan(points, eps, minPoints);
  // print('\nHDBSCAN clusters (stub):');
  // for (var i = 0; i < clustersHDBSCAN.length; i++) {
  //   print('Cluster ${i + 1}: ${clustersHDBSCAN[i]}');
  // }
}

/// TESTS
void main() {
  testClustering();
  // test('find distance between', () {
  //   final calculator = FlutterMapMath();
  //   print(calculator.distanceBetween(
  //       37.4219999, -122.0840575, 37.4220011, -122.0866519, "meters"));
  //   print(calculator.bearingBetween(
  //       37.4219999, -122.0840575, 37.4220011, -122.0866519));
  // });
}
