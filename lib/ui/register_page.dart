import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();
  final _npmController = TextEditingController();
  final _prodiController = TextEditingController();
  final _fakultasController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkPrimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                Hero(
                  tag: 'UniBike',
                  child: Text(
                    'UniBike',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  cursorColor: primaryColor,
                  controller: _passwordController,
                  obscureText: _obscureText,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  controller: _npmController,
                  decoration: InputDecoration(
                    hintText: 'NPM',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  controller: _prodiController,
                  decoration: InputDecoration(
                    hintText: 'Program Studi',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: TextStyle(color: primaryColor),
                  controller: _fakultasController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Fakultas',
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(height: 24.0),
                MaterialButton(
                  child: Text('Register'),
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final nama = _namaController.text;
                      final npm = _npmController.text;
                      final prodi = _prodiController.text;
                      final fakultas = _fakultasController.text;

                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      //   .then((value) async {
                      // User user = _auth.currentUser!;

                      _store.collection('users').add({
                        'email': email,
                        'password': password,
                        'nama': nama,
                        'npm': npm,
                        'prodi': prodi,
                        'fakultas': fakultas
                        // });
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
                TextButton(
                  child: Text('Already have an account? Login',
                      style: TextStyle(color: secondaryColor)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
