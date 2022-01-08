import '../../../../core/usecase.dart';
import '../entities/visual_note_entity.dart';
import '../entities/visual_note_status_enum.dart';
import '../repositories/get_visual_notes_repo.dart';

class AddVisualNoteUseCase implements UseCase<Future<int>, Params> {
  final GetVisualNoteRepository repository;

  AddVisualNoteUseCase(this.repository);

  // insert, delete, and update use case of visual note feature
  @override
  Future<int> call(Params params) async {
     switch(params.operation){
      case Operation.add:
        return await repository.addVisualNote(params.visualNote);
      case Operation.delete:
        return await repository.deleteVisualNote(params.visualNote);
      case Operation.update:
        return await repository.editVisualNote(params.visualNote);
    }

  }
}

// parameters of the use case
class Params {
  final VisualNoteEntity visualNote;
  final Operation operation;
  Params({required this.visualNote,required this.operation});
}

