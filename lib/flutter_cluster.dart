import 'dart:collection';
import 'dart:math';

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


class KMeans {
  final int k;
  final int maxIterations;
  final double tolerance; // convergence threshold in meters
  final Distance distance = Distance();

  KMeans({
    required this.k,
    this.maxIterations = 100,
    this.tolerance = 1e-4,
  });

  /// Converts a LatLng point to 3D Cartesian coordinates on a unit sphere.
  List<double> _toCartesian(LatLng point) {
    double latRad = point.latitude * pi / 180;
    double lngRad = point.longitude * pi / 180;
    double x = cos(latRad) * cos(lngRad);
    double y = cos(latRad) * sin(lngRad);
    double z = sin(latRad);
    return [x, y, z];
  }

  /// Converts Cartesian coordinates back to a LatLng.
  LatLng _toLatLng(double x, double y, double z) {
    double hyp = sqrt(x * x + y * y);
    double latRad = atan2(z, hyp);
    double lngRad = atan2(y, x);
    return LatLng(latRad * 180 / pi, lngRad * 180 / pi);
  }

  /// Computes the centroid of a list of LatLng points using spherical averaging.
  LatLng _computeCentroid(List<LatLng> points) {
    double sumX = 0, sumY = 0, sumZ = 0;
    for (var p in points) {
      List<double> cart = _toCartesian(p);
      sumX += cart[0];
      sumY += cart[1];
      sumZ += cart[2];
    }
    int n = points.length;
    double avgX = sumX / n;
    double avgY = sumY / n;
    double avgZ = sumZ / n;
    return _toLatLng(avgX, avgY, avgZ);
  }

  /// Clusters [points] into k clusters.
  /// Returns a list of clusters, where each cluster is a list of LatLng points.
  List<List<LatLng>> cluster(List<LatLng> points) {
    if (points.isEmpty || k <= 0) return [];

    // Randomly initialize centroids from the points.
    List<LatLng> centroids = List.from(points)..shuffle();
    centroids = centroids.take(k).toList();

    List<List<LatLng>> clusters = List.generate(k, (_) => []);

    for (int iter = 0; iter < maxIterations; iter++) {
      // Clear clusters for current iteration.
      clusters = List.generate(k, (_) => []);

      // Assignment step: assign each point to the nearest centroid.
      for (var point in points) {
        int bestIndex = 0;
        double minDist = distance.as(LengthUnit.Meter, point, centroids[0]);
        for (int i = 1; i < centroids.length; i++) {
          double d = distance.as(LengthUnit.Meter, point, centroids[i]);
          if (d < minDist) {
            minDist = d;
            bestIndex = i;
          }
        }
        clusters[bestIndex].add(point);
      }

      // Update step: recalc centroids using spherical averaging.
      List<LatLng> newCentroids = [];
      for (var cluster in clusters) {
        if (cluster.isEmpty) {
          // If a cluster ends up empty, randomly reinitialize its centroid.
          newCentroids.add(points[Random().nextInt(points.length)]);
        } else {
          newCentroids.add(_computeCentroid(cluster));
        }
      }

      // Check for convergence.
      double maxShift = 0;
      for (int i = 0; i < k; i++) {
        double shift = distance.as(LengthUnit.Meter, centroids[i], newCentroids[i]);
        if (shift > maxShift) maxShift = shift;
      }

      centroids = newCentroids;
      if (maxShift < tolerance) break;
    }

    return clusters;
  }
}
