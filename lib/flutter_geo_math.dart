library flutter_geo_math;

import 'dart:math';
import 'lat_lng.dart';

/// Map related calculations class
class FlutterGeoMath {
  /// converts kilometers to desired(meters, miles, yards) units
  double toRequestedUnit(String unit, double distanceInKm) {
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
  double distanceBetween(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    const earthRadius = 6371; // in km
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

    final distance = earthRadius * c;

    return toRequestedUnit(unit, distance);

    // return distance; // in km
  }

  /// Returns bearing angle in degrees.
  /// Bearing angle => A bearing describes a line as heading north or south, and
  /// deflected some number of degrees toward the east or west. A bearing,
  /// therefore, will always have an angle less than 90°.
  double bearingBetween(double lat1, double lon1, double lat2, double lon2) {
    var dLon = degreesToRadians(lon2 - lon1);
    var y = sin(dLon) * cos(degreesToRadians(lat2));
    var x = cos(degreesToRadians(lat1)) * sin(degreesToRadians(lat2)) -
        sin(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * cos(dLon);
    var angle = degreesToRadians(atan2(y, x));
    return (angle + 360) % 360;
  }

  /// Uses a point, distance and bearing anlge to find the destination point.
  /// Returns LatLng Object
  LatLng destinationPoint(
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
  LatLng midpointBetween(double lat1, double lng1, double lat2, double lng2) {
    // double dLat = degreesToRadians(lat2 - lat1);
    double dLng = degreesToRadians(lng2 - lng1);
    double lat1Radians = degreesToRadians(lat1);
    double lat2Radians = degreesToRadians(lat2);

    double bX = cos(lat2Radians) * cos(dLng);
    double bY = cos(lat2Radians) * sin(dLng);
    double midLatRadians = atan2(sin(lat1Radians) + sin(lat2Radians),
        sqrt((cos(lat1Radians) + bX) * (cos(lat1Radians) + bX) + bY * bY));
    double midLngRadians =
        degreesToRadians(lng1) + atan2(bY, cos(lat1Radians) + bX);

    double midLat = radiansToDegrees(midLatRadians);
    double midLng = radiansToDegrees(midLngRadians);

    return LatLng(midLat, midLng);
  }

  /// Convert degrees to radians
  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// converts radians to degrees
  double radiansToDegrees(double radians) {
    return radians * 180 / pi;
  }
}
