DHT11 MONITORING - HTML, CSS, JAVASCRIPT

CARA PAKAI:
1. Ekstrak folder ini.
2. Buka script.js.
3. Ganti ESP32_URL dengan URL endpoint data ESP32 kamu.
4. Pastikan endpoint mengembalikan JSON seperti:
   {"temperature": 28.5, "humidity": 65}
5. Buka index.html melalui browser atau Live Server.

CATATAN:
- Grafik menggunakan Chart.js dari CDN, jadi perlu koneksi internet.
- Jika website dan ESP32 beda origin, ESP32 perlu mengizinkan CORS.
- Sesuaikan nama properti JSON di script.js jika berbeda dari contoh.
