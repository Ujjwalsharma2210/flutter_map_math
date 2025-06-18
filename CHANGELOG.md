## 0.0.1
### Calculating Distance Between Two Points
### Calculating Bearing Between Two Points
### Calculating Destination Point
### Calculating Midpoint Between Two Points

## 0.0.2
updated docs

## 0.0.3
updated docs

## 0.0.4
fixes

## 0.0.5
fixes

## 0.0.6
added comments for better readability.

## 0.0.7
fixes

## 0.0.8
fixes

## 0.0.9
fixes

## 0.1.0
added 'calculateIntersection' function to find the intersection point of two lines.

## 0.1.1
Added proximity detection function

## 0.1.2
Added function to create virtual boundaries

## 0.1.3
Added function to find area of the shape

## 0.1.4
minor fix

## 0.1.5
Instead of passing latitude and longitude to the **calculateIntersection** function, just pass the two points as **LatLng** objects.

## 0.1.6
Instead of passing latitude and longitude to the **midpointBetween** function, just pass the two points as **LatLng** objects.


## 0.1.7
Corrected Distance Calculation:

Uses the Haversine formula, which correctly accounts for the Earth's curvature.
Computes the geodesic distance between two latitude/longitude points in kilometers.
Proper Threshold Units:

The distanceThresholdKm parameter is now explicitly in kilometers.


## 0.1.8
Added DBSCAN clustering


## 0.1.9
Added OPTICS clusterings

## 0.2.0
Added k-means clustering

## 0.2.1
Added getElevation in FlutterMapMath

## 0.2.2
Updated TODO

## 0.2.3
Added projectMercator and unprojectMercator
All methods in FlutterMapMath are now static