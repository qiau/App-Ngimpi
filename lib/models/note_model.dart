class NoteModel{
  final int? id;
  final String? title;
  final String? desc;
  final String? date;

  NoteModel({this.id, this.title, this.desc, this.date});

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        desc = res["desc"],
        date = res["date"];
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
    };
  }
}