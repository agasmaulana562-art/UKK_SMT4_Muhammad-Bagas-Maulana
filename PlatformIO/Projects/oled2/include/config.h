// =====================================
// PROYEK 2: DHT11 DENGAN TAMPILAN OLED I2C (SSD1306)
// FILE: config.h

// SKEMA WIRING HARDWARE LENGKAP KE ESP32
// -------------------------------------------------------
// 1. SENSOR DHT11
//    - VCC  -> 3.3V
//    - GND  -> GND
//    - DATA -> GPIO 4 (D4)
//
// 2. MODUL OLED I2C 0.96 INCI (SSD1306 128X64)
//    - VCC  -> 3.3V ESP32
//    - GND  -> GND
//    - SDA  -> GPIO 21 (PIN default I2C SDA ESP32)
//    - SCL  -> GPIO 22 (PIN default I2C SCL ESP32)
// ==========================================

#ifndef CONFIG_H
#define CONFIG_H

#include <Arduino.h>

// Definisi pin sensor DHT11
#define DHT_PIN         4
#define DHT_TYPE        DHT11

// Definisi komunikasi I2C & Layar OLED SSD1306
#define OLED_SDA        21      // PIN Data I2C
#define OLED_SCL        22      // PIN Clock I2C
#define OLED_I2C_ADDR   0x3C    // Alamat I2C standar (gunakan 0x3D jika layar gelap)
#define SCREEN_WIDTH    128     // Lebar layar OLED dalam piksel
#define SCREEN_HEIGHT   64      // Tinggi layar OLED dalam piksel
#define OLED_RESET      -1      // Reset pin (-1 jika berbagi pin reset ESP32 / tidak dipakai)

// KONFIGURASI SISTEM
#define SERIAL_BAUD         115200
#define SENSOR_READ_INTERVAL 2000 // Baca sensor setiap 2 detik

#endif // CONFIG_H