import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../../core/response_classify.dart';
import '../../../../core/usecase.dart';
import '../../domain/entities/visual_note_status_enum.dart';
import '../../domain/entities/visual_note_entity.dart';
import '../../domain/use_cases/add_visual_note_usecase.dart';
import '../../domain/use_cases/get_visual_note_usecase.dart';

class VisualNoteController extends GetxController {
  final GetVisualNoteUseCases getVisualNoteUseCases;
  final AddVisualNoteUseCase addVisualNoteUseCase;

  VisualNoteController({required this.getVisualNoteUseCases, required this.addVisualNoteUseCase});

  ResponseClassify<List<VisualNoteEntity>> _visualNoteList = ResponseClassify.loading();

  ResponseClassify<List<VisualNoteEntity>> get visualNoteList => _visualNoteList;

  @override
  void onInit() {
    getAllVisualNotes();
    super.onInit();
  }

  Future getAllVisualNotes() async {
    try {
      _visualNoteList = ResponseClassify.completed(await getVisualNoteUseCases.call(NoParams()));
    } catch (e) {
      _visualNoteList = ResponseClassify.error(e.toString());
    }
    update();
  }

  void operationOnVisualNote({required VisualNoteEntity visualNote, required Operation operation}) async {
    try {
      await addVisualNoteUseCase.call(Params(visualNote: visualNote, operation: operation));
      BotToast.showText(text: "Visual note ${operation.toString().split('.').last} successfully.");
      await getAllVisualNotes();
      Get.back();
    } catch (e) {
      BotToast.showText(text: "Error in ${operation.toString().split(".").last} visual note.");
    }
  }
}
