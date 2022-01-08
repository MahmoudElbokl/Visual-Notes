import '../../../../core/usecase.dart';
import '../entities/visual_note_entity.dart';
import '../repositories/get_visual_notes_repo.dart';

class GetVisualNoteUseCases extends UseCase<Future<List<VisualNoteEntity>>, NoParams> {
  final GetVisualNoteRepository repository;

  GetVisualNoteUseCases(this.repository);

  // get all visual notes use case of visual note feature
  @override
  Future<List<VisualNoteEntity>> call(NoParams params) async {
    return await repository.getAllVisualNotes();
  }
}