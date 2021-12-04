import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor
                      //blurRadius: 10.0
                    )
                  ],
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: LinearGradient(
                    colors: [secondaryColor, whiteBackground]
                  )
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Text('P', style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              SizedBox(height: 25.0),
              Center(
                child: Text('Giandra Nareswara', style: TextStyle(
                  fontSize: 28.0,
                  color: darkPrimaryColor,
                  fontWeight: FontWeight.bold
                ))
              ),
              Container(
              width: 350,
              height: 200,  
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: whiteBackground,
                borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                    'Email : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'NPM :',
                    style: Theme.of(context).textTheme.headline5,
                    ),
                  Text(
                    'Program Studi : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),  
                  Text(
                    'Fakultas : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),  
                  ]
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
