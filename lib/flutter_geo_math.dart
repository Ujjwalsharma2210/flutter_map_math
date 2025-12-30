library flutter_map_math;

import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


enum DistanceType { minimum, maximum }

/// Map related calculations class
class FlutterMapMath {

  static double degreesToRadians(double deg) => deg * pi / 180.0;
  static double radiansToDegrees(double rad) => rad * 180.0 / pi;

  /// converts kilometers to desired(meters, miles, yards) units
  static double toRequestedUnit(String unit, double distanceInKm) {
    switch (unit) {
      case 'kilometers':
        return distanceInKm;
      case 'meters':
        return distanceInKm * 1000;
      case 'miles':
        return (distanceInKm * 1000) / 1609.344;
      case 'yards':
        return distanceInKm * 1093.61;
      case '':
        return distanceInKm;
    }
    return distanceInKm;
  }

  /// Returns distance between two locations on earth
  static double distanceBetween(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    const double earthRadiusKm = 6371.0;
    // assuming earth is a perfect sphere(it's not)

    // Convert degrees to radians
    final lat1Rad = degreesToRadians(lat1);
    final lon1Rad = degreesToRadians(lon1);
    final lat2Rad = degreesToRadians(lat2);
    final lon2Rad = degreesToRadians(lon2);

    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadiusKm * c;

    return toRequestedUnit(unit, distance);

    // return distance; // in km
  }

  /// Returns bearing angle in degrees.
  /// Bearing angle => A bearing describes a line as heading north or south, and
  /// deflected some number of degrees toward the east or west. A bearing,
  /// therefore, will always have an angle less than 90°.
  static double bearingBetween(double lat1, double lon1, double lat2, double lon2) {
    var dLon = degreesToRadians(lon2 - lon1);
    var y = sin(dLon) * cos(degreesToRadians(lat2));
    var x = cos(degreesToRadians(lat1)) * sin(degreesToRadians(lat2)) -
        sin(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * cos(dLon);
    var angle = radiansToDegrees(atan2(y, x));
    return (angle + 360) % 360;
  }

  /// Uses a point, distance and bearing anlge to find the destination point.
  /// Returns LatLng Object
  static LatLng destinationPoint(
      double lat, double lng, double distance, double bearing) {
    double radius = 6371 * 1000; // Earth's radius in meters
    double distRatio = distance / radius;
    double bearingRadians = degreesToRadians(bearing);
    double startLatRadians = degreesToRadians(lat);
    double startLngRadians = degreesToRadians(lng);

    double endLatRadians = asin(sin(startLatRadians) * cos(distRatio) +
        cos(startLatRadians) * sin(distRatio) * cos(bearingRadians));

    double endLngRadians = startLngRadians +
        atan2(sin(bearingRadians) * sin(distRatio) * cos(startLatRadians),
            cos(distRatio) - sin(startLatRadians) * sin(endLatRadians));

    double endLat = radiansToDegrees(endLatRadians);
    double endLng = radiansToDegrees(endLngRadians);

    return LatLng(endLat, endLng);
  }

  /// Returns the mid point of two locations on earth.
  /// Returns a LatLng object(the coordinates of mid point)

  static LatLng midpointBetween(LatLng location1, LatLng location2) {
    // double dLat = degreesToRadians(lat2 - lat1);
    double dLng = degreesToRadians(location2.longitude - location1.longitude);
    double lat1Radians = degreesToRadians(location1.latitude);
    double lat2Radians = degreesToRadians(location2.latitude);

    double bX = cos(lat2Radians) * cos(dLng);
    double bY = cos(lat2Radians) * sin(dLng);
    double midLatRadians = atan2(sin(lat1Radians) + sin(lat2Radians),
        sqrt((cos(lat1Radians) + bX) * (cos(lat1Radians) + bX) + bY * bY));
    double midLngRadians = degreesToRadians(location1.longitude) +
        atan2(bY, cos(lat1Radians) + bX);

    double midLat = radiansToDegrees(midLatRadians);
    double midLng = radiansToDegrees(midLngRadians);

    return LatLng(midLat, midLng);
  }

  /// A function to calculate the intersection of two lines on Earth
  /// Returns a LatLng object with the latitude and longitude of the intersection point
  static LatLng calculateIntersection(
      LatLng location1, double bearing1, LatLng location2, double bearing2) {
    // Convert degrees to radians
    double lat1Rad = degreesToRadians(location1.latitude);
    double lon1Rad = degreesToRadians(location1.longitude);
    double bearing1Rad = degreesToRadians(bearing1);
    double lat2Rad = degreesToRadians(location2.latitude);
    double lon2Rad = degreesToRadians(location2.longitude);
    // double bearing2Rad = degreesToRadians(bearing2);

    // Calculate the intersection point
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    double dist12 = 2 *
        asin(sqrt(pow(sin(dLat / 2), 2) +
            cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2)));
    if (dist12 == 0) {
      throw Exception("Lines are parallel, intersection is undefined.");
    }

    double bearingA = acos((sin(lat2Rad) - sin(lat1Rad) * cos(dist12)) /
        (sin(dist12) * cos(lat1Rad)));
    // double bearingB = acos((sin(lat1Rad) - sin(lat2Rad) * cos(dist12)) /
    // (sin(dist12) * cos(lat2Rad)));

    double intersectionLat = asin(sin(lat1Rad) * cos(bearingA) +
        cos(lat1Rad) * sin(bearingA) * cos(bearing1Rad));
    double intersectionLon = lon1Rad +
        atan2(sin(bearing1Rad) * sin(bearingA) * cos(lat1Rad),
            cos(bearingA) - sin(lat1Rad) * sin(intersectionLat));

    // Convert back to degrees
    double intersectionLatDeg = radiansToDegrees(intersectionLat);
    double intersectionLonDeg = radiansToDegrees(intersectionLon);

    return LatLng(intersectionLatDeg, intersectionLonDeg);
  }

  /// function for proximity detection that takes in the user's current location
  /// and a list of points representing areas on the map, and returns a list of
  /// points that are within a certain distance of the user's location
  static List<LatLng> detectProximity(
    LatLng userLocation, List<LatLng> mapPoints, double distanceThresholdKm) {
  const double earthRadiusKm = 6371.0;
  List<LatLng> nearbyPoints = [];

  double haversineDistance(LatLng point1, LatLng point2) {
    double lat1 = point1.latitude * pi / 180.0;
    double lon1 = point1.longitude * pi / 180.0;
    double lat2 = point2.latitude * pi / 180.0;
    double lon2 = point2.longitude * pi / 180.0;

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = pow(sin(dLat / 2), 2) +
        cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  for (LatLng point in mapPoints) {
    double distance = haversineDistance(userLocation, point);
    if (distance <= distanceThresholdKm) {
      nearbyPoints.add(point);
    }
  }

  return nearbyPoints;
}

  // function that takes a center location and a radius in meters
  // and returns a function that takes a location and returns a boolean
  // indicating whether the location is within the boundary.
  static Function createBoundary(LatLng center, double radius) {
    checkBoundary(LatLng location) {
      double distanceInMeters = distanceBetween(
        center.latitude,
        center.longitude,
        location.latitude,
        location.longitude,
        'meters',
      );
      return distanceInMeters <= radius;
    }

    return checkBoundary;
  }

  static double calculateArea(List<Map<String, double?>> vertices) {
    int numPoints = vertices.length;
    double area = 0;

    if (numPoints > 2) {
      for (int i = 0; i < numPoints; i++) {
        Map<String, double?> point1 = vertices[i];
        Map<String, double?> point2 = vertices[(i + 1) % numPoints];
        area += (point1['longitude'] ?? 0.0) * (point2['latitude'] ?? 0.0) -
            (point1['latitude'] ?? 0.0) * (point2['longitude'] ?? 0.0);
      }
      area /= 2;
    }

    return area.abs();
  }

  /// Finds the pair of points with extremal distance based on the provided criteria.
  ///
  /// This function iterates through all pairs of points in the given list and calculates
  /// the distance between them. Depending on the `distanceType`, it either finds the pair
  /// of points with the maximum or minimum distance.
  ///
  /// Parameters:
  ///   - points: List of LatLng objects representing points on the map.
  ///   - distanceType: Enum specifying whether to find the maximum or minimum distance.
  ///
  /// Returns:
  ///   A list containing the pair of points with the extremal distance.
  ///   If the input list contains fewer than two points, an empty list is returned.
  static List<LatLng> findExtremalDistancePoints(
      List<LatLng> points, DistanceType distanceType) {
    if (points.length < 2) {
      return [];
    }

    LatLng point1 = points.first;
    LatLng point2 = points.last;
    double maxDistance = double.negativeInfinity;
    double minDistance = double.infinity;

    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        double distance = distanceBetween(
          points[i].latitude,
          points[i].longitude,
          points[j].latitude,
          points[j].longitude,
          "meters",
        );

        if (distanceType == DistanceType.maximum && distance >= maxDistance) {
          maxDistance = distance;
          point1 = points[i];
          point2 = points[j];
          continue;
        }

        if (distanceType == DistanceType.minimum && distance < minDistance) {
          minDistance = distance;
          point1 = points[i];
          point2 = points[j];
        }
      }
    }

    return [point1, point2];
  }

  static Future<double?> getElevation(LatLng point) async {
    final url = Uri.parse("https://api.open-elevation.com/api/v1/lookup?locations=${point.latitude},${point.longitude}");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"][0]["elevation"];
    } 
    return null;
  }

  /// Converts LatLng to Web Mercator projection (x, y in meters)
  static Point<double> projectMercator(LatLng latLng) {
    final x = equatorRadius * degreesToRadians(latLng.longitude);
    final y = equatorRadius * log(tan(pi / 4 + degreesToRadians(latLng.latitude) / 2));
    return Point(x, y);
  }

  /// Converts Web Mercator (x, y in meters) back to LatLng
  static LatLng unprojectMercator(Point<double> point) {
    final lng = radiansToDegrees(point.x / equatorRadius);
    final lat = radiansToDegrees(2 * atan(exp(point.y / equatorRadius)) - pi / 2);
    return LatLng(lat, lng);
  }
  
}
