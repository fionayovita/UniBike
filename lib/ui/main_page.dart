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
          child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 700) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 17.0, vertical: 20.0),
            child: _textField(context)
          );
        } else if (constraints.maxWidth <= 1500) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 200.0, vertical: 20.0),
            child: _textField(context)
          );
        }
        else {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 550.0, vertical: 20.0),
            child: _textField(context)
            );
          } 
        },
      ),
    ),
  ),
);
}


Widget _textField(BuildContext context) {
    return 
Column(
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
            );
}
}