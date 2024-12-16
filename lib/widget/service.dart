import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
  const apiKey = "5b3ce3597851110001cf6248bb09b8df62444ea990c708b3f9833613";
  final url = Uri.parse("https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey");

  final body = json.encode({
    "coordinates": [
      [start.longitude, start.latitude],
      [end.longitude, end.latitude]
    ]
  });

  final response = await http.post(url, headers: {
    "Content-Type": "application/json",
  }, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final routeGeometry = data['routes'][0]['geometry'];
    return _decodePolyline(routeGeometry);
  } else {
    throw Exception('Failed to load route');
  }
}

List<LatLng> _decodePolyline(String polyline) {
  var decoded = decodeEncodedPolyline(polyline);
  return decoded.map((point) {
    return LatLng(point[1], point[0]); // Đổi lại vì polyline là [longitude, latitude]
  }).toList();
}

List<List<double>> decodeEncodedPolyline(String encoded) {
  List<List<double>> polyline = [];
  int index = 0, len = encoded.length;
  int latitude = 0, longitude = 0;

  while (index < len) {
    int shift = 0, result = 0;
    int byte;
    do {
      byte = encoded.codeUnitAt(index++) - 63;
      result |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    latitude += deltaLat;

    shift = 0;
    result = 0;
    do {
      byte = encoded.codeUnitAt(index++) - 63;
      result |= (byte & 0x1F) << shift;
      shift += 5;
    } while (byte >= 0x20);
    int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    longitude += deltaLng;

    polyline.add([longitude * 1e-5, latitude * 1e-5]);
  }

  return polyline;
}
