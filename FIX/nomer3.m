clear; clc; close all;

function [c« tabel« iter] = biseksi¥f« a« b« tol« maksit¤
  tabel = zeros¥maksit« 8¤;
  for iter = 1:maksit
    c     = ¥a + b¤ / 2;
    fa    = f¥a¤;  fb = f¥b¤;  fc = f¥c¤;
    galat = ¥b ¬ a¤ / 2;
    tabel¥iter« :¤ = [iter a b c fa fb fc galat];
    if fc == 0 || galat < tol
      break;
    end
    if fa * fc < 0
      b = c;
    else
      a = c;
    end
  end
  tabel = tabel¥1:iter« :¤;
end

function [c« tabel« iter] = regula_falsi¥f« a« b« tol« maksit¤
  tabel  = zeros¥maksit« 8¤;
  c_lama = NaN;
  for iter = 1:maksit
    fa    = f¥a¤;  fb = f¥b¤;
    c     = ¥a * fb ¬ b * fa¤ / ¥fb ¬ fa¤;
    fc    = f¥c¤;
    galat = abs¥c ¬ c_lama¤;
    tabel¥iter« :¤ = [iter a b c fa fb fc galat];
    if abs¥fc¤ < 1e¬12 || ¥iter > 1 && galat < tol¤
      break;
    end
    if fa * fc < 0
      b = c;
    else
      a = c;
    end
    c_lama = c;
  end
  tabel = tabel¥1:iter« :¤;
end


function cetak_tabel¥tabel« judul_galat¤
  fprintf¥'%¬5s %¬11s %¬11s %¬11s %¬13s %¬13s %¬13s %¬12s\n'« ©©©
          'Iter'« 'a'« 'b'« 'c'« 'f¥a¤'« 'f¥b¤'« 'f¥c¤'« judul_galat¤;
  fprintf¥'%s\n'« repmat¥'¬'« 1« 100¤¤;
  for i = 1:size¥tabel« 1¤
    if isnan¥tabel¥i« 8¤¤
      g = sprintf¥'%¬12s'« '¬'¤;
    else
      g = sprintf¥'%¬12©3e'« tabel¥i« 8¤¤;
    end
    fprintf¥'%¬5d %¬11©6f %¬11©6f %¬11©6f %¬13©6f %¬13©6f %¬13©6f %s\n'« ©©©
            tabel¥i« 1¤« tabel¥i« 2¤« tabel¥i« 3¤« tabel¥i« 4¤« ©©©
            tabel¥i« 5¤« tabel¥i« 6¤« tabel¥i« 7¤« g¤;
  end
  fprintf¥'%s\n'« repmat¥'¬'« 1« 100¤¤;
end


V_bola = 300;
f      = @¥r¤ ¥4/3¤ * pi * r©^3 ¬ V_bola;

garis = repmat¥'='« 1« 100¤;
fprintf¥'%s\nKASUS 3 : PERSAMAAN NONLINEAR ¬ VOLUME TABUNG DI LUAR BOLA\n%s\n'« garis« garis¤;
fprintf¥'\n[1] Perumusan persamaan nonlinear\n'¤;
fprintf¥'    V_bola = ¥4/3¤ pi r^3 «  V_tabung = pi r^2 ¥2r¤ = 2 pi r^3\n'¤;
fprintf¥'    V_bola : V_tabung = 2 : 3  ¬>  V_tabung = 3/2 x %d = %©0f cm^3\n'« V_bola« 1©5 * V_bola¤;
fprintf¥'    V_luar = V_tabung ¬ V_bola = ¥2/3¤ pi r^3 = %©0f cm^3\n'« 1©5 * V_bola ¬ V_bola¤;
fprintf¥'    Persamaan nonlinear : f¥r¤ = ¥4/3¤ pi r^3 ¬ %d = 0\n'« V_bola¤;

r_grafik = linspace¥0« 8« 400¤;

figure¥1¤;
set¥gcf« 'Position'« [100 100 950 560]¤;
plot¥r_grafik« f¥r_grafik¤« 'b¬'« 'LineWidth'« 2©5¤;  hold on;
plot¥[0 8]« [0 0]« 'k¬'« 'LineWidth'« 1¤;
grid on;
xlabel¥'r ¥cm¤'¤;  ylabel¥'f¥r¤'¤;
title¥'Metode Grafik: f¥r¤ = ¥4/3¤\pi r^3 ¬ 300'¤;

a0 = 4;
b0 = 5;
if f¥a0¤ * f¥b0¤ >= 0
  error¥'Selang [%g« %g] tidak mengapit akar©'« a0« b0¤;
end
fprintf¥'\n[2] Nilai awal dari metode grafik\n'¤;
fprintf¥'    Grafik memotong sumbu r antara r = %g dan r = %g\n'« a0« b0¤;
fprintf¥'    f¥%g¤ = %©6f ¥negatif¤   f¥%g¤ = %©6f ¥positif¤  ¬> ada akar di [%g« %g]\n'« ©©©
        a0« f¥a0¤« b0« f¥b0¤« a0« b0¤;

plot¥[a0 a0]« [f¥a0¤ 0]« 'r¬¬'« 'LineWidth'« 1©5¤;
plot¥[b0 b0]« [0 f¥b0¤]« 'r¬¬'« 'LineWidth'« 1©5¤;
plot¥a0« f¥a0¤« 'ro'« 'MarkerFaceColor'« 'r'¤;
plot¥b0« f¥b0¤« 'ro'« 'MarkerFaceColor'« 'r'¤;

tol    = 1e¬6;
maksit = 100;

fprintf¥'\n[3] Metode Biseksi  ¥toleransi ¥b¬a¤/2 < %g¤\n'« tol¤;
[r_bis« tab_bis« it_bis] = biseksi¥f« a0« b0« tol« maksit¤;
cetak_tabel¥tab_bis« '¥b¬a¤/2'¤;
fprintf¥'    Akar biseksi : r = %©8f cm  ¥%d iterasi¤\n'« r_bis« it_bis¤;

fprintf¥'\n[4] Metode Regula Falsi  ¥toleransi |c ¬ c_lama| < %g¤\n'« tol¤;
[r_rf« tab_rf« it_rf] = regula_falsi¥f« a0« b0« tol« maksit¤;
cetak_tabel¥tab_rf« '|c ¬ c_lama|'¤;
fprintf¥'    Akar regula falsi : r = %©8f cm  ¥%d iterasi¤\n'« r_rf« it_rf¤;


r_analitik = ¥3 * V_bola / ¥4 * pi¤¤^¥1/3¤;
r          = r_bis;
t_tabung   = 2 * r;
V_tabung   = pi * r^2 * t_tabung;
V_bola_cek = ¥4/3¤ * pi * r^3;
V_luar     = V_tabung ¬ V_bola_cek;
V_rumus    = ¥2/3¤ * pi * r^3;

fprintf¥'\n[5] Perbandingan akar\n'¤;
fprintf¥'    %¬16s %¬16s %¬16s\n'« 'Metode'« 'r ¥cm¤'« 'Galat relatif ¥%¤'¤;
fprintf¥'    %¬16s %¬16©8f %¬16©3e\n'« 'Biseksi'«       r_bis« abs¥r_bis ¬ r_analitik¤ / r_analitik * 100¤;
fprintf¥'    %¬16s %¬16©8f %¬16©3e\n'« 'Regula falsi'«  r_rf«  abs¥r_rf  ¬ r_analitik¤ / r_analitik * 100¤;
fprintf¥'    %¬16s %¬16©8f %¬16s\n'«   'Analitik'«      r_analitik« '¬'¤;

fprintf¥'\n[6] HASIL AKHIR ¥memakai r dari biseksi¤\n'¤;
fprintf¥'    Jari¬jari bola dan tabung ¥r¤ : %©4f cm\n'« r¤;
fprintf¥'    Tinggi tabung ¥t = 2r¤        : %©4f cm\n'« t_tabung¤;
fprintf¥'    Volume bola ¥cek¤             : %©4f cm^3\n'« V_bola_cek¤;
fprintf¥'    Volume tabung                 : %©4f cm^3\n'« V_tabung¤;
fprintf¥'    Volume tabung di luar bola    : %©4f cm^3\n'« V_luar¤;
fprintf¥'    Cek rumus ¥2/3¤ pi r^3        : %©4f cm^3\n'« V_rumus¤;


figure¥1¤;
plot¥r_bis« 0« 'g*'« 'MarkerSize'« 12« 'LineWidth'« 2¤;
text¥r_bis + 0©15« 40« sprintf¥'akar \\approx %©4f'« r_bis¤¤;
legend¥{'f¥r¤'« 'f¥r¤ = 0'« sprintf¥'batas a = %g'« a0¤« sprintf¥'batas b = %g'« b0¤« ©©©
        'f¥a¤'« 'f¥b¤'« 'akar'}« 'Location'« 'northwest'¤;
hold off;
print¥'¬dpng'« '¬r150'« 'kasus3_grafik©png'¤;
