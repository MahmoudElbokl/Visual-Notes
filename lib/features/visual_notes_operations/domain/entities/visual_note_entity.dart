import '../../../../core/visual_note_status_enum.dart';

class VisualNoteEntity {
   int? id;
  late String title;
  late String picture;
  late String description;
  late String date;
  late VisualNoteStatus status;

  VisualNoteEntity({
     this.id,
    required this.title,
    required this.picture,
    required this.description,
    required this.date,
    required this.status,
  });

  factory VisualNoteEntity.fromDatabaseJson(Map<String, dynamic> data) => VisualNoteEntity(
        id: data['id'] ?? 0,
        title: data['title'] ,
        description: data['description'] ,
        date: data['date'] ,
        picture: data['picture'] ,
        status: VisualNoteStatus.values.firstWhere((e) => e.toString() == data['status']) ,
      );

  Map<String, dynamic> toDatabaseJson() {
    Map<String,dynamic> map = {
      "title": title,
      "description": description,
      "picture": picture,
      "date": date,
      "status": status.toString(),
    };

    if (map['id'] != null) map['id'] = id!;

    return map;
  }
}
