import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibike/api/api_service.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/provider/bike_provider.dart';
import 'package:unibike/widgets/card_sepeda.dart';
import 'package:unibike/widgets/dropdown_menu.dart';
import 'package:unibike/widgets/list_sepeda.dart';

class MainPage extends StatefulWidget {
  static const routeName = 'main_page';
  final _store = FirebaseFirestore.instance;
  final firebase = FirebaseAuth.instance;
  String fakultas = '';

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // String currentUser = widget.firebase.currentUser!.uid.toString();

    return Scaffold(
      backgroundColor: whiteBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, bikers!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                // FutureBuilder<DocumentSnapshot>(
                //   future: widget.users.doc('$currentUser').get(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                //     if (snapshot.hasError) {
                //       Text("Something went wrong");
                //     }

                //     if (snapshot.hasData && !snapshot.data!.exists) {
                //       Text("Document does not exist");
                //     }

                //     if (snapshot.connectionState == ConnectionState.done) {
                //       Map<String, dynamic> data =
                //           snapshot.data!.data() as Map<String, dynamic>;
                //       var nama = data['nama'];
                //       return Text(
                //         "Hi, $nama!",
                //         style: Theme.of(context).textTheme.headline5,
                //       );
                //     }
                //     return Text('Loading');
                //   },
                // ),
                SizedBox(height: 15.0),
                Text(
                  "Find a Bike to go\naround the Campus",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 25.0),
                DropDownMenu(onChanged: (value) {
                  widget.fakultas = value;
                  print('DIMAIN BARU: ${widget.fakultas}');
                }),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
