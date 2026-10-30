
clear; clc; close all;

function f = faktor_kg¥satuan¤
  switch lower¥satuan¤
    case 'kg'«  f = 1;
    case 'hg'«  f = 0©1;
    case 'dag'« f = 0©01;
    case 'g'«   f = 0©001;
    otherwise«  error¥'Satuan tidak dikenal: %s'« satuan¤;
  end
end

function ok = dominan_diagonal¥M¤
  d  = abs¥diag¥M¤¤;
  s  = sum¥abs¥M¤« 2¤ ¬ d;
  ok = all¥d > s¤;
end

function r = jari_spektral_gs¥M¤
  L = tril¥M¤;
  U = M ¬ L;
  T = ¬¥L \ U¤;
  r = max¥abs¥eig¥T¤¤¤;
end

function s = rupiah¥x¤
  s = ['Rp ' regexprep¥sprintf¥'%©0f'« round¥x¤¤« '¥\d¤¥?=¥\d{3}¤+$¤'« '$1©'¤ '«00'];
end

nama    = {'Adel'« 'Briza'« 'Caca'« 'Dinda'};
bahan   = {'Beras'« 'Telur'« 'Tepung'« 'Ayam'};

nilai   = [2©5  1500  5     500;
           40   0©75  1000  2;
           2000 15    50    6000;
           1    4250  20    9];
satuan  = {'kg'« 'g'«  'kg'«  'g';
           'hg'« 'kg'« 'g'«   'kg';
           'g'«  'hg'« 'dag'« 'g';
           'kg'« 'g'«  'hg'«  'hg'};
total   = [161000; 149000; 251500; 173000];

garis = repmat¥'='« 1« 78¤;
fprintf¥'%s\nKASUS 2 : SPL ¬ HARGA BAHAN MAKANAN PER KILOGRAM\n%s\n'« garis« garis¤;

A = zeros¥4« 4¤;
for i = 1:4
  for j = 1:4
    A¥i« j¤ = nilai¥i« j¤ * faktor_kg¥satuan{i« j}¤;
  end
end
b = total;

fprintf¥'\n[1] Data belanja setelah dikonversi ke kilogram\n'¤;
fprintf¥'%¬8s %¬9s %¬9s %¬9s %¬9s %¬14s\n'« 'Nama'« 'Beras'« 'Telur'« 'Tepung'« 'Ayam'« 'Total ¥Rp¤'¤;
for i = 1:4
  fprintf¥'%¬8s %¬9©2f %¬9©2f %¬9©2f %¬9©2f %¬14d\n'« nama{i}« A¥i«:¤« b¥i¤¤;
end

fprintf¥'\n[2] Bentuk SPL  ¥x1 = beras« x2 = telur« x3 = tepung« x4 = ayam¤\n'¤;
for i = 1:4
  fprintf¥'    %5©2f x1 + %5©2f x2 + %5©2f x3 + %5©2f x4 = %d      ¥%s¤\n'« A¥i«:¤« b¥i¤« nama{i}¤;
end

fprintf¥'\n    Bentuk matriks  A x = b :\n'¤;
for i = 1:4
  fprintf¥'    [ %5©2f %5©2f %5©2f %5©2f ] [x%d]   [ %7d ]\n'« A¥i«:¤« i« b¥i¤¤;
end

fprintf¥'\n[3] Analisis kelayakan metode Gauss¬Seidel\n'¤;
fprintf¥'    a¤ Urutan persamaan sesuai soal\n'¤;
fprintf¥'       Dominan diagonal ketat : %s\n'« mat2str¥dominan_diagonal¥A¤¤¤;
rho_asli = jari_spektral_gs¥A¤;
if rho_asli < 1
  ket = 'konvergen';
else
  ket = 'tidak konvergen« rho >= 1';
end
fprintf¥'       rho¥T_GS¤              : %©4f  ¥%s¤\n'« rho_asli« ket¤;

P = [];
semua = perms¥1:4¤;
for k = 1:size¥semua« 1¤
  if dominan_diagonal¥A¥semua¥k«:¤« :¤¤
    P = semua¥k« :¤;
    break;
  end
end

if isempty¥P¤
  error¥'Tidak ada urutan baris yang dominan diagonal© Gunakan metode langsung©'¤;
end
Ap = A¥P« :¤;
bp = b¥P¤;

fprintf¥'\n    b¤ Setelah pertukaran baris ¥urutan persamaan: %s¤\n'« mat2str¥P¤¤;
for i = 1:4
  fprintf¥'       %s: |a%d%d| = %©2f  >  jumlah lainnya = %©2f\n'« ©©©
          nama{P¥i¤}« i« i« abs¥Ap¥i«i¤¤« sum¥abs¥Ap¥i«:¤¤¤ ¬ abs¥Ap¥i«i¤¤¤;
end
fprintf¥'       Dominan diagonal ketat : %s\n'« mat2str¥dominan_diagonal¥Ap¤¤¤;
fprintf¥'       rho¥T_GS¤              : %©4f  ¥konvergen« rho < 1¤\n'« jari_spektral_gs¥Ap¤¤;
fprintf¥'\n    KESIMPULAN: masalah DAPAT diselesaikan dengan metode tidak langsung\n'¤;
fprintf¥'    ¥Gauss¬Seidel¤ setelah urutan persamaan ditukar ¥pivoting baris¤©\n'¤;

tol   = 1e¬6;
maksit = 500;
x     = zeros¥4« 1¤;

fprintf¥'\n[4] Iterasi Gauss¬Seidel ¥tebakan awal x = 0« toleransi = %g¤\n'« tol¤;
fprintf¥'%¬6s %¬14s %¬14s %¬14s %¬14s %¬12s\n'« 'Iter'« 'x1'« 'x2'« 'x3'« 'x4'« 'galat'¤;
fprintf¥'%s\n'« repmat¥'¬'« 1« 78¤¤;
fprintf¥'%¬6d %¬14©6f %¬14©6f %¬14©6f %¬14©6f %¬12s\n'« 0« x« '¬'¤;

for k = 1:maksit
  x_lama = x;
  for i = 1:4
    j = [1:i¬1« i+1:4];
    x¥i¤ = ¥bp¥i¤ ¬ Ap¥i« j¤ * x¥j¤¤ / Ap¥i« i¤;
  end
  galat = max¥abs¥x ¬ x_lama¤¤;
  fprintf¥'%¬6d %¬14©6f %¬14©6f %¬14©6f %¬14©6f %¬12©3e\n'« k« x« galat¤;
  if galat < tol
    break;
  end
end
fprintf¥'%s\n'« repmat¥'¬'« 1« 78¤¤;
fprintf¥'Konvergen pada iterasi ke¬%d\n'« k¤;

x_langsung = A \ b;
fprintf¥'\n[5] Verifikasi\n'¤;
fprintf¥'    Selisih terhadap solusi langsung ¥A\\b¤ : %©3e\n'« max¥abs¥x ¬ x_langsung¤¤¤;
fprintf¥'    Norm residu ||A x ¬ b||                : %©3e\n'« norm¥A * x ¬ b¤¤;

fprintf¥'\n[6] HASIL AKHIR ¬ Harga per kilogram\n'¤;
for j = 1:4
  fprintf¥'    %¬8s : %s / kg\n'« bahan{j}« rupiah¥x¥j¤¤¤;
end
