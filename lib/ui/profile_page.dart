import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/ui/login_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = 'profile_page';
  String text = 'nama';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    String currentUser = firebase.currentUser!.uid.toString();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc('$currentUser').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  var nama = data['nama'];
                  widget.text = nama;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: secondaryColor),
                          ],
                          borderRadius: BorderRadius.circular(100.0),
                          gradient: LinearGradient(
                            colors: [secondaryColor, whiteBackground],
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 85.0,
                              backgroundImage: _image != null
                                  ? FileImage(_image) as ImageProvider
                                  : AssetImage('assets/logo.png'),
                            ),
                            Positioned(
                              bottom: 20.0,
                              right: 40.0,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => popUpOption()),
                                  );
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: secondaryColor,
                                  size: 28.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Center(
                        child: Text(
                          '${data['nama']}',
                          style: TextStyle(
                              fontSize: 28.0,
                              color: darkPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 350,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            color: whiteBackground,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email: ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: greyOutline,
                              ),
                            ),
                            Text(
                              '${data['email']}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'NPM: ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: greyOutline,
                              ),
                            ),
                            Text(
                              '${data['npm']}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Program Studi: ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: greyOutline,
                              ),
                            ),
                            Text(
                              '${data['prodi']}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Fakultas: ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: greyOutline,
                              ),
                            ),
                            Text(
                              '${data['fakultas']}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        child: Text('Log Out',
                            style: Theme.of(context).textTheme.headline6),
                        color: secondaryColor,
                        height: 53,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          await firebase.signOut();
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        },
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget popUpOption() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text('Pilih Foto Profile',
              style: Theme.of(context).textTheme.headline5),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Camera'),
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_size_select_actual_outlined),
                label: Text('Gallery'),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    var pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
