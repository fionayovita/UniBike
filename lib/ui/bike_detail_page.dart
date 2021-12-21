import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/model/bike_model.dart';
import 'package:unibike/provider/alarm_provider.dart';
import 'package:unibike/provider/preferences_provider.dart';
import 'package:unibike/ui/status_pinjam_page.dart';
import 'package:unibike/widgets/custom_dialog.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class BikeDetailPage extends StatefulWidget {
  static const routeName = 'detail_page';

  final firebase = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final Bike bike;
  final String fakultas;
  BikeDetailPage({required this.bike, required this.fakultas});

  @override
  State<BikeDetailPage> createState() => _BikeDetailPageState();
}

class _BikeDetailPageState extends State<BikeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 700) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: _textField(context));
            } else if (constraints.maxWidth <= 1100) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 20.0),
                  child: _textField(context));
            } else {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 400.0, vertical: 20.0),
                  child: _textField(context));
            }
          },
        ),
      ),
    );
  }

  Widget _textField(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var id = widget.bike.id;
    String emailUser = widget.firebase.currentUser!.email.toString();

    return Stack(
      children: [
        Container(
          width: width,
          height: 400,
          child: Hero(
            tag: widget.bike.largeImg!,
            child: Image.network(
              widget.bike.largeImg!,
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
              },
            ),
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
                widget.bike.title ?? '-',
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
                'Jenis Sepeda: ${widget.bike.frameModel ?? "-"}',
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
                child: Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                    return Consumer<SchedulingProvider>(
                      builder: (context, scheduled, child) {
                        return ElevatedButton(
                          onPressed: () {
                            bool _isLoading = false;
                            try {
                              final jenisSepeda = widget.bike.frameModel;
                              var today = DateTime.now();
                              final dateFormatPinjam =
                                  DateFormat('EEE d MMM, hh:mm a')
                                      .format(today);
                              var kembali = today.add(Duration(hours: 2));
                              final dateFormatKembali =
                                  DateFormat('EEE d MMM, hh:mm a')
                                      .format(kembali);

                              widget._store
                                  .collection('data_peminjaman')
                                  .doc(widget.firebase.currentUser?.uid)
                                  .set(
                                {
                                  'id_sepeda': id,
                                  'jenis_sepeda': jenisSepeda,
                                  'email_peminjam': emailUser,
                                  'waktu_pinjam': dateFormatPinjam,
                                  'waktu_kembali': dateFormatKembali,
                                  'fakultas': widget.fakultas
                                },
                              );

                              scheduled.scheduledNews(true);
                              provider.enableAlarm(true);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Sukses Pinjam Sepeda!',
                                    descriptions:
                                        'Silahkan cek status peminjaman di halaman Status Pinjam untuk melihat lebih detail',
                                    text: 'OK',
                                  );
                                },
                              );

                              final snackBar = SnackBar(
                                content: Text(
                                  'Sukses Pinjam Sepeda dengan id: $id',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              final snackbar =
                                  SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Peminjaman Gagal',
                                    descriptions:
                                        'Error: ${e.toString()}. Silahkan coba lagi beberapa saat kemudian!',
                                    text: 'OK',
                                  );
                                },
                              );
                            } finally {
                              setState(
                                () {
                                  widget.fakultas;
                                  print('di finally: ${widget.fakultas}');
                                  _isLoading = false;
                                },
                              );
                            }
                          },
                          child: Text('Pinjam',
                              style: Theme.of(context).textTheme.headline6),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(width, 50)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
