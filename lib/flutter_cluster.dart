import 'dart:collection';

import 'package:latlong2/latlong.dart';

class FlutterCluster {

  /// DBSCAN clustering algorithm.
  /// Returns a list of clusters, where each cluster is a list of [LatLng] points.
  static List<List<LatLng>> dbscan(List<LatLng> points, double eps, int minPoints) {
    final distance = const Distance();
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




class OPTICS {
  final double epsilon; // Max distance for neighbors
  final int minPts; // Min points for a dense region
  final Distance distance = Distance();

  OPTICS(this.epsilon, this.minPts);

  List<LatLng> optics(List<LatLng> points) {
    final List<LatLng> orderedList = [];
    final Set<LatLng> visited = {};
    final Map<LatLng, double> reachabilityDist = {};

    for (final point in points) {
      if (visited.contains(point)) continue;
      visited.add(point);

      final neighbors = _regionQuery(point, points);
      if (neighbors.length < minPts) {
        reachabilityDist[point] = double.infinity; // Mark as noise
      } else {
        _expandClusterOrder(point, neighbors, orderedList, visited, reachabilityDist, points);
      }
    }
    return orderedList;
  }

  void _expandClusterOrder(
      LatLng point,
      List<LatLng> neighbors,
      List<LatLng> orderedList,
      Set<LatLng> visited,
      Map<LatLng, double> reachabilityDist,
      List<LatLng> points) {
    
    final Queue<LatLng> queue = Queue<LatLng>();
    orderedList.add(point);

    while (neighbors.isNotEmpty) {
      final currentPoint = neighbors.removeLast();
      if (!visited.contains(currentPoint)) {
        visited.add(currentPoint);
        final newNeighbors = _regionQuery(currentPoint, points);
        if (newNeighbors.length >= minPts) {
          _updateReachability(currentPoint, newNeighbors, reachabilityDist, queue);
        }
      }
      orderedList.add(currentPoint);
    }
  }

  List<LatLng> _regionQuery(LatLng point, List<LatLng> points) {
    return points.where((p) => distance.as(LengthUnit.Meter, point, p) <= epsilon).toList();
  }

  void _updateReachability(LatLng point, List<LatLng> neighbors, Map<LatLng, double> reachabilityDist, Queue<LatLng> queue) {
    for (final neighbor in neighbors) {
      final newReachability = distance.as(LengthUnit.Meter, point, neighbor);
      if (!reachabilityDist.containsKey(neighbor) || newReachability < reachabilityDist[neighbor]!) {
        reachabilityDist[neighbor] = newReachability;
        queue.add(neighbor);
      }
    }
  }
}