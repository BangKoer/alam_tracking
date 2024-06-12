import 'dart:io';

import 'package:alam_tracking/pages/detailpage.dart';
import 'package:alam_tracking/services/fireabse_cloudFirestoreController.dart';
import 'package:alam_tracking/services/firebase_authController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tempat_c = TextEditingController();
  final deskripsi_C = TextEditingController();
  final level_C = TextEditingController();
  final panjang_C = TextEditingController();
  final titik_awal_C = TextEditingController();
  final titik_akhir_C = TextEditingController();
  final ketinggian_awal_C = TextEditingController();
  final Ketinggian_akhir_C = TextEditingController();
  String? imageUrl;
  FirecloudStoreController _cloudStore = FirecloudStoreController();
  final FirebaseAuthController _auth = FirebaseAuthController();

  String? selectedValue;
  List<dynamic> productTypesList = [
    {"val": "1", "label": "Simple"},
    {"val": "2", "label": "Variable"},
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tempat_c.dispose();
    level_C.dispose();
    deskripsi_C.dispose();
    panjang_C.dispose();
    titik_awal_C.dispose();
    titik_akhir_C.dispose();
    ketinggian_awal_C.dispose();
    Ketinggian_akhir_C.dispose();
  }

  void clear() {
    tempat_c.clear();
    deskripsi_C.clear();
    level_C.clear();
    panjang_C.clear();
    titik_awal_C.clear();
    titik_akhir_C.clear();
    ketinggian_awal_C.clear();
    Ketinggian_akhir_C.clear();
  }

  void Add_data() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Data Rute"),
          actions: [
            // save button
            MaterialButton(
              onPressed: () async {
                if (imageUrl!.isNotEmpty) {
                  await _cloudStore.createTrailPath(
                      tempat_c.text,
                      deskripsi_C.text,
                      level_C.text,
                      panjang_C.text,
                      titik_awal_C.text,
                      titik_akhir_C.text,
                      ketinggian_awal_C.text,
                      Ketinggian_akhir_C.text,
                      imageUrl!,
                      context);
                  Navigator.pop(context);
                  clear();
                  imageUrl = "";
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Image Required!"),
                    backgroundColor: Colors.yellow,
                  ));
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
            // Cancel button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Nama Tempat"),
                  controller: tempat_c,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Deskripsi"),
                  controller: deskripsi_C,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Level"),
                  controller: level_C,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Panjang Rute"),
                  controller: panjang_C,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Titik Awal"),
                  controller: titik_awal_C,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Titik Akhir"),
                  controller: titik_akhir_C,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Ketinggian Awal"),
                  controller: ketinggian_awal_C,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Ketinggian Akhir"),
                  controller: Ketinggian_akhir_C,
                  keyboardType: TextInputType.number,
                ),
                ListTile(
                  title: Text("Add Picture"),
                  trailing: IconButton(
                      onPressed: () async {
                        imageUrl = await _cloudStore.addphoto() as String;
                      },
                      icon: Icon(Icons.camera_alt)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Add_data(),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.green[700],
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              Icon(
                Icons.map,
                color: Colors.green[700],
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Nature Path App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            size: 25,
            color: Colors.grey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _auth.signOut();
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.green[700],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 6,
            ),
            // Dropdown Filter
            Text(
              "Select Your Skill Level and Region",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<dynamic>(
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Level',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Text("Easy"),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text("Normal"),
                      ),
                      DropdownMenuItem(
                        value: "3",
                        child: Text("Hard"),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Add some space between the two dropdowns
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedValue,
                    onChanged: (value) {
                      // Handle dropdown selection
                    },
                    decoration: InputDecoration(
                      labelText: 'Region',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Text("SEA"),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text("America"),
                      ),
                      DropdownMenuItem(
                        value: "3",
                        child: Text("NA"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            // list of path
            Text(
              "Select Your Path",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 9,
            ),
            // Select Path
            StreamBuilder(
                stream: FirecloudStoreController.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 270,
                      ),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(),
                                  settings: RouteSettings(arguments: {
                                    'imageUrl': documentSnapshot['image'],
                                    'tempat': documentSnapshot['tempat'],
                                    'deskripsi': documentSnapshot['deskripsi'],
                                    'level': documentSnapshot['level'],
                                    'panjang': documentSnapshot['panjang'],
                                    'titik_awal':
                                        documentSnapshot['titik_awal'],
                                    'titik_akhir':
                                        documentSnapshot['titik_akhir'],
                                    'ketinggian_awal':
                                        documentSnapshot['ketinggian_awal'],
                                    'ketinggian_akhir':
                                        documentSnapshot['ketinggian_akhir'],
                                  })),
                            );
                          },
                          child: Path_Tile(
                              panjang: documentSnapshot['panjang'] + ' m',
                              level: documentSnapshot['level'],
                              name: documentSnapshot['tempat'],
                              url: documentSnapshot['image']),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}

class Path_Tile extends StatelessWidget {
  final String name;
  final String level;
  final String panjang;
  final String url;
  const Path_Tile(
      {super.key,
      required this.name,
      required this.url,
      required this.level,
      required this.panjang});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 170,
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // img
            Container(
              height: 190,
              width: double.infinity,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 7),
            // Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        level,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        panjang,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
