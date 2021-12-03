import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/model/bike_model.dart';

class BikeDetailPage extends StatelessWidget {
  static const routeName = 'detail_page';

  final Bike bike;
  const BikeDetailPage({required this.bike});

  @override
  Widget build(BuildContext context) {
    var id = bike.id;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: width,
              height: 400,
              child: Hero(
                tag: bike.largeImg!,
                child: Image.network(
                  bike.largeImg!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                child: IconButton(
                    icon: Icon(Icons.arrow_back, color: primaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 380),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
              decoration: BoxDecoration(
                  color: whiteBackground,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike.title ?? '-',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Divider(color: darkPrimaryColor),
                  SizedBox(height: 30),
                  Text(
                    'Id Sepeda: $id',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Jenis Sepeda: ${bike.frameModel ?? "-"}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 80),
                  Text(
                    'Keterangan:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Batas waktu peminjaman sepeda selama 2 jam.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            content: Text(
                              'Sukses Pinjam Sepeda dengan id: $id',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text('Pinjam',
                            style: Theme.of(context).textTheme.headline6),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(width, 50),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
