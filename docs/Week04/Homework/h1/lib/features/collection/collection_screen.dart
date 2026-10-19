import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'add_photocard_screen.dart';
import 'data/sample_cards.dart';
import 'models/photocard.dart';
import 'vault_stats_screen.dart';
import 'widgets/collection_grid.dart';
import 'widgets/collection_search_bar.dart';
import 'widgets/empty_state.dart';
import 'widgets/tag_filter_row.dart';
import 'widgets/vault_content_header.dart';
import 'widgets/vault_header.dart';
import 'widgets/vault_sidebar.dart';

enum DatasetType { normal, longList500, empty }

class CollectionScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const CollectionScreen({super.key, this.onToggleTheme, this.isDarkMode = true});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  bool _isLoading = true;
  List<Photocard> _cards = [];
  String _query = '';
  String? _selectedTag;
  DatasetType _datasetType = DatasetType.normal;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDataset(DatasetType.normal);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadDataset(DatasetType type) {
    setState(() {
      _isLoading = true;
      _datasetType = type;
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() {
        switch (type) {
          case DatasetType.normal:
            _cards = List.of(sampleCards);
            break;
          case DatasetType.longList500:
            _cards = generate500Cards();
            break;
          case DatasetType.empty:
            _cards = [];
            break;
        }
        _isLoading = false;
      });
    });
  }

  List<Photocard> get _visible => _cards.where((c) {
        final okTag = _selectedTag == null || c.tag == _selectedTag;
        final okQuery = c.member.toLowerCase().contains(_query.toLowerCase()) ||
            c.album.toLowerCase().contains(_query.toLowerCase());
        return okTag && okQuery;
      }).toList();

  void _toggleOwned(String id) {
    setState(() {
      _cards = [for (final c in _cards) c.id == id ? c.copyWith(owned: !c.owned) : c];
    });
  }

  void _resetSearchAndFilter() {
    setState(() {
      _query = '';
      _selectedTag = null;
      _searchController.clear();
      if (_datasetType == DatasetType.empty) _loadDataset(DatasetType.normal);
    });
  }

  Future<void> _navigateToAddScreen() async {
    final newCard = await Navigator.push<Photocard>(
      context,
      MaterialPageRoute(
        builder: (context) => AddPhotocardScreen(isDarkMode: widget.isDarkMode),
      ),
    );
    if (newCard != null) {
      setState(() {
        _cards.insert(0, newCard);
      });
    }
  }

  void _navigateToStatsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VaultStatsScreen(
          cards: _cards,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: VaultHeader(
        isDarkMode: isDark,
        onToggleTheme: widget.onToggleTheme,
        onOpenStats: _navigateToStatsScreen,
        onSelectDataset: (index) {
          if (index == 0) _loadDataset(DatasetType.normal);
          if (index == 1) _loadDataset(DatasetType.longList500);
          if (index == 2) _loadDataset(DatasetType.empty);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddScreen,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Card', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const RadialGradient(
                  center: Alignment(-0.8, -0.8),
                  radius: 1.5,
                  colors: [Color(0xFF132B1F), Color(0xFF0F0F12)],
                  stops: [0.0, 0.6],
                )
              : null,
          color: isDark ? null : const Color(0xFFF4F5F8),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            if (isTablet) {
              return Row(
                children: [
                  VaultSidebar(
                    isDark: isDark,
                    searchController: _searchController,
                    onSearchChanged: (v) => setState(() => _query = v),
                    selectedTag: _selectedTag,
                    onTagSelected: (t) => setState(() => _selectedTag = t),
                    totalVisible: _visible.length,
                    ownedCount: _visible.where((c) => c.owned).length,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        VaultContentHeader(
                          total: _visible.length,
                          isDark: isDark,
                          hasFilter: _query.isNotEmpty || _selectedTag != null,
                          onResetFilter: _resetSearchAndFilter,
                        ),
                        Expanded(child: _buildGridBody(primaryColor)),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                CollectionSearchBar(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                ),
                TagFilterRow(
                  tags: cardTags,
                  selected: _selectedTag,
                  onSelected: (t) => setState(() => _selectedTag = t),
                ),
                const SizedBox(height: AppSpacing.xs),
                Expanded(child: _buildGridBody(primaryColor)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridBody(Color primaryColor) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }
    final items = _visible;
    if (items.isEmpty) {
      return EmptyState(
        message: _datasetType == DatasetType.empty
            ? 'No photocards currently loaded in this vault.'
            : 'No photocards match your search query or category filter.',
        icon: Icons.search_off_rounded,
        actionLabel: _datasetType == DatasetType.empty ? 'Load Sample Cards' : 'Reset Filters',
        onAction: _resetSearchAndFilter,
      );
    }
    return CollectionGrid(
      cards: items,
      onToggleOwned: (card) => _toggleOwned(card.id),
    );
  }
}
