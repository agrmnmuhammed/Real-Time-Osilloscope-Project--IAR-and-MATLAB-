# 📈 MSP430 + MATLAB Real-Time Oscilloscope  

## 📌 Description / Açıklama  

**English:**  
This project implements a **real-time PC oscilloscope** using the MSP430 microcontroller and MATLAB.  
- An **NE555 timer** generates a square-wave signal.  
- The signal is sampled by the **MSP430 ADC10**.  
- Data is transmitted via a **TimerA-based software UART (9600 bps)**.  
- On the PC side, **MATLAB** receives the data through the COM port and plots it in real-time.  
- Additionally, the system calculates and displays **amplitude (Vpp)**, **frequency**, and **duty cycle** live.  

**Türkçe:**  
Bu proje, **MSP430 mikrodenetleyici** ve **MATLAB** kullanılarak geliştirilen **gerçek zamanlı bir PC osiloskopudur**.  
- **NE555 zamanlayıcı** kare dalga sinyali üretir.  
- Sinyal **MSP430 ADC10** ile örneklenir.  
- Veriler **TimerA tabanlı yazılımsal UART (9600 bps)** üzerinden PC’ye gönderilir.  
- PC tarafında **MATLAB**, COM portu üzerinden verileri alarak gerçek zamanlı grafik çizer.  
- Ayrıca sistem, **genlik (Vpp)**, **frekans** ve **duty cycle** değerlerini anlık olarak hesaplayıp ekrana yansıtır.  

---

## ⚙️ Features / Özellikler  
- 📡 Software UART communication (TimerA, 9600 bps)  
- ⚡ Real-time ADC sampling and serial transmission  
- 📊 Live plotting in MATLAB  
- 📐 Real-time calculation of Vpp, frequency, and duty cycle  
- 🔧 Adjustable signal source using NE555 (frequency, duty, amplitude)  

---

## 🛠️ Hardware & Software / Donanım & Yazılım  

**Hardware (Donanım):**  
- MSP430 LaunchPad  
- NE555 square wave generator circuit  
- Resistors, capacitors, power supply (3.3V)  
- USB-to-PC serial connection  

**Software (Yazılım):**  
- IAR Embedded Workbench (MSP430 C code)  
- MATLAB (serialport, plotting, signal analysis)  

---

## 📂 Project Structure  

