import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/model/bike_model.dart';
import 'package:unibike/ui/bike_detail_page.dart';

class CardSepedaArgs {
  final Bike bike;
  final String? fakultas;

  CardSepedaArgs({required this.bike, required this.fakultas});
}

class CardSepeda extends StatelessWidget {
  final Bike bike;
  final String? fakultas;

  CardSepeda({required this.bike, required this.fakultas});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BikeDetailPage.routeName, arguments: CardSepedaArgs(bike: bike, fakultas: fakultas));
      },
      child: Card(
        elevation: 2,
        shadowColor: greyButton,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Image.network(bike.largeImg!, fit: BoxFit.cover),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Text(
                bike.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
