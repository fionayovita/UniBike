import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class MainPage extends StatefulWidget {
  static const routeName = 'main_page';
  final firebase = FirebaseAuth.instance;
  String fakultas = '';

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
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
