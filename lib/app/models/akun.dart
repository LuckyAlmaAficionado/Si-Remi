import 'package:simedi/app/models/jadwal.dart';

class Akun {
  final String uid;
  final String docId;

  final String nama;
  final String email;
  final String role;
  final List<Jadwal>? jadwal;

  Akun(
      {required this.uid,
      required this.docId,
      required this.nama,
      required this.email,
      required this.role,
      this.jadwal});

  factory Akun.fromJson(Map<String, dynamic> json) => Akun(
        uid: json['uid'],
        docId: json['docId'],
        nama: json['nama'],
        email: json['email'],
        role: json['role'],
        jadwal: json['jadwal'] != null
            ? (json['jadwal'] as List).map((e) => Jadwal.fromJson(e)).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'docId': docId,
        'nama': nama,
        'email': email,
        'role': role,
        'jadwal': jadwal,
      };
}
