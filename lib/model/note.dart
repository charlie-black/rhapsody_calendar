final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, phone, time,status,dateToRedeem
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static final String dateToRedeem = 'date';
  static final String phone = 'phone';
  static final String status = 'status';


}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final String phone;
  final String status;
  final String dateToRedeem;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.phone,
    required this.status,
    required this.description,
    required this.dateToRedeem,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    String? phone,
    String? status,
    String? dateToRedeem,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        status: status ?? this.status,
        dateToRedeem: dateToRedeem ?? this.dateToRedeem,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        phone: json[NoteFields.phone] as String,
        status: json[NoteFields.status] as String,
        dateToRedeem: json[NoteFields.dateToRedeem] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.phone: phone,
        NoteFields.status: status,
        NoteFields.dateToRedeem: dateToRedeem,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
