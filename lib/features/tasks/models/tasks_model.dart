// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TasksModel {
  int? id;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  TasksModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  TasksModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return TasksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TasksModel(id: $id, title: $title, description: $description, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TasksModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
