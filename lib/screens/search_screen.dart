import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedVehicle = "Mini Bus";
  final List<Map<String, dynamic>> vehicles = [
  {
  "name": "Taxi 4 chỗ",
  "icon": Icons.directions_bus,
  "speed": "10 - 45 km/hr",
  "price": "100 / km",
},
{
"name": "Taxi 12",
"icon": Icons.airport_shuttle,
"speed": "20 - 80 km/hr",
"price": "200/ km",
},
    {
      "name": "Taxi 16",
      "icon": Icons.electric_car,
      "speed": "30 - 80 km/hr",
      "price": "300 / km",
    },
    {
      "name": "Xe khách",
      "icon": Icons.sports_motorsports,
      "speed": "75 - 120 km/hr",
      "price": "500 / km",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Loại xe")),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedVehicle = vehicle['name'];
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: selectedVehicle == vehicle['name']
                      ? Colors.blue[50]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedVehicle == vehicle['name']
                        ? Colors.blue
                        : Colors.grey[300]!,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    vehicle['icon'],
                    color: Colors.blue,
                    size: 40,
                  ),
                  title: Text(
                    vehicle['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.speed, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          vehicle['speed'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.monetization_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          vehicle['price'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  trailing: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedVehicle = vehicle['name'];
                      });
                    },
                    child: Text(
                      selectedVehicle == vehicle['name'] ? "Đã chọn" : "Lựa chọn",
                      style: TextStyle(
                        color: selectedVehicle == vehicle['name']
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  }

