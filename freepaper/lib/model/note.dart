final String tableNotes = 'favorite';

class NoteFields {
  static final List<String> values = [id, imgPath, time];
  static final String id = '_id';
  static final String imgPath = 'imgPath';
  static final String time = 'time';
}

class Note {
  final int? id;
  final String imgPath;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.imgPath,
    required this.createdTime,
  });

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        imgPath: json[NoteFields.imgPath] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.imgPath: imgPath,
        NoteFields.time: createdTime.toIso8601String(),
      };

  Note copy({
    int? id,
    String? imgPath,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        imgPath: imgPath ?? this.imgPath,
        createdTime: createdTime ?? this.createdTime,
      );
}
