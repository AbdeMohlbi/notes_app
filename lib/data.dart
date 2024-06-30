class Note {
  final int? id;
  final String title;
  final String description;
  final String lastUpadte;
  const Note(
      {required this.title,
      required this.description,
      this.id,
      required this.lastUpadte});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      id: json['ID'],
      title: json['TITLE'],
      description: json['DESCRIPTION'],
      lastUpadte: json['LASTUPDATE']);

  Map<String, dynamic> toJson() => {
        'ID': id,
        'TITLE': title,
        'DESCRIPTION': description,
        'LASTUPDATE': lastUpadte,
      };
}
