import 'package:flutter/material.dart';
import '../models/photocard.dart';

class PhotocardTile extends StatefulWidget {
  final Photocard card;
  final VoidCallback? onTap;
  final VoidCallback? onToggleOwned;

  const PhotocardTile({
    super.key,
    required this.card,
    this.onTap,
    this.onToggleOwned,
  });

  @override
  State<PhotocardTile> createState() => _PhotocardTileState();
}

class _PhotocardTileState extends State<PhotocardTile> {
  bool _isHovered = false;

  void _showCardDetail(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF18181F) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 110,
                      child: Image.asset(
                        widget.card.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: isDark ? const Color(0xFF272732) : Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.card.tag,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          widget.card.member,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          'Album: ${widget.card.album}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              widget.card.owned ? Icons.check_circle : Icons.bookmark_border,
                              size: 16,
                              color: widget.card.owned ? theme.colorScheme.primary : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.card.owned ? 'Collected in Vault' : 'In Wishlist',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.card.owned ? theme.colorScheme.primary : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.onToggleOwned != null) {
                      widget.onToggleOwned!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.card.owned
                        ? Colors.redAccent.withOpacity(0.15)
                        : theme.colorScheme.primary,
                    foregroundColor: widget.card.owned
                        ? Colors.redAccent
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(
                    widget.card.owned ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(
                    widget.card.owned ? 'Remove from Vault' : 'Mark as Owned',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0, 0.0)..scale(1.02))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? primaryColor.withOpacity(0.3)
                  : Colors.black.withOpacity(isDark ? 0.4 : 0.08),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF18181F) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.card.owned
                    ? primaryColor.withOpacity(0.8)
                    : (_isHovered
                        ? primaryColor.withOpacity(0.4)
                        : (isDark ? const Color(0xFF272732) : const Color(0xFFE4E4E7))),
                width: widget.card.owned ? 1.8 : 1.0,
              ),
            ),
            child: InkWell(
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                } else {
                  _showCardDetail(context);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Area
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            widget.card.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDark
                                    ? const Color(0xFF23232A)
                                    : Colors.grey[200],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_not_supported,
                                        color: primaryColor.withOpacity(0.7),
                                        size: 32,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Photocard',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isDark ? Colors.white54 : Colors.black45,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Gradient Overlay on bottom of image for legibility
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.65),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.55, 1.0],
                              ),
                            ),
                          ),
                        ),

                        // Tag Badge (Top-Left)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: primaryColor.withOpacity(0.5),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              widget.card.tag,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),

                        // Heart Owned Toggle (Top-Right)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                              padding: EdgeInsets.zero,
                              icon: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.55),
                                  border: Border.all(
                                    color: widget.card.owned
                                        ? Colors.redAccent.withOpacity(0.8)
                                        : Colors.white30,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  widget.card.owned
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.card.owned
                                      ? Colors.redAccent
                                      : Colors.white,
                                  size: 16,
                                ),
                              ),
                              onPressed: widget.onToggleOwned ?? () => _showCardDetail(context),
                            ),
                          ),
                        ),

                        // Status Badge (Bottom-Left on image)
                        Positioned(
                          bottom: 6,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: widget.card.owned
                                  ? primaryColor.withOpacity(0.9)
                                  : Colors.black54,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  widget.card.owned
                                      ? Icons.check_circle_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  widget.card.owned ? 'In Vault' : 'Wishlist',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Text Info Section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.card.member,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF18181F),
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.album_outlined,
                              size: 11,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.card.album,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white60
                                      : const Color(0xFF71717A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
