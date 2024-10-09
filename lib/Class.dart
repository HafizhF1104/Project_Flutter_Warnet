class Pelanggan {
  String kodePelanggan;
  String namaPelanggan;
  String jenisPelanggan;

  Pelanggan({
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.jenisPelanggan,
  });
}

class Warnet {
  Pelanggan pelanggan;
  String tglMasuk;
  double jamMasuk;
  double jamKeluar;
  static const double tarif = 10000;

  Warnet({
    required this.pelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
  });

  double getLama() {
    return jamKeluar - jamMasuk;
  }

  double hitungTotalBayar() {
    double lama = getLama();
    double totalBayar = lama * tarif;
    double diskon = 0;

    if (pelanggan.jenisPelanggan == 'VIP' && lama > 2) {
      diskon = 0.02 * totalBayar;
    } else if (pelanggan.jenisPelanggan == 'GOLD' && lama > 2) {
      diskon = 0.05 * totalBayar;
    }

    return totalBayar - diskon;
  }
}
