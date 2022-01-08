import '../../domain/repositories/get_visual_notes_repo.dart';
import '../../domain/entities/visual_note_entity.dart';
import '../data_source/get_visual_note_local_data_source.dart';


// implementation of domain repository
class GetVisualNoteRepositoryImpl implements GetVisualNoteRepository {
  final GetVisualNotesLocalDataSource getVisualNoteLocalDataSource;

  GetVisualNoteRepositoryImpl(
    this.getVisualNoteLocalDataSource,
  );

  @override
  Future<List<VisualNoteEntity>> getAllVisualNotes() {
    return getVisualNoteLocalDataSource.getAllVisualNotes();
  }

  @override
  Future<int> addVisualNote(VisualNoteEntity visualNoteEntity) async {
    return await getVisualNoteLocalDataSource.addVisualNote(visualNoteEntity);

  }

  @override
  Future<int> deleteVisualNote(VisualNoteEntity visualNoteEntity) async {
    return await getVisualNoteLocalDataSource.deleteVisualNote(visualNoteEntity);

  }

  @override
  Future<int> editVisualNote(VisualNoteEntity visualNoteEntity) async {
    return await getVisualNoteLocalDataSource.editVisualNote(visualNoteEntity);
  }
}
