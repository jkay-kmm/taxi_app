import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widget/ride_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            content(),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: const Center(
                      child: Text(
                        "Taxi App",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        print("Menu clicked");
                        // Show menu logic
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {
                          print("Notifications clicked");
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(21.0278, 105.8342),
        initialZoom: 13,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.doubleTapZoom,
        ),
      ),
      children: [
        openStreetMapTileLayer,
        const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(21.0278, 105.8342),
              width: 50,
              height: 50,
              child: Icon(
                Icons.location_on,
                size: 50,
                color: Colors.blue, // Vị trí người dùng
              ),
            ),
            Marker(
              point: LatLng(21.0352, 105.5390),
              width: 40,
              height: 40,
              child: Icon(
                Icons.location_pin,
                size: 40,
                color: Colors.blue, // Xe taxi gần nhất
              ),
            ),
          ],
        ),
        // const CircleLayer(
        //   circles: [
        //     CircleMarker(
        //       point: LatLng(21.0278, 105.8342),
        //       color: Color(0xFFCCCCCC),
        //       radius: 50, // Vòng tròn bán kính 150m
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  minZoom: 0,
);
