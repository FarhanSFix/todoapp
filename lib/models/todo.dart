class Todo {
  final int? id;
  final String judul;
  final String deskripsi;
  final bool isDone;

  Todo({
    this.id,
    required this.judul,
    required this.deskripsi,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      judul: json['judul'] as String,
      deskripsi: json['deskripsi'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'isDone': isDone ? 1 : 0,
    };
  }

  String toString() {
    return 'Todo(id : $id, judul: $judul, deskripsi: $deskripsi, isDone: $isDone)';
  }
}
