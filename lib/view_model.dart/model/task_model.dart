class TaskModel {
  final String id;
  final String name;
  final String value;
  final bool? completed;
  final String? createdAt;
  final DateTime updatedAt;
  final String? status;

  TaskModel({
    required this.id,
    required this.name,
    required this.value,
    this.completed,
    this.createdAt,
    DateTime? updatedAt,
    this.status,
  }) : updatedAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      "value": value,
      'completed': completed,
      "created_at": createdAt,
      "status": status,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"]?.toString() ?? '',
      name: json['name'] ?? 'no name',
      value: json["value"] ?? '',
      completed: json['completed'],
      createdAt: json["created_at"],
      status: json["status"],
    );
  }

  TaskModel copyWith({
    String? id,
    String? name,
    String? value,
    bool? completed,
    String? createdAt,
    DateTime? updatedAt,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now(),
      status: status ?? this.status,
    );
  }
}
