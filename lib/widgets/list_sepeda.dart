import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibike/api/api_service.dart';
import 'package:unibike/provider/bike_provider.dart';
import 'package:unibike/widgets/card_sepeda.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class ListSepeda extends StatelessWidget {
  int length;
  ListSepeda({required this.length});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BikeProvider>(
      create: (_) => BikeProvider(apiService: ApiService()).getBikes(),
      child: Consumer<BikeProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            var bike = state.result.bikes;
            return GridView.count(
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(length, (index) {
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
      ),
    );
  }
}