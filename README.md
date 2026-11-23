# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Tugas 7
1. Widget tree adalah susunan semua widget di aplikasi Flutter yang berbentuk pohon, dengan satu root di atas. Widget yang membungkus widget lain disebut parent, dan yang dibungkus disebut child. Parent mengatur posisi dan memberi data ke child, dan kalau state berubah, widget itu beserta child-nya dibangun ulang. Di proyek ini, MaterialApp membungkus MyHomePage, yang mengembalikan Scaffold berisi AppBar dan body dengan Column yang menampung InfoCard dan ItemCard.
2. MaterialApp sebagai root aplikasi, Scaffold sebagai kerangka halaman, AppBar sebagai bar judul, Text untuk teks, Icon untuk ikon, Padding untuk jarak, Column dan Row untuk menyusun widget secara vertikal dan horizontal, Center untuk menengahkan, SizedBox untuk jarak kosong, Container untuk mengatur lebar dan padding, GridView.count untuk kisi tombol tiga kolom, Card untuk kartu info, Material untuk latar berwarna ItemCard, dan InkWell agar kartu bisa ditekan. Selain itu ada widget buatan sendiri, yaitu MyHomePage, InfoCard, dan ItemCard. Untuk notifikasi dipakai library fluttertoast, yang bukan widget bawaan.
3. MaterialApp menyediakan dasar Material Design untuk aplikasi, seperti judul, tema, halaman awal, dan navigasi. Widget seperti Scaffold dan AppBar butuh informasi dari atasnya, misalnya tema lewat Theme.of(context). Karena itu MaterialApp ditaruh di root supaya seluruh widget di bawahnya memakai tema dan layanan yang sama.
4. StatelessWidget tidak punya state, jadi tampilannya hanya bergantung pada properti yang diberikan dan tidak berubah sendiri. StatefulWidget punya kelas State yang menyimpan data berubah, dan tampilannya diperbarui saat state berubah. Pilih StatelessWidget untuk tampilan tetap seperti halaman menu di proyek ini, dan StatefulWidget untuk tampilan yang berubah, misalnya counter atau isian form.
5. BuildContext adalah penanda posisi sebuah widget di widget tree. Lewat context, widget bisa mengambil data dari widget di atasnya. Context diterima sebagai parameter di metode build, dan di proyek ini dipakai pada Theme.of(context) untuk mengambil warna tema serta MediaQuery.of(context) untuk mengambil lebar layar.
6. Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan dan membangun ulang widget tree tanpa menghilangkan state, tanpa menjalankan ulang main() dan initState(). Hot restart menjalankan aplikasi dari awal sehingga state hilang. Hot reload tidak cukup kalau perubahan ada di main() atau initState() (perlu hot restart), atau kalau mengubah kode native atau menambah dependensi di pubspec.yaml (perlu full restart, yaitu stop lalu run lagi). Contohnya saat saya menambahkan fluttertoast, aplikasi harus dijalankan ulang penuh.

## Strategi Prompting
Saya kirim pesan error atau screenshot-nya agar Claude bisa menebak penyebabnya dari kondisi nyata di laptop saya karena terjadi beberapa crash dan tidak sesuai hasil yang diharapkan

## AI Disclosure
Saya menggunakan Claude sebagai bantuan dalam beberapa bagian tugas ini, dengan rincian sebagai berikut:
1. Membantu mendiagnosis masalah instalasi: PATH tidak terbaca, error `WHERE` dan Git tidak ditemukan, serta isi folder Flutter yang tidak lengkap setelah diekstrak.
2. Membantu menjelaskan penyebab toast berwarna gradient di Chrome (web) 

## Bagian yang saya kerjakan sendiri
1. Menjalankan seluruh instalasi dan konfigurasi sendiri di laptop sampai flutter berjalan.
2. Menambahkan library fluttertoast untuk umpan balik saat tombol ditekan, menggantikan `SnackBar`(Creativity).
3. Menambahkan field color pada model ItemHomepage agar setiap tombol memiliki warna sendiri tanpa logika pewarnaan yang berulang
4. Mengganti data contoh Burhan dengan identitas saya sendiri, lalu menjalankan dan menguji aplikasi di Chrome

## Refleksi Proses
Tugas 07 membuat saya paham bahwa Flutter menyusun tampilan dari widget yang bersarang, dan bahwa memecahnya menjadi komponen yang bisa dipakai ulang seperti InfoCard dan ItemCard membuat kode lebih rapi. dan beberapa error saat di environment mengajarkan saya bagaimana jika terjadi situasi serupa kedepannya saat terjadi error di laptopku. Tugas 08 progresnya cukup lancar karena ada penjelasan cara bagaimana mengganti warna



### Tugas 8
1. Navigator.push() menambahkan halaman baru ke stack navigasi sehingga tombol Back pada perangkat atau Navigator.pop() dapat kembali ke halaman sebelumnya. Navigator.pushReplacement() menambahkan halaman baru sekaligus menggantikan halaman yang sedang aktif, sehingga tidak ada halaman lama di stack dan tombol Back tidak akan kembali ke halaman yang digantikan. Navigator.pop() mengeluarkan halaman teratas dari stack dan kembali ke halaman di bawahnya. Kami menggunakan Navigator.push() pada kartu aksi di halaman utama untuk membuka formulir sehingga pengguna dapat kembali dengan menekan tombol Back. Kami juga menggunakan Navigator.pushReplacement() di drawer untuk mengubah halaman yang sedang ditampilkan dengan MyHomePage, sehingga pengguna tidak akan kembali ke halaman formulir yang telah dibuka sebelumnya ketika mereka menekan tombol Back
2. Scaffold menyediakan kerangka dasar yang selalu ada (AppBar di atas, body di tengah, dan Drawer di sisi) sehingga setiap layar memiliki struktur yang konsisten. Misalnya, AppBar menampilkan judul dan warna tema, dan Drawer menawarkan navigasi keseluruhan halaman. Karena keduanya diatur di setiap halaman, seperti MyHomePage, ProjectFormPage, dan ExperienceFormPage, warna tema biru-indigo yang dipilih pada ThemeData muncul di AppBar dan pada background kartu, sehingga warna portofolio muncul di lebih dari satu halaman
3. Dalam SingleChildScrollView, formulir dipilih menggunakan kolom karena layar ponsel sering terbatas tinggi. Sementara itu, SingleChildScrollView memungkinkan pengguna menggulir ketika keyboard muncul atau ketika konten melebihi tinggi layar. Widget Padding dan SizedBox berfungsi untuk mengatur jarak antar field sehingga tampilan tidak menempel dan rapi, dan SingleChildScrollView menjaga semua input tetap dapat dijangkau
4. GlobalKey<FormState> memungkinkan akses ke state formulir, sehingga metode validasi() dapat dipanggil dengan menekan tombol Save. Setiap TextFormField memiliki validator yang mengembalikan kesalahan string jika nilai tidak memenuhi aturan. Salah satu contoh nilai yang ditolak adalah string yang hanya berisi spasi pada kolom judul pengalaman (value?.trim().isEmpty). Hal ini disebabkan oleh fakta bahwa spasi sendiri tidak menyediakan informasi yang berguna. Hanya dengan menentukan jenis input (seperti TextInputType.text) atau papan ketik tidak akan cukup untuk memastikan bahwa data yang disimpan di backend adalah valid. Ini karena validasi bisnis harus dilakukan dengan panjang maksimum, format URL, atau urutan tanggal

## Strategi Prompting
Saya kirim pesan error dan pengecekan step yang sudah aku kerjakan dan yang belum aku bertanya ke claude kenapa terjadi eror sesuai dengan kondisi nyata yang terjadi pada laptopku, terus aku coba uji lokal terlebih dahulu setiap step untuk mengurangi eror.

## AI Disclosure
Saya menggunakan Claude sebagai bantuan dalam beberapa bagian tugas ini, dengan rincian sebagai berikut:
1. AI sempat menyarankan penggunaan import 'package:material_ui/material_ui.dart'; berdasarkan catatan Flutter 3.50 pada modul. Namun, setelah saya analisis secara kritis pada environment lokal proyek yang menggunakan Flutter 3.47, paket tersebut belum ada di pubspec.yaml sehingga justru memicu error.
2. Ketika mengintegrasikan form baru ke dalam drawer, AI sempat menghasilkan duplikasi ListTile pada file left_drawer.dart

## Bagian yang saya kerjakan sendiri
1. Melakukan refactoring manual pemindahan file ke screens/ dan widgets/, serta memperbaiki seluruh jalur import yang terputus
2. Menyesuaikan model Experience secara mandiri agar field, pilihan dropdown (EXPERIENCE_CHOICES)dan validasi tanggal selaras persis dengan model Django dari tugas web sebelumnya
3. Mempertahankan impor standar package:flutter/material.dart

## Refleksi Proses
Tugas 8 memberikan pemahaman bagi saya mengenai manajemen routing stack di Flutter (push, pushReplacement, pop) serta pengelolaan form interaktif menggunakan GlobalKey<FormState>