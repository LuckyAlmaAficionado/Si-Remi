class Jadwal {
  final String namaObat;
  final String dosisObat;
  final String statusMinum;
  final String waktu;
  final String tanggal;
  bool status;

  Jadwal({
    required this.namaObat,
    required this.dosisObat,
    required this.statusMinum,
    required this.waktu,
    required this.tanggal,
    required this.status,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        namaObat: json['namaObat'],
        dosisObat: json['dosisObat'],
        statusMinum: json['statusMinum'],
        waktu: json['waktu'],
        tanggal: json['tanggal'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'namaObat': namaObat,
        'dosisObat': dosisObat,
        'statusMinum': statusMinum,
        'waktu': waktu,
        'tanggal': tanggal,
        'status': status,
      };
}
