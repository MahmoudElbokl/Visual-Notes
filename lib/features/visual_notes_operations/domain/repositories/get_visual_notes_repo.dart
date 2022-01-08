import '../entities/visual_note_entity.dart';

// abstract class that communicate between domain and data layers.
abstract class GetVisualNoteRepository {
  Future<List<VisualNoteEntity>> getAllVisualNotes();

  Future<int> addVisualNote(VisualNoteEntity visualNoteEntity);

  Future<int> deleteVisualNote(VisualNoteEntity visualNoteEntity);

  Future<int> editVisualNote(VisualNoteEntity visualNoteEntity);
}
