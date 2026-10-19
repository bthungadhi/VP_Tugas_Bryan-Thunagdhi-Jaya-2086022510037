import 'package:flutter/material.dart';
import '../models/photocard.dart';
import 'photocard_detail_modal.dart';
import 'photocard_image_stack.dart';

class PhotocardTile extends StatefulWidget {
  final Photocard card;
  final VoidCallback? onTap;
  final VoidCallback? onToggleOwned;

  const PhotocardTile({super.key, required this.card, this.onTap, this.onToggleOwned});

  @override
  State<PhotocardTile> createState() => _PhotocardTileState();
}

class _PhotocardTileState extends State<PhotocardTile> {
  bool _isHovered = false;

  void _onCardTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      PhotocardDetailModal.show(context, widget.card, widget.onToggleOwned);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0, 0.0)..scale(1.02))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? primary.withOpacity(0.3)
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
                    ? primary.withOpacity(0.8)
                    : (_isHovered ? primary.withOpacity(0.4) : (isDark ? const Color(0xFF272732) : const Color(0xFFE4E4E7))),
                width: widget.card.owned ? 1.8 : 1.0,
              ),
            ),
            child: InkWell(
              onTap: _onCardTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PhotocardImageStack(
                      card: widget.card,
                      isDark: isDark,
                      primary: primary,
                      onHeartTap: widget.onToggleOwned ?? _onCardTap,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.card.member,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF18181F)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.album_outlined, size: 11, color: primary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.card.album,
                                style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : const Color(0xFF71717A)),
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
