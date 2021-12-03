import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibike/api/api_service.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/provider/bike_provider.dart';
import 'package:unibike/widgets/card_sepeda.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class MainPage extends StatefulWidget {
  static const routeName = 'main_page';
  // String fakultasPilih;
  // _MainPageState({required this.fakultasPilih});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String fakultasPilih = '';
  // _MainPageState({required this.fakultasPilih});
  // List _lengthFakultas = [6, 5, 10, 15, 4, 8, 3, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi! Bikers",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 15.0),
              Text(
                "Find a Bike to go\naround the Campus",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 25.0),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: DropDownMenu(),
              ),
              SizedBox(height: 15.0),
              ChangeNotifierProvider<BikeProvider>(
                  create: (_) =>
                      BikeProvider(apiService: ApiService()).getBikes(),
                  child: _buildList())
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildList() {
    return Consumer<BikeProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var bike = state.result.bikes;
          return GridView.count(
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(bike.length, (index) {
              return CardSepeda(bike: bike[index]);
            }),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(
              child:
                  Text(state.message, style: TextStyle(color: Colors.black)));
        } else {
          return Center(
              child: Text('error', style: TextStyle(color: Colors.black)));
        }
      },
    );
  }
}
