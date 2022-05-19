# Check In Apps

## Ide Project
Sebuah perusahan yang mengalami kesulitan mengelola absesnsi kehadiran karyawannya ditengah pandemi covid yang berlangsung. Aplikasi ini memungkinkan karyawan untuk melakukan proses check-in, check-out, dan izin secara digital. Sehingga karyawan dapat mengakses dimana saja tanpa harus menggunakan mesin finger-print yang biasa digunakan di kantor.

## Minimum Viable Product
- MultiUser, mendukung multi user yakni dapat digunakan secara bersama-sama lebih dari satu perangkat dan lebih dari satu user.
- Record Data, dapat merekam data absen yang terdiri data tanggal, jam masuk, jam keluar, dan status apakah masuk atau izin
- Filtering Data by Month, mendukung laporan absensi untuk riwayat daya absen pegawai dapat dilakukan filtering berdasarkan bulan.
- Export PDF, data riwayat absen dapat di-export ke dalam bentuk PDF dengan tujuan jika data absen tersebut diperlukan untuk kebutuhan administrasi.

## Penerapan MVVM
![MVVM](/assets/overview/mvvm.png "MVVM")

## Latar Belakang
- Pandemi Covid yang mengakibatkan seluruh masyarakat harus meminimalisir kegiatan diluar rumah. 
- Pembatasan Social Berskala Besar (PSBB) yang mengharuskan masyarakat melakukan work from home dan social distancing.
- Kegiatan operasional sederhana seperti proses absensi juga menjadi salah satu jenis kegiatan yang tak bisa lagi dilakukan seperti sedia kala.

## Tools
- VS Code, sebagai text editor dalam pembuatan project menggunakan framework flutter.
- Firebase, sebagai database yang menampung data berupa data text/json dan file yang dihubungkan ke aplikasi melalui REST API.
- Flutter Package, 
    - flutter_svg
    - dio
    - intl
    - provider
    - flutter_form_builder
    - loader_overlay
    - shared_preference
    - firebase_storage
    - cloud_firestore
    - file_picker
    - pdf
    - path_provider
    - open_file
    - url_launcher

Berikut tampilan aplikasi "Check In" :

1. Welcome Screen
![Welcome Screen](/assets/overview/welcome.png "Welcome Screen")

2. Signup Screen
![Signup Screen](/assets/overview/signup.png "Signup Screen")

3. Login Screen
![Login Screen](/assets/overview/login.png "Login Screen")

4. Beranda Screen
![Beranda Screen](/assets/overview/beranda.png "Beranda Screen")

5. Riwayat Screen
![Riwayat Screen](/assets/overview/riwayat.png "Riwayat Screen")

6. Profil Screen
![Profil Screen](/assets/overview/profil.png "Profil Screen")

