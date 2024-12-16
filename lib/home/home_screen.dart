import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng _currentPosition = LatLng(10.8231, 106.6297); // Default location (HCMC)
  List<LatLng> _routeCoordinates = [];
  String _destinationAddress = '';
  LatLng? diaChi;


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(_currentPosition, 12.0); // Move the map to the default position
    });
  }

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permission is permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      // Save the user's current location to diaChi
      diaChi = LatLng(position.latitude, position.longitude);
      _currentPosition = diaChi!; // Ensure _currentPosition is set as well
      _mapController.move(_currentPosition, 12.0); // Move map to current location
    });

    // You can now use diaChi anywhere in the class.
    print('User\'s Location: ${diaChi?.latitude}, ${diaChi?.longitude}');
  }

  void _showRouteDialog() {
    showModalBottomSheet(
      context: context,

      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          height: 242,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Lộ trình đến đích",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Example of the route information (you can modify this with actual route data)
              Text("Bắt đầu :  ${diaChi?.latitude}, ${diaChi?.longitude}"),
              Text("Điểm đến: $_destinationAddress"),
              const SizedBox(height: 20),
              // Directions and actions buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fetch and show the route on the map
                      if (_destinationAddress.isNotEmpty) {
                        _fetchRoute(_currentPosition.latitude, _currentPosition.longitude);
                      } else {
                        _showSnackBar("Vui lòng nhập địa chỉ điểm đến.");
                      }
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text("Đường đi"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for saving the location
                    },
                    icon: const Icon(Icons.star),
                    label: const Text("Lưu "),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Center(child: Text("Xóa", style: TextStyle(color: Colors.black),)),
              ),
            ],
          ),
        );
      },
    );
  }
  // Function to fetch the route from OpenRouteService
  Future<void> _fetchRoute(double destLat, double destLon) async {
    final apiKey = '5b3ce3597851110001cf6248bb09b8df62444ea990c708b3f9833613'; // Replace with your OpenRouteService API key
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${_currentPosition.longitude},${_currentPosition.latitude}&end=$destLon,$destLat';
    print("Current Position: $_currentPosition");
    print("Destination: $_destinationAddress");

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data); // Add debug output to verify the data returned by the API
        if (data != null && data['features'] != null && data['features'].isNotEmpty) {
          final routeCoordinates = data['features'][0]['geometry']['coordinates'];

          print('Route Coordinates: $routeCoordinates'); // Debugging coordinates

          if (routeCoordinates != null && routeCoordinates.isNotEmpty) {
            setState(() {
              _routeCoordinates.clear();
              for (var coord in routeCoordinates) {
                // Reverse the order: coordinates are returned as [lon, lat], so we need to reverse it to [lat, lon]
                _routeCoordinates.add(LatLng(coord[1], coord[0])); // LatLng order: Lat, Lon
              }
            });

            // Center the map to the route start point
            _mapController.move(
              LatLng(_routeCoordinates.first.latitude, _routeCoordinates.first.longitude),
              12.0, // Adjust zoom level accordingly
            );
          } else {
            _showSnackBar("No route coordinates found.");
          }
        } else {
          _showSnackBar("No valid route data found.");
        }
      } else {
        _showSnackBar("Error fetching route.");
      }
    } catch (e) {
      _showSnackBar("Error: $e");
      print(e);
    }
  }



  // Function to search for a location by address
  Future<void> _searchLocation(String address) async {
    if (address.isEmpty) {
      _showSnackBar("Please enter an address.");
      return;
    }
    final url =
        "https://nominatim.openstreetmap.org/search?q=$address&format=json&limit=1";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          setState(() {
            _currentPosition = LatLng(lat, lon);
            _destinationAddress = data[0]['display_name'];
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController.move(_currentPosition, 15.0);
          });
          _showRouteDialog();
          _fetchRoute(lat, lon); // Fetch the route to the searched location
        } else {
          _showSnackBar("Location not found.");
        }
      } else {
        _showSnackBar("Error calling the API.");
      }
    } catch (e) {
      _showSnackBar("Connection error: $e");
      print(e);
    }
  }

  // Function to show a snack bar for error messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 30.0,
                    height: 30.0,
                    rotate: true,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routeCoordinates,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
          // Search location input field with white background
          Positioned(
            top: 60.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: "Nhập địa chỉ tìm kiếm ...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _searchLocation(_locationController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
