import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.skillsUsed,
    required this.projectUrl,
    this.projectImageUrl = '',
    this.id,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id']?.toString(),
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      skillsUsed: (json['skills_used'] ?? '') as String,
      projectUrl: (json['project_url'] ?? '') as String,
      projectImageUrl: (json['project_image_url'] ?? '') as String,
    );
  }

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String skillsUsed;
  final String projectUrl;

  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
