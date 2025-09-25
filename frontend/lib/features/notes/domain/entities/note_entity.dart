import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String? image;
  final String userId;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, title, content, image, userId];
}
