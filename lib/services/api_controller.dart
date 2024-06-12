import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

class FetchMapAPI {
  // Get Map trail
  Future<List> mapTrail(String start, String end) async {
    List<LatLng> routpoint = [];
    List<Location> start_l = await locationFromAddress(start);
    List<Location> end_l = await locationFromAddress(end);

    var v1 = start_l[0].latitude;
    var v2 = start_l[0].longitude;
    var v3 = end_l[0].latitude;
    var v4 = end_l[0].longitude;

    Response response = await get(Uri.parse(
        "http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full"));
    print(response.body);
    routpoint = [];
    var ruter =
        jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
    for (int i = 0; i < ruter.length; i++) {
      var reep = ruter[i].toString();
      reep = reep.replaceAll("[", "");
      reep = reep.replaceAll("]", "");
      var lat1 = reep.split(',');
      var long1 = reep.split(",");
      routpoint.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
    }
    print(routpoint);
    return routpoint;
    // Map dataFetch = jsonDecode(response.body);
    // if (dataFetch.isNotEmpty) {
    //   print(dataFetch);
    //   return dataFetch['items'];
    // } else {
    //   print(dataFetch);
    //   return [];
    // }
  }
}
