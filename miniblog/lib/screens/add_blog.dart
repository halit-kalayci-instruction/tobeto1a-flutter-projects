import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as http;

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  String title = '';
  String content = '';
  String author = '';

  openImagePicker() async {
    XFile? selectedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  submitForm() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath("File", selectedImage!.path));
    }

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Blog Ekle")),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (selectedImage != null)
                  Image.file(File(selectedImage!.path),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitHeight),
                ElevatedButton(
                    onPressed: () {
                      openImagePicker();
                    },
                    child: const Text("Resim Seç")),
                TextFormField(
                  decoration:
                      const InputDecoration(label: Text("Blog Başlığı")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen Başlık Giriniz";
                    }
                    return null;
                  },
                  onSaved: (newValue) => title = newValue!,
                ),
                TextFormField(
                    decoration:
                        const InputDecoration(label: Text("Blog İçeriği")),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen İçerik Giriniz";
                      }
                      return null;
                    },
                    onSaved: (newValue) => content = newValue!),
                TextFormField(
                    decoration: const InputDecoration(label: Text("Ad Soyad")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen Ad Soyad Giriniz";
                      }
                      return null;
                    },
                    onSaved: (newValue) => author = newValue!),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedImage == null) {
                          // Validasyon hatası göster..
                          return;
                        }
                        // Validasyonlar başarılı
                        _formKey.currentState!.save();
                        submitForm();
                      }
                    },
                    child: const Text("Gönder"))
              ],
            ),
          )),
    );
  }
}
