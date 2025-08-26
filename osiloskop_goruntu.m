clc;
clear;
port = "COM8";    
baud = 9600;
s = serialport(port, baud);
flush(s);                %Seri porttaki tüm eski (önceki) verileri temizler.
pause(1);                   % 1 saniye bekler; MSP430’un başlatılması ve seri bağlantının oturması için.
vref = 3.3;                  %ADC’nin referans voltajı (MSP430 devrende 3.3V ise burası 3.3 olmalı).   
buffer_size = 300;           %— Grafik üzerinde kaç örnek gösterileceği (ekranda 300 veri noktası).
data = zeros(1, buffer_size);       %Başlangıçta veri dizisini sıfırlarla dolduruyor (1x300’lük bir dizi).
voltaj = (data / 255) * vref;        %ADC verileri 0–255 arası (8 bit) geliyor. Bu değeri voltaja dönüştürür.
zaman = (0:buffer_size-1) * 0.10;   %Zaman eksenini oluşturur. Her veri noktası arasında 0.10 saniye olduğunu varsayar
figure;                         %yeni bir grafik penceresi açar
h = plot(zaman, voltaj, 'b');        % Zaman eksenini kullan
ylim([0 vref]);                      %Y eksenini 0 ile referans voltajı arasında sınırlar.
xlabel('Zaman (s)'); 
ylabel('Voltaj (V)');
title('MSP430 ADC Voltaj Görselleştirme');

% --- Zaman kontrol ayarları ---
plot_interval = 0.10;   % her 0.10 saniyede bir grafik güncelle
last_plot_time = tic;   %Son güncellemeyi takip eden zamanlayıcı başlatılır.

% --- Örnekleme frekansı (tahmini) ---
fs = 1 / plot_interval;   % 10 Hz gibi

% --- Ana döngü ---
while true
    if s.NumBytesAvailable > 0    %seri portta veri var mı diye kontrol eder .sıfırdan büyükse seri portta veri var demektir
        byte = read(s, 1, "uint8"); % seri porttan 1 adet 8 bitlik veri okur
        data = [data(2:end), byte];
        voltaj = (data / 255) * vref; %Her yeni veriyle voltaj vektörü güncellenir.

        % Zaman eksenini kaydır
        zaman = [zaman(2:end), zaman(end) + plot_interval];  %
        

        if toc(last_plot_time) > plot_interval
            % --- Grafik Güncelle ---
            set(h, 'YData', voltaj, 'XData', zaman);
            drawnow;
            last_plot_time = tic; %zamanlayıcıyı sıfırlar 

            % --- Sinyal Analizi ---
            % Genlik (Vpp)
            vpp = max(voltaj) - min(voltaj);

            % Threshold kullanarak rising edge bul
            threshold = (max(voltaj) + min(voltaj)) / 2;
            transitions = find(diff(voltaj > threshold) == 1);

            % Frekans Hesabı
            if length(transitions) >= 2
                period_samples = mean(diff(transitions));  % ortalama örnek farkı
                frekans = fs / period_samples;
            else
                frekans = 0;
            end

            % Duty Cycle Hesabı
            duty = sum(voltaj > threshold) / length(voltaj) * 100;

            % --- Bilgileri Konsola Yaz ---
            fprintf('Genlik: %.2f V | Frekans: %.2f Hz | Duty: %.1f %%\n', ...
                vpp, frekans, duty);
       end
end
end