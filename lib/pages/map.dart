import 'package:alam_tracking/services/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    List<LatLng> data =
        ModalRoute.of(context)!.settings.arguments as List<LatLng>;
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(initialCenter: data[0], initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: data,
                    color: Colors.green.shade700,
                    strokeWidth: 9,
                  )
                ],
              )
            ],
          ),

          // action button
          Align(
            alignment: Alignment(0, -0.85),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 2.0),
                      ],
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: IconButton.filled(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 2.0),
                      ],
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: IconButton.filled(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
