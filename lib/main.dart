import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MinecraftUpdateChecker(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFFF3E0), // latar coklat muda
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBCAAA4), // coklat hangat
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}

class MinecraftUpdateChecker extends StatefulWidget {
  @override
  _MinecraftUpdateCheckerState createState() => _MinecraftUpdateCheckerState();
}

class _MinecraftUpdateCheckerState extends State<MinecraftUpdateChecker> {
  String? latestRelease;
  String? latestSnapshot;
  List<Map<String, String>> allVersions = [];

  @override
  void initState() {
    super.initState();
    fetchMinecraftVersions();
  }

  Future<void> fetchMinecraftVersions() async {
    final url = Uri.parse('https://launchermeta.mojang.com/mc/game/version_manifest.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final latest = data['latest'];
      final versions = data['versions'];

      setState(() {
        latestRelease = latest['release'];
        latestSnapshot = latest['snapshot'];

        // simpan id, time, releaseTime
        allVersions = versions.map<Map<String, String>>((v) {
          return {
            "id": v['id'] as String,
            "time": v['time'] as String,
            "releaseTime": v['releaseTime'] as String,
          };
        }).toList();
      });
    } else {
      throw Exception('Gagal mengambil data dari Mojang');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBCAAA4),
        title: const Text(
          "Minecraft Version Checker",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: latestRelease == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildVersionCard("🌟 Versi Terbaru", latestRelease!, const Color(0xFFD7CCC8)),
                  _buildVersionCard("🧪 Snapshot Terbaru", latestSnapshot!, const Color(0xFFEDE7F6)),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("📜 Semua Versi:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      color: const Color(0xFFFFFBFA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: allVersions.length,
                        itemBuilder: (context, index) {
                          final version = allVersions[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: index % 2 == 0 ? const Color(0xFFFFF8E1) : const Color(0xFFFFF3E0),
                            child: ListTile(
                              title: Text(
                                version['id'] ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF5D4037),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Release Time: ${version['releaseTime']}"),
                                  Text("Last Update: ${version['time']}"),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildVersionCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.black54),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
