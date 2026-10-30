clear; clc; close all;
function y = cos_maclaurin¥z« n¤
  y    = zeros¥size¥z¤¤;
  suku = ones¥size¥z¤¤;
  for k = 0:n¬1
    y    = y + suku;
    suku = ¬suku ©* z©^2 ©/ ¥¥2*k+1¤ * ¥2*k+2¤¤;
  end
end

function y = exp_maclaurin¥z« n¤
  y    = 0;
  suku = 1;
  for k = 0:n¬1
    y    = y + suku;
    suku = suku * z / ¥k+1¤;
  end
end
lambda    = 12;
v         = 36;
x         = 10;
h0        = 5;
N         = [23 24 25];
toleransi = 1;
t = linspace¥0« 5« 501¤;
z = t * v / lambda;

h_eksak = h0 * ¥cos¥z¤ + exp¥x¤¤;

jml = numel¥N¤;
h_pend        = zeros¥jml« numel¥t¤¤;
galat_mutlak  = zeros¥jml« numel¥t¤¤;
galat_relatif = zeros¥jml« numel¥t¤¤;
nilai_e       = zeros¥1« jml¤;          %

for i = 1:jml
  nilai_e¥i¤        = exp_maclaurin¥x« N¥i¤¤;
  h_pend¥i« :¤      = h0 * ¥cos_maclaurin¥z« N¥i¤¤ + nilai_e¥i¤¤;
  galat_mutlak¥i«:¤ = abs¥h_eksak ¬ h_pend¥i« :¤¤;
  galat_relatif¥i«:¤ = galat_mutlak¥i« :¤ ©/ abs¥h_eksak¤ * 100;
end

rerata_mutlak   = mean¥galat_mutlak«  2¤';
rerata_relatif  = mean¥galat_relatif« 2¤';
maks_relatif    = max¥galat_relatif« []« 2¤';
garis = repmat¥'='« 1« 92¤;
fprintf¥'%s\n'« garis¤;
fprintf¥'KASUS 1 : GALAT PEMOTONGAN ¬ GELOMBANG AIR LAUT\n'¤;
fprintf¥'%s\n'« garis¤;
fprintf¥'Parameter : lambda = %d« v = %d« x = %d« h0 = %d« 0 <= t <= 5 ¥%d titik¤\n'« ©©©
        lambda« v« x« h0« numel¥t¤¤;
fprintf¥'Nilai eksak e^x = %©6f\n\n'« exp¥x¤¤;

fprintf¥'%¬6s %¬16s %¬14s %¬18s %¬18s %¬8s\n'« ©©©
        'n'« 'e^x pendekatan'« 'galat e^x'« 'rerata galat mutlak'« 'rerata galat rel©¥%¤'« 'status'¤;
fprintf¥'%s\n'« repmat¥'¬'« 1« 92¤¤;
for i = 1:jml
  if rerata_relatif¥i¤ <= toleransi
    status = 'LAYAK';
  else
    status = 'TIDAK';
  end
  fprintf¥'%¬6d %¬16©6f %¬14©6f %¬18©6f %¬18©6f %¬8s\n'« N¥i¤« nilai_e¥i¤« ©©©
          abs¥exp¥x¤ ¬ nilai_e¥i¤¤« rerata_mutlak¥i¤« rerata_relatif¥i¤« status¤;
end
fprintf¥'%s\n\n'« repmat¥'¬'« 1« 92¤¤;

fprintf¥'Galat relatif maksimum pada rentang t :\n'¤;
for i = 1:jml
  fprintf¥'  n = %d  ¬>  %©6f %%\n'« N¥i¤« maks_relatif¥i¤¤;
end

fprintf¥'\nKESIMPULAN\n'¤;
[~« terbaik] = min¥rerata_mutlak¤;
fprintf¥'1© Rerata galat mutlak: '¤;
for i = 1:jml
  fprintf¥'n=%d ¥%©4f¤'« N¥i¤« rerata_mutlak¥i¤¤;
  if i < jml« fprintf¥'« '¤; end
end
fprintf¥'©\n'¤;
fprintf¥'   Pendekatan paling akurat adalah n = %d© Galat mengecil seiring bertambahnya n©\n'« N¥terbaik¤¤;
fprintf¥'2© Galat didominasi pemotongan deret e^x ¥x = %d cukup besar¤« sedangkan\n'« x¤;
fprintf¥'   deret cos sudah sangat konvergen pada n >= %d sehingga galatnya dapat diabaikan©\n'« N¥1¤¤;
if all¥rerata_relatif <= toleransi¤
  fprintf¥'3© Semua rerata galat relatif ¥maks© %©4f%%¤ <= toleransi %d%%©\n'« max¥rerata_relatif¤« toleransi¤;
  fprintf¥'   Metode pendekatan yang disarankan matematikawan LAYAK digunakan©\n'¤;
else
  fprintf¥'3© Ada pendekatan dengan rerata galat relatif > toleransi %d%%©\n'« toleransi¤;
  fprintf¥'   Metode pendekatan tersebut TIDAK LAYAK digunakan©\n'¤;
end

figure¥1¤;
set¥gcf« 'Position'« [100 100 950 560]¤;
plot¥t« h_eksak«      'k¬'«  'LineWidth'« 3¤;   hold on;
plot¥t« h_pend¥1«:¤«  'r¬¬'« 'LineWidth'« 2¤;
plot¥t« h_pend¥2«:¤«  'g¬©'« 'LineWidth'« 2¤;
plot¥t« h_pend¥3«:¤«  'b:'«  'LineWidth'« 2©5¤;
hold off; grid on;
xlabel¥'t'¤;  ylabel¥'h¥t¤'¤;
title¥'Perbandingan h¥t¤ Eksak dan Pendekatan Deret Maclaurin'¤;
legend¥{'f_{eksak}'« sprintf¥'f_{n=%d}'« N¥1¤¤« sprintf¥'f_{n=%d}'« N¥2¤¤« ©©©
        sprintf¥'f_{n=%d}'« N¥3¤¤}« 'Location'« 'northeast'¤;
print¥'¬dpng'« '¬r150'« 'kasus1_grafik_perbandingan©png'¤;

figure¥2¤;
set¥gcf« 'Position'« [150 150 950 560]¤;
plot¥t« galat_mutlak¥1«:¤« 'r¬¬'« 'LineWidth'« 2¤;  hold on;
plot¥t« galat_mutlak¥2«:¤« 'g¬©'« 'LineWidth'« 2¤;
plot¥t« galat_mutlak¥3«:¤« 'b:'«  'LineWidth'« 2©5¤;
hold off; grid on;
xlabel¥'t'¤;  ylabel¥'|h_{eksak} ¬ h_{pendekatan}|'¤;
title¥'Galat Mutlak Pendekatan terhadap Hasil Eksak'¤;
legend¥{sprintf¥'n = %d'« N¥1¤¤« sprintf¥'n = %d'« N¥2¤¤« sprintf¥'n = %d'« N¥3¤¤}« ©©©
       'Location'« 'east'¤;
print¥'¬dpng'« '¬r150'« 'kasus1_grafik_galat©png'¤;
