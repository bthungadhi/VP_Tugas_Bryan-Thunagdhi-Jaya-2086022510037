import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'data/sample_cards.dart';
import 'models/photocard.dart';
import 'widgets/collection_grid.dart';
import 'widgets/collection_search_bar.dart';
import 'widgets/empty_state.dart';
import 'widgets/tag_filter_row.dart';

enum DatasetType { normal, longList500, empty }

class CollectionScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const CollectionScreen({
    super.key,
    this.onToggleTheme,
    this.isDarkMode = true,
  });

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
      _cards = [
        for (final c in _cards) c.id == id ? c.copyWith(owned: !c.owned) : c,
      ];
    });
  }

  void _resetSearchAndFilter() {
    setState(() {
      _query = '';
      _selectedTag = null;
      _searchController.clear();
      if (_datasetType == DatasetType.empty) {
        _loadDataset(DatasetType.normal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF16161D) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? const Color(0xFF272732) : const Color(0xFFE4E4E7),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          primaryColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.style_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PHOTOCARD VAULT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: isDark ? Colors.white : const Color(0xFF18181F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Digital K-Pop Collectibles Gallery',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? const Color(0xFF71717A) : const Color(0xFFA1A1AA),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                      color: primaryColor,
                      size: 20,
                    ),
                    tooltip: 'Toggle Theme Mode',
                    onPressed: widget.onToggleTheme,
                  ),
                  PopupMenuButton<DatasetType>(
                    icon: Icon(Icons.tune_rounded, color: primaryColor, size: 20),
                    tooltip: 'Select Test Dataset',
                    onSelected: _loadDataset,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: isDark ? const Color(0xFF18181F) : Colors.white,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: DatasetType.normal,
                        child: Row(
                          children: [
                            Icon(Icons.collections_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('Normal List (6 Cards)'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: DatasetType.longList500,
                        child: Row(
                          children: [
                            Icon(Icons.format_list_bulleted_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('Long List (500 Cards)'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: DatasetType.empty,
                        child: Row(
                          children: [
                            Icon(Icons.inbox_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('Empty State (0 Cards)'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const RadialGradient(
                  center: Alignment(-0.8, -0.8),
                  radius: 1.5,
                  colors: [
                    Color(0xFF132B1F), // Ambient Green Glow
                    Color(0xFF0F0F12), // Deep Charcoal
                  ],
                  stops: [0.0, 0.6],
                )
              : null,
          color: isDark ? null : const Color(0xFFF4F5F8),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            if (isTablet) {
              // Wide Screen / Tablet Dashboard Layout
              return Row(
                children: [
                  SizedBox(
                    width: 310,
                    child: Container(
                      margin: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF18181F) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? const Color(0xFF272732) : const Color(0xFFE4E4E7),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.3 : 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.tune, color: primaryColor, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'VAULT CONTROLS',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      color: isDark ? Colors.white : const Color(0xFF18181F),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              CollectionSearchBar(
                                controller: _searchController,
                                onChanged: (v) => setState(() => _query = v),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              TagFilterRow(
                                tags: cardTags,
                                selected: _selectedTag,
                                onSelected: (t) => setState(() => _selectedTag = t),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                                child: Divider(height: 1),
                              ),
                              _buildProgressCard(primaryColor, isDark),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _buildContentHeader(primaryColor, isDark),
                        Expanded(child: _buildGridBody()),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Mobile Layout
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
                  Expanded(child: _buildGridBody()),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContentHeader(Color primaryColor, bool isDark) {
    final total = _visible.length;
    final activeFilters = <String>[];
    if (_query.isNotEmpty) activeFilters.add('Search: "$_query"');
    if (_selectedTag != null) activeFilters.add('Tag: $_selectedTag');

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Collection Vault',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: isDark ? Colors.white : const Color(0xFF18181F),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Showing $total photocards in gallery',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? const Color(0xFFA1A1AA) : const Color(0xFF71717A),
                ),
              ),
            ],
          ),
          if (activeFilters.isNotEmpty)
            ActionChip(
              avatar: const Icon(Icons.clear_rounded, size: 14),
              label: Text(
                'Clear (${activeFilters.length})',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              onPressed: _resetSearchAndFilter,
            ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(Color primaryColor, bool isDark) {
    final total = _visible.length;
    final ownedCount = _visible.where((c) => c.owned).length;
    final progress = total > 0 ? (ownedCount / total) : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.pie_chart_rounded, size: 16, color: primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    'Vault Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF18181F),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: primaryColor.withOpacity(0.18),
              color: primaryColor,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Visible Cards: $total',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? const Color(0xFFA1A1AA) : const Color(0xFF71717A),
                ),
              ),
              Text(
                'Owned: $ownedCount',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridBody() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            const Text(
              'Loading Vault Gallery...',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    final items = _visible;
    if (items.isEmpty) {
      return EmptyState(
        message: _datasetType == DatasetType.empty
            ? 'No photocards currently loaded in this vault.'
            : 'No photocards match your search query or category filter.',
        icon: Icons.search_off_rounded,
        actionLabel: _datasetType == DatasetType.empty
            ? 'Load Sample Cards'
            : 'Reset Filters',
        onAction: _resetSearchAndFilter,
      );
    }
    return CollectionGrid(
      cards: items,
      onToggleOwned: (card) => _toggleOwned(card.id),
    );
  }
}
