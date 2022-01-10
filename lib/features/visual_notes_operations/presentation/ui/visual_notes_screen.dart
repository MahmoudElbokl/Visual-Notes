import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/response_classify.dart';
import '../../../../injector.dart';
import '../../domain/entities/visual_note_status_enum.dart';
import '../manager/visual_note_controller.dart';
import 'add_visual_note.dart';

class VisualNotesScreen extends StatelessWidget {
  VisualNotesScreen({Key? key}) : super(key: key);
  // inject screen controller
  final VisualNoteController controller =
      Get.put(VisualNoteController(getVisualNoteUseCases: sl(), addVisualNoteUseCase: sl()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VisualNotes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddVisualNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<VisualNoteController>(
          builder: (value) {
            if (value.visualNoteList.status == Status.error) {
              return Center(
                child: Text(value.visualNoteList.error!),
              );
            } else if (value.visualNoteList.status == Status.completed) {
              if (value.visualNoteList.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: value.visualNoteList.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width,
                      height: 100.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 15, offset: Offset(5, 5)),
                          ]),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: SizedBox(
                              height: 50.h,
                              width: Get.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  fadeInDuration: const Duration(milliseconds: 200),
                                  fadeOutDuration: const Duration(milliseconds: 100),
                                  placeholder: const AssetImage("assets/images/placeholder.png"),
                                  image: FileImage(
                                    File(
                                      value.visualNoteList.data![index].picture,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              height: Get.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    value.visualNoteList.data![index].title.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Expanded(
                                    child: Text(
                                      value.visualNoteList.data![index].description.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    value.visualNoteList.data![index].status.toString().split('.').last,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    value.visualNoteList.data![index].date.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.operationOnVisualNote(
                                  visualNote: value.visualNoteList.data![index], operation: Operation.delete);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("There is no any visual notes now."),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
