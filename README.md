# MSP430 + MATLAB Real-Time Oscilloscope  
# MSP430 + MATLAB Gerçek Zamanlı Osiloskop  

## Project Description / Proje Açıklaması  

**English:**  
In this project, I use an NE555 timer to generate a square wave signal. The signal is sampled by the MSP430 ADC module and sent to the PC through a TimerA-based software UART running at 9600 bps. On the PC side, MATLAB receives the data via the COM port and plots the waveform in real-time.  

Besides visualizing the waveform, the system also calculates amplitude (Vpp), frequency, and duty cycle in real-time. When I change the settings on the NE555 circuit, the updates are instantly reflected on the MATLAB graph.  

**Türkçe:**  
Bu projede NE555 ile üretilen kare dalga sinyalini MSP430’un ADC modülü ile örnekliyorum. Elde edilen verileri TimerA tabanlı yazılımsal UART üzerinden 9600 bps hızında PC’ye gönderiyorum. MATLAB tarafında seri port üzerinden gelen verileri alarak gerçek zamanlı olarak grafikte gösteriyorum.  

Grafikte sinyalin dalga formunu görebildiğim gibi aynı zamanda genlik (Vpp), frekans ve duty cycle değerlerini de anlık olarak hesaplayıp izleyebiliyorum. NE555 devresinde yaptığım değişiklikler MATLAB ekranına doğrudan yansıyor.  

## Hardware / Donanım  

- MSP430 LaunchPad  
- NE555 square wave generator / NE555 kare dalga üreteci  
- Resistors, capacitors, 3.3 V supply  
- USB connection to PC  

## Software / Yazılım  

- IAR Embedded Workbench (MSP430 C code)  
- MATLAB (serialport, real-time plotting, signal analysis)  

## Project Structure / Proje Yapısı  

