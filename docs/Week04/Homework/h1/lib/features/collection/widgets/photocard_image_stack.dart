import 'package:flutter/material.dart';
import '../models/photocard.dart';

class PhotocardImageStack extends StatelessWidget {
  final Photocard card;
  final bool isDark;
  final Color primary;
  final VoidCallback onHeartTap;

  const PhotocardImageStack({
    super.key,
    required this.card,
    required this.isDark,
    required this.primary,
    required this.onHeartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            card.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: isDark ? const Color(0xFF23232A) : Colors.grey[200],
              child: Icon(Icons.image_not_supported, color: primary, size: 32),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.55, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primary.withOpacity(0.5), width: 0.8),
            ),
            child: Text(
              card.tag,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: IconButton(
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.55),
                border: Border.all(
                  color: card.owned ? Colors.redAccent.withOpacity(0.8) : Colors.white30,
                  width: 1,
                ),
              ),
              child: Icon(
                card.owned ? Icons.favorite : Icons.favorite_border,
                color: card.owned ? Colors.redAccent : Colors.white,
                size: 16,
              ),
            ),
            onPressed: onHeartTap,
          ),
        ),
        Positioned(
          bottom: 6,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: card.owned ? primary.withOpacity(0.9) : Colors.black54,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(card.owned ? Icons.check_circle_rounded : Icons.bookmark_border_rounded, color: Colors.white, size: 10),
                const SizedBox(width: 3),
                Text(
                  card.owned ? 'In Vault' : 'Wishlist',
                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
