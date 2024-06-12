// import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final CollectionReference _trailPath =
    FirebaseFirestore.instance.collection("trail_path");
final CollectionReference _users =
    FirebaseFirestore.instance.collection('users');

class FirecloudStoreController {
  static Stream<QuerySnapshot> getData() {
    return _trailPath.snapshots();
  }

  Future<String> addphoto() async {
    String imageUrl = "";
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return "";

    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    // Get Storage Reference & create folder to store image
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirecImages = referenceRoot.child('images');

    // create reference for image to be stored
    Reference referenceImagetoUpload = referenceDirecImages.child(filename);
    try {
      await referenceImagetoUpload.putFile(
          File(file!.path), SettableMetadata(contentType: 'image/jpeg'));

      imageUrl = await referenceImagetoUpload.getDownloadURL();
      print(imageUrl);
    } catch (e) {
      print(e.toString());
    }
    return imageUrl;
  }

  Future<void> createTrailPath(
      String tempat,
      String deskripsi,
      String level,
      String panjang,
      String titik_awal,
      String titik_akhir,
      String ketinggian_awal,
      String ketinggian_akhir,
      String imageUrl,
      BuildContext context) async {
    try {
      await _trailPath.add({
        'tempat': tempat,
        'deskripsi': deskripsi,
        'level': level,
        'titik_awal': titik_awal,
        'titik_akhir': titik_akhir,
        'ketinggian_akhir': ketinggian_akhir,
        'ketinggian_awal': ketinggian_awal,
        'panjang': panjang,
        'image': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Added!"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something Error! ${e}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Future<void> deletebookmark(
  //     DocumentSnapshot? snapshot, BuildContext context) async {
  //   try {
  //     await _bookmark.doc(snapshot?.id).delete();
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Success Delete!"),
  //       backgroundColor: Colors.green,
  //     ));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Failed!"),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  // Future<void> updatebookmark(
  //   DocumentSnapshot? snapshot,
  //   String imgUrl,
  //   String title,
  //   String author,
  //   String publisher,
  //   String date,
  //   String desc,
  //   BuildContext context,
  // ) async {
  //   try {
  //     await _bookmark.doc(snapshot?.id).update({
  //       'imgUrl': imgUrl,
  //       'title': title,
  //       'author': author,
  //       'publisher': publisher,
  //       'date': date,
  //       'desc': desc,
  //     });
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Updated!"),
  //       backgroundColor: Colors.green,
  //     ));
  //   } catch (e) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Failed To Update!"),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }
}
