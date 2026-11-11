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
Tugas 08 membuat saya paham bahwa Flutter menyusun tampilan dari widget yang bersarang, dan bahwa memecahnya menjadi komponen yang bisa dipakai ulang seperti InfoCard dan ItemCard membuat kode lebih rapi. dan beberapa error saat di environment mengajarkan saya bagaimana jika terjadi situasi serupa kedepannya saat terjadi error di laptopku. Tugas 08 progresnya cukup lancar karena ada penjelasan cara bagaimana mengganti warna