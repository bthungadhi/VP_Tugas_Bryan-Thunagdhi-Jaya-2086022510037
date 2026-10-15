import 'package:flutter/material.dart';
import '../models/photocard.dart';
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
      // IMPORTANT: shrinkWrap: false to allow efficient scrolling for 500+ items without performance/layout degradation
      shrinkWrap: false,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 0.70,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
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
