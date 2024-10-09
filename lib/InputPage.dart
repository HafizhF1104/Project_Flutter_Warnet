import 'package:flutter/material.dart';
import 'package:flutter_warnet/Class.dart';
import 'package:flutter_warnet/ResultPage.dart';

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  // TextEditingController untuk mengambil input dari TextField
  TextEditingController namaController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController jamMasukController = TextEditingController();
  TextEditingController jamKeluarController = TextEditingController();

  // Variabel untuk menampung data jenis pelanggan dan tanggal
  String? selectedJenisPelanggan; // Ini untuk dropdown jenis pelanggan
  DateTime? selectedDate; // Ini untuk menyimpan tanggal yang dipilih

  // Fungsi untuk menampilkan DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal default adalah hari ini
      firstDate: DateTime(2000), // Rentang awal tahun
      lastDate: DateTime(2100), // Rentang akhir tahun
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Fungsi submit untuk memproses data input
  void submitData() {
    String nama = namaController.text;
    String kode = kodeController.text;
    String jenis = selectedJenisPelanggan ?? ''; // Ambil dari dropdown
    String tglMasuk = selectedDate != null
        ? selectedDate!.toIso8601String().substring(0, 10)
        : '';
    double jamMasuk = double.tryParse(jamMasukController.text) ?? 0.0;
    double jamKeluar = double.tryParse(jamKeluarController.text) ?? 0.0;

    if (jamKeluar > jamMasuk &&
        selectedJenisPelanggan != null &&
        selectedDate != null) {
      Pelanggan pelanggan = Pelanggan(
        kodePelanggan: kode,
        namaPelanggan: nama,
        jenisPelanggan: jenis,
      );
      Warnet warnet = Warnet(
        pelanggan: pelanggan,
        tglMasuk: tglMasuk,
        jamMasuk: jamMasuk,
        jamKeluar: jamKeluar,
      );

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ResultPage(warnet: warnet)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pastikan semua data telah diisi dengan benar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Warnet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Kode Pelanggan
            TextField(
              controller: kodeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Kode Pelanggan'),
            ),
            SizedBox(height: 20),
            // Input Nama Pelanggan
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nama Pelanggan'),
            ),
            SizedBox(height: 20),
            // Dropdown untuk Jenis Pelanggan
            DropdownButtonFormField<String>(
              value: selectedJenisPelanggan,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Jenis Pelanggan'),
              items: ['VIP', 'GOLD', 'REGULAR'].map((String jenis) {
                return DropdownMenuItem<String>(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedJenisPelanggan = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            // DatePicker untuk Tanggal Masuk
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Pilih Tanggal Masuk'
                        : 'Tanggal Masuk: ${selectedDate!.toLocal()}'
                            .split(' ')[0],
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Pilih Tanggal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Input Jam Masuk
            TextField(
              controller: jamMasukController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Jam Masuk'),
            ),
            SizedBox(height: 20),
            // Input Jam Keluar
            TextField(
              controller: jamKeluarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Jam Keluar'),
            ),
            SizedBox(height: 20),
            // Tombol untuk menghitung total bayar
            ElevatedButton(
              onPressed: submitData,
              child: Text('Hitung Total Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
