import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class MainPage extends StatelessWidget {
  static const routeName = 'main_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi! Bikers",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 15.0),
              Text(
                "Find a Bike to go\naround the Campus",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 15.0),
              DropDownMenu()
            ],
          ),
        ),
      )),
    );
  }
}
