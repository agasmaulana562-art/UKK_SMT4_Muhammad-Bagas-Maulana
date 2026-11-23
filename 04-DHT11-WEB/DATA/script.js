// Ganti alamat ini dengan alamat endpoint data dari ESP32 kamu.
const ESP32_URL = "http://192.168.1.100/data";
const UPDATE_INTERVAL = 2000;

const temperatureEl = document.getElementById("temperature");
const humidityEl = document.getElementById("humidity");
const statusEl = document.getElementById("status");
const lastUpdateEl = document.getElementById("lastUpdate");

const chart = new Chart(document.getElementById("chart"), {
  type: "line",
  data: {
    labels: [],
    datasets: [
      {
        label: "Suhu (°C)",
        data: [],
        borderColor: "#f07835",
        backgroundColor: "rgba(240,120,53,.10)",
        fill: true,
        tension: 0.35,
        pointRadius: 3,
        pointHoverRadius: 5
      },
      {
        label: "Kelembapan (%)",
        data: [],
        borderColor: "#269acb",
        backgroundColor: "rgba(38,154,203,.08)",
        fill: true,
        tension: 0.35,
        pointRadius: 3,
        pointHoverRadius: 5
      }
    ]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    interaction: { mode: "index", intersect: false },
    plugins: {
      legend: { position: "bottom", labels: { usePointStyle: true, boxWidth: 7, padding: 20 } }
    },
    scales: {
      x: { grid: { display: false }, ticks: { color: "#9aa5b5", maxTicksLimit: 6 } },
      y: { beginAtZero: false, grid: { color: "#edf1f6" }, ticks: { color: "#9aa5b5" } }
    }
  }
});

function setConnection(connected) {
  statusEl.className = connected ? "status connected" : "status disconnected";
  statusEl.innerHTML = connected
    ? '<span class="dot"></span> Terhubung'
    : '<span class="dot"></span> Tidak terhubung';
}

function addChartPoint(temp, hum) {
  chart.data.labels.push(new Date().toLocaleTimeString("id-ID"));
  chart.data.datasets[0].data.push(temp);
  chart.data.datasets[1].data.push(hum);

  if (chart.data.labels.length > 20) {
    chart.data.labels.shift();
    chart.data.datasets.forEach(dataset => dataset.data.shift());
  }
  chart.update();
}

async function getSensorData() {
  try {
    const response = await fetch(ESP32_URL, { cache: "no-store" });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);

    const data = await response.json();

    // Sesuaikan nama properti ini dengan JSON yang dikirim ESP32.
    const temp = Number(data.temperature);
    const hum = Number(data.humidity);

    if (!Number.isFinite(temp) || !Number.isFinite(hum)) {
      throw new Error("Format JSON harus memiliki temperature dan humidity berupa angka.");
    }

    temperatureEl.innerHTML = `${temp.toFixed(1)}<small>°C</small>`;
    humidityEl.innerHTML = `${hum.toFixed(1)}<small>%</small>`;
    lastUpdateEl.textContent = new Date().toLocaleTimeString("id-ID");
    setConnection(true);
    addChartPoint(temp, hum);
  } catch (error) {
    setConnection(false);
    console.error("Gagal mengambil data DHT11:", error);
  }
}

getSensorData();
setInterval(getSensorData, UPDATE_INTERVAL);
