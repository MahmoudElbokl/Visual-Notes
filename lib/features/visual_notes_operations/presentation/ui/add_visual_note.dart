import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/visual_note_status_enum.dart';
import '../../domain/entities/visual_note_entity.dart';
import '../../domain/entities/visual_note_status_enum.dart';
import '../manager/visual_note_controller.dart';
import '../manager/add_visual_note_controller.dart';

class AddVisualNoteScreen extends StatelessWidget {
  AddVisualNoteScreen({Key? key}) : super(key: key);
  // inject screen controller
  final AddVisualNoteController controller = Get.put(AddVisualNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Visual Note'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width:Get.width,
          height: Get.height,
          child: GetBuilder<AddVisualNoteController>(
            builder: (context) {
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: "Title"),
                        controller: controller.titleEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 6,
                        decoration: const InputDecoration(labelText: "Description"),
                        controller: controller.descEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      DateTimeField(
                        controller: controller.dateEditingController,
                        format: DateFormat('yyyy-MM-dd HH:mm a'),
                        decoration: const InputDecoration(labelText: "Date"),
                        validator: (value) {
                          if (value == null) {
                            return 'Date cannot be empty';
                          }
                          return null;
                        },
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      DropdownButtonFormField<VisualNoteStatus>(
                        value: controller.visualNoteStatus,
                        items: const [
                          DropdownMenuItem(
                            child: Text("open"),
                            value: VisualNoteStatus.open,
                          ),
                          DropdownMenuItem(
                            child: Text("closed"),
                            value: VisualNoteStatus.closed,
                          )
                        ],
                        onChanged: (value) {
                          controller.visualNoteStatus = value;
                        },
                        hint: const Text("Select note status"),
                        validator: (value) {
                          if (value == null) {
                            return 'note status cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      InkWell(
                        onTap: () async {
                          final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera);
                          if (photo != null) {
                            controller.saveImagePath(photo.path);
                            // controller.imagePath = photo.path;
                          } else {
                            BotToast.showText(text: 'No image selected');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            controller.imagePath != null ? Icons.bookmark_added : Icons.camera_alt,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        width: Get.width,
                        child: ElevatedButton(
                          child: const Text(
                            'Save Note',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.imagePath != null) {
                                VisualNoteEntity note = VisualNoteEntity(
                                  title: controller.titleEditingController.text,
                                  description: controller.descEditingController.text,
                                  date: controller.dateEditingController.text,
                                  picture: controller.imagePath!,
                                  status: controller.visualNoteStatus!,
                                );
                                Get.find<VisualNoteController>().operationOnVisualNote(
                                  operation: Operation.add,
                                  visualNote: note,
                                );
                              } else {
                                BotToast.showText(text: 'Please upload note image');
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
