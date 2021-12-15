import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            'P',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
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
                        // textTheme: ButtonTextTheme.primary,
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
}
