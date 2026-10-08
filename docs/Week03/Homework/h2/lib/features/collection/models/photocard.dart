class Photocard {
  const Photocard({
    required this.id,
    required this.member,
    required this.album,
    required this.tag,
    required this.imagePath,
    this.owned = false,
  });

  final String imagePath;
  final String id;
  final String member;
  final String album;
  final String tag;
  final bool owned;

  Photocard copyWith({bool? owned}) => Photocard(
        id: id,
        member: member,
        album: album,
        tag: tag,
        imagePath: imagePath,
        owned: owned ?? this.owned,
      );
}