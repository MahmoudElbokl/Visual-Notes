import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/visual_note_status_enum.dart';

class AddVisualNoteController extends GetxController {
  late GlobalKey<FormState> formKey ;
  late TextEditingController titleEditingController ;
  late TextEditingController descEditingController ;
  late TextEditingController dateEditingController ;
  late TextEditingController statusEditingController ;
  String? imagePath; 
  VisualNoteStatus? visualNoteStatus;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    titleEditingController = TextEditingController();statusEditingController = TextEditingController();
    super.onInit();descEditingController = TextEditingController(); dateEditingController = TextEditingController();
  }

  saveImagePath(newPath){
    imagePath = newPath;
    update();
  }

  @override
  void onClose() {
    titleEditingController.dispose();
    descEditingController.dispose();
    dateEditingController.dispose();
    statusEditingController.dispose();
    super.onClose();
  }
}