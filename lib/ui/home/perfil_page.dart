import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica/ui/home/login_page.dart';
import 'package:practica/controllers/perfil_controller.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PerfilController controller = Get.put(PerfilController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 18,
              child: Text(
                "F",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.nombre.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "Médico General",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                )),
          ],
        ),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  controller.isEditing.value ? Icons.close : Icons.edit,
                  color: Colors.black,
                )),
            onPressed: controller.toggleEdit,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'home') {
                Get.back();
              } else if (value == 'cerrar_sesion') {
                Get.to(LoginPage());
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'home',
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.black54),
                    SizedBox(width: 12),
                    Text('Inicio'),
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
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mi Perfil",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Gestiona tu información",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Información Personal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Nombre
                      _buildField(
                        "Nombre Completo",
                        controller.nombre.value,
                        controller.isEditing.value,
                        controller.nombreController,
                      ),

                      const SizedBox(height: 20),

                      // Especialidad
                      _buildField(
                        "Especialidad",
                        controller.especialidad.value,
                        controller.isEditing.value,
                        controller.especialidadController,
                      ),

                      const SizedBox(height: 20),

                      // Hospital
                      _buildField(
                        "Hospital/Clínica",
                        controller.hospital.value,
                        controller.isEditing.value,
                        controller.hospitalController,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Botón Guardar (solo visible al editar)
                if (controller.isEditing.value)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: controller.guardarCambios,
                      child: const Text(
                        "Guardar Cambios",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }

  // Widget auxiliar para mostrar campo o texto según modo
  Widget _buildField(String label, String value, bool editable,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 8),
        editable
            ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: value,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ],
    );
  }
}
