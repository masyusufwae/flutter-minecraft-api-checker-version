# 📦 Minecraft Version Checker

Aplikasi Flutter sederhana untuk mengecek **versi terbaru Minecraft** (release & snapshot) serta menampilkan semua daftar versi yang tersedia. Data diambil langsung dari **API Mojang**.

---

## ✨ Fitur
- 🔎 Menampilkan **versi release terbaru**
- 🧪 Menampilkan **versi snapshot terbaru**
- 📜 Daftar lengkap semua versi Minecraft (`id`, `releaseTime`, `time`)
- 🎨 Tampilan dengan Material 3 + tema warna coklat hangat

---

## 🚀 Preview
- Halaman utama menampilkan versi terbaru dan snapshot.
- Daftar versi ditampilkan dalam **ListView** dengan kartu berwarna selang-seling.

---

## 📂 Struktur Proyek
```

lib/
└── main.dart  # Entry point aplikasi

````

---

## ⚙️ Instalasi & Menjalankan

1. Clone repositori:
   ```bash
   git clone https://github.com/username/minecraft-version-checker.git
   cd minecraft-version-checker

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:

   ```bash
   flutter run
   ```

---

## 📡 Sumber Data

Data diambil dari API resmi Mojang:
👉 [https://launchermeta.mojang.com/mc/game/version\_manifest.json](https://launchermeta.mojang.com/mc/game/version_manifest.json)

Contoh respon:

```json
{
  "latest": {
    "release": "1.21.1",
    "snapshot": "24w33a"
  },
  "versions": [
    {
      "id": "1.21.1",
      "type": "release",
      "releaseTime": "2024-07-04T12:00:00+00:00",
      "time": "2024-07-04T12:05:00+00:00"
    }
  ]
}
```

---

## 📸 Screenshot

![Minecraft Version Checker](https://github.com/user-attachments/assets/8876dc44-bee8-4134-9519-0579fedd7748)

---

## 🛠️ Teknologi

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [http](https://pub.dev/packages/http)

---

## 📜 Lisensi

Proyek ini menggunakan lisensi **Apache License 2.0**.
