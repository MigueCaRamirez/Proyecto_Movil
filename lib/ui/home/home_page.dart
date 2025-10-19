import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica/ui/home/cap_datos.dart';
import 'package:practica/ui/home/historial_page.dart';
import 'package:practica/ui/home/login_page.dart';
import 'package:practica/ui/home/perfil_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF0B3A0D),
              radius: 18,
              child: Text(
                "F",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Fabio Fortea",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Médico General",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'perfil') {
                Get.to(PerfilPage());
              } else if (value == 'cerrar_sesion') {
                Get.offAll(LoginPage());
              } else if (value == 'historial') {
                Get.to(HistorialPage());
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'perfil',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black54),
                    SizedBox(width: 12),
                    Text('Perfil'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'historial',
                child: Row(
                  children: [
                    Icon(Icons.history, color: Colors.black54),
                    SizedBox(width: 12),
                    Text('Historial de Análisis'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'cerrar_sesion',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),

      // Contenido principal
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟩 Barra de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar paciente o análisis...",
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3A0D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  label: const Text("Buscar"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 🟩 Título principal
            const Text(
              "Resumen de análisis",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            // 🟩 Tarjetas resumen
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildDashboardCard(
                  title: "Análisis Hoy",
                  value: "24",
                  subtitle: "+12% desde ayer",
                  icon: Icons.trending_up,
                  iconColor: Colors.green,
                ),
                _buildDashboardCard(
                  title: "Anomalías",
                  value: "7",
                  subtitle: "Requieren revisión",
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.orange,
                ),
                _buildDashboardCard(
                  title: "Pacientes Atendidos",
                  value: "15",
                  subtitle: "Hoy",
                  icon: Icons.group,
                  iconColor: Colors.blue,
                ),
                _buildDashboardCard(
                  title: "Radiografías Analizadas",
                  value: "42",
                  subtitle: "Total este mes",
                  icon: Icons.analytics,
                  iconColor: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🟩 Últimos análisis (ejemplo de lista)
            const Text(
              "Últimos análisis realizados",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildAnalysisItem("Paciente: Juan Pérez", "Normal", Colors.green),
            _buildAnalysisItem("Paciente: Ana Gómez", "Anomalía detectada", Colors.orange),
            _buildAnalysisItem("Paciente: Luis Rojas", "Pendiente", Colors.grey),
          ],
        ),
      ),

      // 🟩 Botón flotante
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(CapDatosPage());
        },
        backgroundColor: const Color(0xFF0B3A0D),
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        label: const Text(""),
      ),
    );
  }

  // 🧩 Widget para las tarjetas del dashboard
  Widget _buildDashboardCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // 🧩 Widget para los últimos análisis
  Widget _buildAnalysisItem(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(
            status,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
