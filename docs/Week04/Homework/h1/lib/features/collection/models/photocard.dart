class Photocard {
  final String id;
  final String member;
  final String album;
  final String tag;
  final String imagePath;
  final bool owned;

  const Photocard({
    required this.id,
    required this.member,
    required this.album,
    required this.tag,
    required this.imagePath,
    this.owned = false,
  });

  Photocard copyWith({
    String? id,
    String? member,
    String? album,
    String? tag,
    String? imagePath,
    bool? owned,
  }) {
    return Photocard(
      id: id ?? this.id,
      member: member ?? this.member,
      album: album ?? this.album,
      tag: tag ?? this.tag,
      imagePath: imagePath ?? this.imagePath,
      owned: owned ?? this.owned,
    );
  }
}
