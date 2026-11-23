/**
 * =========================================================================
 * PROYEK 4: DHT11 ASYNC WEB DASHBOARD DENGAN LITTLEFS & REST API
 * File: config.h
 * =========================================================================
 */

#ifndef CONFIG_H
#define CONFIG_H

#include <Arduino.h>

// ------------------------- KREDENSIAL WI-FI -------------------------
#define WIFI_SSID     "NAMA_WIFI_ANDA"  // Ganti dengan SSID Anda
#define WIFI_PASS     "PASSWORD_WIFI_ANDA"  // Ganti dengan Password Anda

// ------------------------- PINOUT SENSOR DHT11 -------------------------
#define DHT_PIN       4
#define DHT_TYPE      DHT11

// ------------------------- PINOUT LAYAR OLED I2C -------------------------
#define OLED_SDA      21
#define OLED_SCL      22
#define OLED_I2C_ADDR 0x3C
#define SCREEN_WIDTH  128
#define SCREEN_HEIGHT 64
#define OLED_RESET    -1

// ------------------------- KONFIGURASI SISTEM -------------------------
#define SERIAL_BAUD         115200
#define SENSOR_READ_INTERVAL 2000 // Baca sensor setiap 2 detik

#endif // CONFIG_H
