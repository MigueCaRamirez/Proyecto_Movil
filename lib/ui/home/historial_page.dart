import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  // Función para mostrar el diálogo con detalles
  void _mostrarDetalles(BuildContext context, Map<String, dynamic> analisis) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                analisis['estado'] == 'Normal'
                    ? Icons.check_circle
                    : Icons.warning,
                color: analisis['estado'] == 'Normal'
                    ? Colors.green
                    : Colors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Detalles del Análisis',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetalleRow('ID:', analisis['id']),
                const SizedBox(height: 12),
                _buildDetalleRow('Nombre:', analisis['nombre']),
                const SizedBox(height: 12),
                _buildDetalleRow('Fecha:', analisis['fecha']),
                const SizedBox(height: 12),
                _buildDetalleRow('Estado:', analisis['estado']),
                const SizedBox(height: 12),
                _buildDetalleRow('Porcentaje:', '${analisis['porcentaje']}%'),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Observaciones:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  analisis['observaciones'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Get.snackbar(
                  'Descarga',
                  'Descargando reporte...',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Descargar PDF'),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildDetalleRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Map<String, dynamic>> analisis = [
      {
        'id': 'PROD01',
        'nombre': 'Radiografía de Tórax',
        'fecha': '2024-10-12',
        'estado': 'Normal',
        'porcentaje': '95.8',
        'letra': 'A',
        'observaciones':
            'Campos pulmonares sin alteraciones. Silueta cardíaca dentro de límites normales. No se observan lesiones ni infiltrados.'
      },
      {
        'id': 'PROD02',
        'nombre': 'Tomografía Cerebral',
        'fecha': '2024-10-11',
        'estado': 'Anormal',
        'porcentaje': '78.3',
        'letra': 'B',
        'observaciones':
            'Se detecta área hipodensa en región temporal derecha. Se recomienda seguimiento y evaluación neurológica especializada.'
      },
      {
        'id': 'PROD03',
        'nombre': 'Resonancia de Columna',
        'fecha': '2024-10-10',
        'estado': 'Normal',
        'porcentaje': '92.1',
        'letra': 'C',
        'observaciones':
            'Discos intervertebrales conservados. No se observan hernias ni protrusiones significativas. Médula espinal sin alteraciones.'
      },
      {
        'id': 'PROD04',
        'nombre': 'Mamografía Bilateral',
        'fecha': '2024-10-09',
        'estado': 'Normal',
        'porcentaje': '96.5',
        'letra': 'D',
        'observaciones':
            'Tejido mamario dentro de parámetros normales. No se identifican masas, calcificaciones sospechosas ni distorsiones arquitecturales.'
      },
      {
        'id': 'PROD05',
        'nombre': 'Ecografía Abdominal',
        'fecha': '2024-10-08',
        'estado': 'Anormal',
        'porcentaje': '71.9',
        'letra': 'E',
        'observaciones':
            'Se observa imagen nodular en lóbulo derecho del hígado de 2.3 cm. Se sugiere estudio complementario con TC o RM.'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Historial de Análisis',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtítulo
            const Text(
              'Rastrea y revisa casos anteriores',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Barra de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar por ID',
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Buscar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Título de casos recientes
            const Text(
              'Casos Recientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Lista de análisis
            Expanded(
              child: ListView.builder(
                itemCount: analisis.length,
                itemBuilder: (context, index) {
                  final item = analisis[index];
                  final esNormal = item['estado'] == 'Normal';

                  return GestureDetector(
                    onTap: () => _mostrarDetalles(context, item),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 1,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Letra circular
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  item['letra'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Información del análisis
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ID y Estado
                                  Row(
                                    children: [
                                      Text(
                                        item['id'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: esNormal
                                              ? Colors.green
                                              : Colors.red[400],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item['estado'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),

                                  // Nombre del análisis
                                  Text(
                                    item['nombre'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Porcentaje
                                  Text(
                                    '${item['porcentaje']}% confianza',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Fecha
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item['fecha'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}