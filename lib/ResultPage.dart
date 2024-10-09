import 'package:flutter/material.dart';
import 'package:flutter_warnet/Class.dart';

class ResultPage extends StatelessWidget {
  final Warnet warnet;

  ResultPage({required this.warnet});

  @override
  Widget build(BuildContext context) {
    double totalBayar = warnet.hitungTotalBayar();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Total Bayar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Pelanggan : ${warnet.pelanggan.kodePelanggan}',
                style: TextStyle(fontSize: 18)),
            Text('Nama Pelanggan : ${warnet.pelanggan.namaPelanggan}',
                style: TextStyle(fontSize: 18)),
            Text('Jenis Pelanggan : ${warnet.pelanggan.jenisPelanggan}',
                style: TextStyle(fontSize: 18)),
            Text('Lama Penggunaan : ${warnet.getLama()} jam',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Total Bayar : Rp $totalBayar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
