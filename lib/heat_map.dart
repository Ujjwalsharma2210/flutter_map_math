import 'dart:math';
import 'package:flutter_map_math/utils/models/heat_point.dart';
import 'package:latlong2/latlong.dart';

class HeatmapGenerator {
  static Map<Point<int>, double> generateHeatmap({
    required List<HeatPoint> points,
    required double radius,
    required double resolution,
  }) {
    final Distance dist = Distance();
    final Map<Point<int>, double> heatGrid = {};

    for (final p in points) {
      final influenceRadius = radius;

      for (double dx = -influenceRadius; dx <= influenceRadius; dx += resolution) {
        for (double dy = -influenceRadius; dy <= influenceRadius; dy += resolution) {
          final targetLat = p.lat + (dy / 111320.0);
          final targetLng = p.lng + (dx / (111320.0 * cos(p.lat * pi / 180)));

          final d = dist.as(LengthUnit.Meter, LatLng(p.lat, p.lng), LatLng(targetLat, targetLng));

          if (d <= influenceRadius) {
            final weight = p.intensity * exp(-pow(d, 2) / (2 * pow(influenceRadius / 2, 2)));

            final x = ((p.lng + dx) / resolution).floor();
            final y = ((p.lat + dy) / resolution).floor();
            final key = Point(x, y);

            heatGrid.update(key, (v) => v + weight, ifAbsent: () => weight);
          }
        }
      }
    }

    return heatGrid;
  }
}
