import 'dart:convert';

class TasksModel {
  int? id;
  String? title;
  String? description;
  String? status;

  TasksModel({this.id, this.title, this.description, this.status});

  TasksModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
  }) {
    return TasksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TasksModel(id: $id, title: $title, description: $description, status: $status)';
  }

  @override
  bool operator ==(covariant TasksModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode;
  }
}
