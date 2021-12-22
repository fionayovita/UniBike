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
        toolbarHeight: 65,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(10.0), child: _listPinjam(context)),
        ),
      ),
    );
  }

  Widget _listPinjam(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: history
          .doc(firebase.currentUser?.uid)
          .collection('user_history')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
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
            });
      },
    );
  }
}
