import 'package:sqflite/sqflite.dart';
import '../../domain/entities/visual_note_entity.dart';

abstract class GetVisualNotesLocalDataSource {
  Future<List<VisualNoteEntity>> getAllVisualNotes();

  Future<int> addVisualNote(VisualNoteEntity visualNoteEntity);

  Future<int> deleteVisualNote(VisualNoteEntity visualNoteEntity);

  Future<int> editVisualNote(VisualNoteEntity visualNoteEntity);
}

// local data source implementation of crud methods
class GetVisualNotesLocalDataSourceImpl implements GetVisualNotesLocalDataSource {
  GetVisualNotesLocalDataSourceImpl({required this.localStorage});

  final Database localStorage;

  @override
  Future<List<VisualNoteEntity>> getAllVisualNotes() async {
    List<Map<String, dynamic>> result;
    result = await localStorage.query('notesTABLE');
    List<VisualNoteEntity> notes =
        result.isNotEmpty ? result.map((item) => VisualNoteEntity.fromDatabaseJson(item)).toList() : [];
    return notes;
  }

  @override
  Future<int> addVisualNote(VisualNoteEntity visualNoteEntity) async {
    var result = await localStorage.insert(
      'notesTABLE',
      visualNoteEntity.toDatabaseJson(),
    );

    return result;
  }

  @override
  Future<int> deleteVisualNote(VisualNoteEntity visualNoteEntity) async {
    var result = await localStorage.delete('notesTABLE', where: "id = ?", whereArgs: [visualNoteEntity.id]);

    return result;
  }

  @override
  Future<int> editVisualNote(VisualNoteEntity visualNoteEntity) async {
    var result = await localStorage
        .update('notesTABLE', visualNoteEntity.toDatabaseJson(), where: "id = ?", whereArgs: [visualNoteEntity.id]);

    return result;
  }
}
