import 'package:h1/features/collection/models/photocard.dart';

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
    member: 'Letrand',
    album: 'Album Three',
    tag: 'Fansign',
    imagePath: 'assets/images/Member6.jpeg',
  ),
];