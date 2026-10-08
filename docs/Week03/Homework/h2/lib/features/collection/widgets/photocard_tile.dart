import 'package:flutter/material.dart';
import 'package:h1/features/collection/models/photocard.dart';

class PhotocardTile extends StatefulWidget {
  final Photocard card;
  final VoidCallback? onTap;
  final VoidCallback? onToggleOwned;

  const PhotocardTile({
    Key? key,
    required this.card,
    this.onTap,
    this.onToggleOwned,
  }) : super(key: key);

  @override
  State<PhotocardTile> createState() => _PhotocardTileState();
}

class _PhotocardTileState extends State<PhotocardTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Card(
          elevation: _isHovered ? 8 : 2,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          widget.card.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.white54,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: Icon(
                            widget.card.owned
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.card.owned ? Colors.red : Colors.white,
                          ),
                          onPressed: widget.onToggleOwned ?? widget.onTap,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.card.member,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: _isHovered
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.card.album,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}