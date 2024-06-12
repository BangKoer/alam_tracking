import 'package:alam_tracking/pages/map.dart';
import 'package:alam_tracking/services/api_controller.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    FetchMapAPI fetchapi = FetchMapAPI();

    String imgUrl = data["imageUrl"] ??
        "https://image.popbela.com/content-images/post/20220217/5c3ad1afcf887dcb01e22567c5c5b4b9.jpg?width=1600&format=webp&w=1600";
    String tempat = data["tempat"] ?? "";
    String deskripsi = data["deskripsi"] ?? "";
    String level = data["level"] ?? "";
    String panjang = data["panjang"] ?? "";
    String titik_awal = data["titik_awal"] ?? "";
    String titik_akhir = data["titik_akhir"] ?? "";
    String ketinggian_awal = data["ketinggian_awal"] ?? "";
    String ketinggian_akhir = data["ketinggian_akhir"] ?? "";
    return Scaffold(
      body: Stack(
        children: [
          // main page
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map
                Container(
                  width: double.infinity,
                  height: 480,
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    tempat,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    deskripsi,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                // Detail Text
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Detail_Route_Text(
                            logo: "speedometer.png",
                            name: "$level",
                            category: "Level"),
                        Detail_Route_Text(
                            logo: "distance.png",
                            name: "${panjang}/m",
                            category: "Panjang Rute"),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Detail_Route_Text(
                            logo: "altitude.png",
                            name: "${ketinggian_awal}/m",
                            category: "Ketinggian Awal"),
                        Detail_Route_Text(
                            logo: "altitude2.png",
                            name: "${ketinggian_akhir}/m",
                            category: "Ketinggian Akhir"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator()],
                                  ),
                                );
                              },
                            );
                            await fetchapi.mapTrail(titik_awal, titik_akhir);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Preview",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(0, 50),
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // show loading
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator()],
                                  ),
                                );
                              },
                            );
                            List routepoints = await fetchapi.mapTrail(
                                titik_awal, titik_akhir);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapPage(),
                                settings: RouteSettings(arguments: routepoints),
                              ),
                            );
                          },
                          child: Text(
                            "See Trail",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(0, 50),
                            backgroundColor: Colors.green[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          // action Button
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
                      color: Colors.grey[300],
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
                      color: Colors.grey[300],
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

class Detail_Route_Text extends StatelessWidget {
  final String logo;
  final String name;
  final String category;
  Detail_Route_Text({
    super.key,
    required this.name,
    required this.category,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/$logo', scale: 1.7),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              Text(
                category,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
