import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PerfilController extends GetxController {
  // Datos iniciales del perfil
  var nombre = "Fabio Fortea".obs;
  var especialidad = "Radiología".obs;
  var hospital = "Hospital General".obs;

  // Control del modo edición
  var isEditing = false.obs;

  // Controladores de texto para edición
  late TextEditingController nombreController;
  late TextEditingController especialidadController;
  late TextEditingController hospitalController;

  @override
  void onInit() {
    super.onInit();
    nombreController = TextEditingController(text: nombre.value);
    especialidadController = TextEditingController(text: especialidad.value);
    hospitalController = TextEditingController(text: hospital.value);
  }

  // Activar modo edición
  void toggleEdit() {
    isEditing.value = !isEditing.value;
    if (isEditing.value) {
      nombreController.text = nombre.value;
      especialidadController.text = especialidad.value;
      hospitalController.text = hospital.value;
    }
  }

  // Guardar cambios
  void guardarCambios() {
    if (nombreController.text.trim().isNotEmpty) {
      nombre.value = nombreController.text.trim();
    }
    if (especialidadController.text.trim().isNotEmpty) {
      especialidad.value = especialidadController.text.trim();
    }
    if (hospitalController.text.trim().isNotEmpty) {
      hospital.value = hospitalController.text.trim();
    }

    isEditing.value = false; // salir del modo edición
    Get.snackbar("Éxito", "Perfil actualizado correctamente",
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
