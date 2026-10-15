import '../models/photocard.dart';

const cardTags = ['Album', 'Lucky Draw', 'Fansign'];

const sampleCards = [
  Photocard(
    id: '1',
    member: 'Jea',
    album: 'Album One',
    tag: 'Album',
    imagePath: 'assets/images/member1.jpg',
  ),
  Photocard(
    id: '2',
    member: 'Chris',
    album: 'Album One',
    tag: 'Lucky Draw',
    imagePath: 'assets/images/Member2.jpeg',
  ),
  Photocard(
    id: '3',
    member: 'Ansir',
    album: 'Album Two',
    tag: 'Fansign',
    imagePath: 'assets/images/member3.jpeg',
    owned: true,
  ),
  Photocard(
    id: '4',
    member: 'Bryan',
    album: 'Album Two',
    tag: 'Album',
    imagePath: 'assets/images/Member4.jpeg',
  ),
  Photocard(
    id: '5',
    member: 'Glenn',
    album: 'Album Three',
    tag: 'Lucky Draw',
    imagePath: 'assets/images/Member5.jpeg',
  ),
  Photocard(
    id: '6',
    member: 'Letrand with extremely long name text test requirement 200 characters lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud',
    album: 'Album Three - Special Collector Edition World Tour 2024 Final Concert Extra Limited Version',
    tag: 'Fansign',
    imagePath: 'assets/images/Member6.jpeg',
  ),
];

/// Helper function to generate 500 items for testing long lists without shrinkWrap: true
List<Photocard> generate500Cards() {
  final baseImages = [
    'assets/images/member1.jpg',
    'assets/images/Member2.jpeg',
    'assets/images/member3.jpeg',
    'assets/images/Member4.jpeg',
    'assets/images/Member5.jpeg',
    'assets/images/Member6.jpeg',
  ];
  final tags = ['Album', 'Lucky Draw', 'Fansign'];
  final names = ['Jea', 'Chris', 'Ansir', 'Bryan', 'Glenn', 'Letrand'];

  return List.generate(500, (index) {
    final name = names[index % names.length];
    final tag = tags[index % tags.length];
    final img = baseImages[index % baseImages.length];
    return Photocard(
      id: 'card_$index',
      member: '$name #$index',
      album: 'Album Volume ${(index ~/ 10) + 1}',
      tag: tag,
      imagePath: img,
      owned: index % 3 == 0,
    );
  });
}
