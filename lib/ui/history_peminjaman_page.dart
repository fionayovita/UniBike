import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/widgets/card_history.dart';

class HistoryPeminjamanPage extends StatelessWidget {
  static const routeName = 'history_peminjaman_page';
  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final CollectionReference history =
      FirebaseFirestore.instance.collection('history_peminjaman');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Riwayat Peminjaman',
            style: Theme.of(context).textTheme.headline5),
        toolbarHeight: 70,
        bottom: PreferredSize(
            child: Container(
              color: Colors.black12,
              height: 0.3,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(0.0), child: _listPinjam(context)),
        ),
      ),
    );
  }

  Widget _listPinjam(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: history
            .doc(firebase.currentUser?.uid)
            .collection('user_history')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/logoBulet.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                      'Terjadi kesalahan, silahkan kembali ke halaman sebelumnya.',
                      style: Theme.of(context).textTheme.headline5)
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/logoBulet.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 15.0),
                  Text('Tidak ada riwayat peminjaman',
                      style: Theme.of(context).textTheme.headline5)
                ],
              ),
            );
          }

          return snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    final jenisSepeda = data['jenis_sepeda'];
                    final fakultas = data['fakultas'];
                    final waktuPinjam = data['waktu_pinjam'];
                    final waktuKembali = data['waktu_kembali'];

                    return CardHistory(
                        jenisSepeda: jenisSepeda,
                        fakultas: fakultas,
                        waktuPinjam: waktuPinjam,
                        waktuKembali: waktuKembali);
                  },
                )
              : Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/logoBulet.png',
                        width: 250,
                        height: 250,
                      ),
                      SizedBox(height: 15.0),
                      Text('Tidak ada riwayat peminjaman.',
                          style: Theme.of(context).textTheme.headline5)
                    ],
                  ),
                );
        },
      ),
    );
  }
}
