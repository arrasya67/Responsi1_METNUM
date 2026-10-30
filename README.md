

# Responsi 1 Praktikum Metode Numerik

Repositori ini dibuat untuk memenuhi tugas Responsi 1 Praktikum Metode Numerik. Berisi kumpulan *source code* (GNU Octave), *output* grafik, dan laporan praktikum untuk menyelesaikan tiga kasus permasalahan matematika menggunakan pendekatan komputasi numerik.

## 👤 Identitas Mahasiswa
*   **Nama** : Dwi Agus Maulana
*   **NIM** : L0325022
*   **Kelas** : B-PSO1
*   **Mata Kuliah** : Praktikum Metode Numerik

## 📌 Inti Pengerjaan (Ringkasan Kasus)
Praktikum ini berfokus pada implementasi algoritma numerik untuk menyelesaikan tiga masalah utama:

1.  **Kasus 1: Galat Pemotongan Deret Maclaurin**
    *   **Masalah:** Memodelkan tinggi gelombang air laut \(h(t)\) yang melibatkan fungsi transenden (cosinus dan eksponensial).
    *   **Solusi:** Menggunakan pendekatan Deret Maclaurin. Menganalisis seberapa besar pengaruh jumlah suku (\(N=23, 24, 25\)) terhadap penurunan galat (error) hingga mencapai batas toleransi yang layak.
2.  **Kasus 2: Sistem Persamaan Linear (SPL) - Metode Gauss-Seidel**
    *   **Masalah:** Mencari harga per kilogram dari 4 bahan makanan (Beras, Telur, Tepung, Ayam) berdasarkan data total belanjaan dengan satuan berat yang berbeda-beda.
    *   **Solusi:** Menyeragamkan satuan ke Kilogram (kg), lalu menyelesaikannya dengan metode iterasi *Gauss-Seidel*. Pengerjaan ini menekankan pentingnya *Pivoting* (penataan ulang urutan baris) agar matriks memenuhi syarat **dominan diagonal ketat**, sehingga iterasi dijamin konvergen.
3.  **Kasus 3: Persamaan Non-Linear - Metode Biseksi & Regula Falsi**
    *   **Masalah:** Mencari jari-jari (\(r\)) dari sebuah bola di dalam tabung yang memiliki perbandingan volume tertentu.
    *   **Solusi:** Menyelesaikan persamaan \(f(r) = (4/3)\pi r^3 - 300 = 0\) menggunakan dua metode tertutup (Biseksi dan Regula Falsi). Hasil kedua metode dibandingkan untuk melihat efisiensi jumlah iterasi dan tingkat akurasi galat relatifnya.





---
*Repositori ini dibuat untuk keperluan akademik di lingkungan Universitas Sebelas Maret.*
