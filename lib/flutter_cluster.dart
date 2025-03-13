import 'dart:collection';

import 'package:latlong2/latlong.dart';

class FlutterCluster {
  /// DBSCAN clustering algorithm.
  /// Returns a list of clusters, where each cluster is a list of [LatLng] points.
  static List<List<LatLng>> dbscan(List<LatLng> points, double eps, int minPoints) {
    final distance = Distance();
    final clusters = <List<LatLng>>[];
    final visited = <LatLng>{};
    final noise = <LatLng>[];

    for (final point in points) {
      if (visited.contains(point)) continue;
      visited.add(point);
      final neighbors = _regionQuery(point, points, eps, distance);
      if (neighbors.length < minPoints) {
        // Mark point as noise if it does not have enough neighbors.
        noise.add(point);
      } else {
        // Create a new cluster and expand it.
        final cluster = <LatLng>[];
        clusters.add(cluster);
        _expandCluster(point, neighbors, cluster, points, eps, minPoints, visited, distance);
      }
    }
    return clusters;
  }

  /// OPTICS clustering algorithm.
  /// (Currently a stub implementation that calls DBSCAN.)
  static List<List<LatLng>> optics(List<LatLng> points, double eps, int minPoints) {
    // TODO: Replace with a true OPTICS implementation.
    return dbscan(points, eps, minPoints);
  }

  /// HDBSCAN clustering algorithm.
  /// (Currently a stub implementation that calls DBSCAN.)
  static List<List<LatLng>> hdbscan(List<LatLng> points, double eps, int minPoints) {
    // TODO: Replace with a true HDBSCAN implementation.
    return dbscan(points, eps, minPoints);
  }

  /// Returns a list of all points within [eps] meters of [point].
  static List<LatLng> _regionQuery(
      LatLng point, List<LatLng> points, double eps, Distance distance) {
    final neighbors = <LatLng>[];
    for (final other in points) {
      if (distance.as(LengthUnit.Meter, point, other) <= eps) {
        neighbors.add(other);
      }
    }
    return neighbors;
  }

  /// Expands the cluster by recursively adding density-reachable points.
  static void _expandCluster(
      LatLng point,
      List<LatLng> neighbors,
      List<LatLng> cluster,
      List<LatLng> points,
      double eps,
      int minPoints,
      Set<LatLng> visited,
      Distance distance) {
    cluster.add(point);
    final queue = Queue<LatLng>()..addAll(neighbors);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (!visited.contains(current)) {
        visited.add(current);
        final currentNeighbors = _regionQuery(current, points, eps, distance);
        if (currentNeighbors.length >= minPoints) {
          // Only add new neighbors that are not already in the queue.
          for (final neighbor in currentNeighbors) {
            if (!queue.contains(neighbor)) {
              queue.add(neighbor);
            }
          }
        }
      }
      // Add the point to the cluster if not already added.
      if (!cluster.contains(current)) {
        cluster.add(current);
      }
    }
  }
}