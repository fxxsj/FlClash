import 'base_model.dart';

class NoticeModel extends BaseModel {
  final int id;
  final String title;
  final String? content;
  final int show;
  final String? imgUrl;
  final List<String>? tags;
  final int? createdAt;
  final int? updatedAt;

  const NoticeModel({
    required this.id,
    required this.title,
    this.content,
    required this.show,
    this.imgUrl,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      show: json['show'] as int,
      imgUrl: json['img_url'] as String?,
      tags: json['tags'] != null
          ? (json['tags'] as List).map((e) => e.toString()).toList()
          : null,
      createdAt: json['created_at'] as int?,
      updatedAt: json['updated_at'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'show': show,
      'img_url': imgUrl,
      'tags': tags,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  NoticeModel copyWith({
    int? id,
    String? title,
    String? content,
    int? show,
    String? imgUrl,
    List<String>? tags,
    int? createdAt,
    int? updatedAt,
  }) {
    return NoticeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      show: show ?? this.show,
      imgUrl: imgUrl ?? this.imgUrl,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}