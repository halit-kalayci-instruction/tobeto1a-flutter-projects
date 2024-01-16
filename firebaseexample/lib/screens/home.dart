import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;
final firebaseFireStore = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _pickedFile;
  String _imageUrl = '';

  @override
  void initState() {
    _getUserImage();
    super.initState();
  }

  void _getUserImage() async {
    final user = firebaseAuthInstance.currentUser;
    final document = firebaseFireStore.collection("users").doc(user!.uid);
    final documentSnapshot = await document.get();

    setState(() {
      _imageUrl = documentSnapshot.get("imageUrl");
    });
  }

  void _pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (image != null) {
      setState(() {
        _pickedFile = File(image.path);
      });
    }
  }

  void _upload() async {
    final user = firebaseAuthInstance.currentUser;
    final storageRef =
        firebaseStorageInstance.ref().child("images").child("${user!.uid}.jpg");

    await storageRef.putFile(_pickedFile!);

    final url = await storageRef.getDownloadURL();

    final document = firebaseFireStore.collection("users").doc(user!.uid);

    await document.update({'imageUrl': url});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Application"),
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuthInstance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (_imageUrl.isNotEmpty && _pickedFile == null)
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              foregroundImage: NetworkImage(_imageUrl),
            ),
          if (_pickedFile != null)
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              foregroundImage: FileImage(_pickedFile!),
            ),
          TextButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text("Resim Seç")),
          if (_pickedFile != null)
            ElevatedButton(
                onPressed: () {
                  _upload();
                },
                child: const Text("Yükle"))
        ]),
      ),
    );
  }
}
