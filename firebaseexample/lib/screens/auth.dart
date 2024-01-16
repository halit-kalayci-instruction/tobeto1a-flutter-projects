import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _password = '';

  void _submit() async {
    _formKey.currentState!.save();

    if (_isLogin) {
      // Giriş Sayfası
      try {
        final userCredentials = await firebaseAuthInstance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print(userCredentials);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Giriş Başarısız")));
      }
    } else {
      // Kayıt Sayfası
      try {
        final userCredentials = await firebaseAuthInstance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print(userCredentials);
        firebaseFirestore
            .collection("users")
            .doc(userCredentials.user!
                .uid) // içerisine id aldığında o id'yi almadığına AUTO-ID kullanır.
            .set({'email': _email}); // Verilen değeri ilgili dökümana yazar.
      } on FirebaseAuthException catch (error) {
        // Hata mesajı göster..
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? "Kayıt başarısız.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "E-posta"),
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {},
                          onSaved: (newValue) {
                            _email = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Şifre"),
                          autocorrect: false,
                          obscureText: true,
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Text(_isLogin ? "Giriş Yap" : "Kayıt Ol")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? "Kayıt Sayfasına Git"
                                : "Giriş Sayfasına Git"))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
