import 'package:flutter/material.dart';
import 'package:h1/features/collection/models/photocard.dart';
import 'photocard_tile.dart';

class CollectionGrid extends StatelessWidget {
  final List<Photocard> cards;
  final Function(Photocard)? onToggleOwned;

  const CollectionGrid({
    Key? key,
    required this.cards,
    this.onToggleOwned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220, // Ukuran maksimal tiap kartu
        childAspectRatio: 0.65,  // Rasio tinggi-lebar proporsional photocard
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return PhotocardTile(
          card: card,
          onToggleOwned: () {
            if (onToggleOwned != null) {
              onToggleOwned!(card);
            }
          },
        );
      },
    );
  }
}