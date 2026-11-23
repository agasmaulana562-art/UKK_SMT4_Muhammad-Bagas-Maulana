/**
 * =========================================================================
 * PROYEK 4: DHT11 ASYNC WEB DASHBOARD DENGAN LITTLEFS & REST API
 * File: async_server.h
 *
 * DESKRIPSI:
 * Modul Asynchronous Web Server menggunakan ESPAsyncWebServer dan LittleFS.
 * Menangani penyajian file statis HTML/CSS dari flash memory serta endpoint
 * REST API /api/now yang dipolling secara live oleh browser.
 * =========================================================================
 */

#ifndef ASYNC_SERVER_H
#define ASYNC_SERVER_H

#include <LittleFS.h>
#include <ESPAsyncWebServer.h>
#include <ArduinoJson.h>
#include "config.h"

// Objek Server Asinkron pada Port 80
static AsyncWebServer asyncServer(80);

// Referensi Variabel Global
extern float currentTemp;
extern float currentHum;
extern bool wifiConnected;
extern unsigned long bootMillis;

/**
 * Inisialisasi Flash File System LittleFS
 */
inline bool initLittleFS() {
  if (!LittleFS.begin(true)) {
    Serial.println("[LittleFS ERROR] Gagal mount file system flash!");
    return false;
  }
  Serial.println("[LittleFS] File system berhasil dimuat.");
  return true;
}

/**
 * Mendaftarkan rute web dan API asinkron
 */
inline void initAsyncWebServer() {
  // 1. Layani file statis (index.html, style.css) langsung dari LittleFS
  asyncServer.serveStatic("/", LittleFS, "/").setDefaultFile("index.html");

  // 2. Endpoint REST API Realtime: GET /api/now
  asyncServer.on("/api/now", HTTP_GET, [](AsyncWebServerRequest *request) {
    JsonDocument doc;

    if (isnan(currentTemp) || isnan(currentHum)) {
      doc["temp"] = nullptr;
      doc["hum"] = nullptr;
    } else {
      doc["temp"] = round(currentTemp * 10) / 10.0;
      doc["hum"]  = round(currentHum * 10) / 10.0;
    }

    doc["online"]   = wifiConnected;
    doc["rssi"]     = WiFi.RSSI();
    doc["uptime"]   = (millis() - bootMillis) / 1000;
    doc["ip"]       = WiFi.localIP().toString();
    doc["ssid"]     = WiFi.SSID();

    String response;
    serializeJson(doc, response);
    request->send(200, "application/json", response);
  });

  // 3. Fallback jika halaman tidak ditemukan
  asyncServer.onNotFound([](AsyncWebServerRequest *request) {
    request->send(404, "text/plain", "404: Not Found pada ESP32 Async Web Server");
  });

  asyncServer.begin();
  Serial.println("[ASYNC HTTP] Server aktif dan siap melayani request di background.");
}

#endif // ASYNC_SERVER_H