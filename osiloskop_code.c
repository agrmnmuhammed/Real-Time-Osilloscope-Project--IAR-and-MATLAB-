#include <msp430.h>

#define TXD BIT2
#define TX_PORT P1OUT
#define TX_DIR P1DIR
#define BIT_TIME 104

volatile unsigned char txByte = 0;
volatile unsigned char txBusy = 0;
volatile unsigned char bitCount = 0;
volatile unsigned char txMask = 0;

void TimerA_UART_TX(unsigned char byte) {
    while (txBusy);           // Önceki gönderme islemi bitene kadar bekle
    txByte = byte;
    txMask = 0x01;
    bitCount = 0;
    txBusy = 1;

    TX_PORT &= ~TXD;          // Start bit (LOW)
    TA0CCR0 = TA0R + BIT_TIME;
    TA0CCTL0 = CCIE;          // Timer interrupt aktif
    TA0CTL = TASSEL_2 + MC_2; // SMCLK, sürekli mod
}

void adc_init(void) {
    ADC10CTL1 = INCH_0;  // Kanal 0 (P1.0)
    ADC10CTL0 = SREF_0 + ADC10SHT_3 + ADC10ON + ENC;
}

unsigned int adc_read(void) {
    ADC10CTL0 |= ADC10SC; // Baslat
    while (ADC10CTL1 & ADC10BUSY); // Bitene kadar bekle
    return ADC10MEM;
}

void main(void) {
    WDTCTL = WDTPW | WDTHOLD; // Watchdog Timer kapali

    BCSCTL1 = CALBC1_1MHZ;    // 1 MHz kalibrasyonu
    DCOCTL = CALDCO_1MHZ;

    TX_DIR |= TXD;            // TX pini çikis
    TX_PORT |= TXD;           // TX high (idle)

    adc_init();
    __enable_interrupt();     // Global interrupt

    while (1) {
        unsigned int val = adc_read();
        unsigned char data = val >> 2; // 10-bit'i 8-bit'e indir
        TimerA_UART_TX(data);         // UART ile gönder
        __delay_cycles(1000);         // Biraz bekle
    }
}

// Timer A0 interrupt: Yazilim UART çikisi
#pragma vector = TIMER0_A0_VECTOR
__interrupt void Timer_A(void) {
    TA0CCR0 += BIT_TIME; // Sonraki bit zamani

    if (bitCount < 8) {
        if (txByte & txMask)
            TX_PORT |= TXD;
        else
            TX_PORT &= ~TXD;

        txMask <<= 1;
        bitCount++;
    } else if (bitCount == 8) {
        TX_PORT |= TXD; // Stop bit
        bitCount++;
    } else {
        TA0CCTL0 &= ~CCIE; // Interrupt kapat
        txBusy = 0;        // Gönderim bitti
    }
}
