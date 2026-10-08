import 'package:flutter/material.dart';
import 'package:h1/features/collection/data/sample_cards.dart';
import 'package:h1/features/collection/models/photocard.dart';
import 'package:h1/features/collection/widgets/collection_grid.dart';
import 'package:h1/features/collection/widgets/collection_search_bar.dart';
import 'package:h1/features/collection/widgets/empty_state.dart';
import 'package:h1/features/collection/widgets/tag_filter_row.dart';

/// Pemilik SEMUA state layar ini: data, query, tag terpilih, loading.
/// Widget anak hanya menerima nilai dan melapor lewat callback.
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  bool _isLoading = true;
  List<Photocard> _cards = [];
  String _query = '';
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _cards = List.of(sampleCards);
      _isLoading = false;
    });
  }

  List<Photocard> get _visible => _cards.where((c) {
        final okTag = _selectedTag == null || c.tag == _selectedTag;
        final okQuery = c.member.toLowerCase().contains(_query.toLowerCase());
        return okTag && okQuery;
      }).toList();

  void _toggleOwned(String id) {
    setState(() {
      _cards = [
        for (final c in _cards) c.id == id ? c.copyWith(owned: !c.owned) : c,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photocard Vault')),
      body: Column(
        children: [
          CollectionSearchBar(onChanged: (v) => setState(() => _query = v)),
          TagFilterRow(
            tags: cardTags,
            selected: _selectedTag,
            onSelected: (t) => setState(() => _selectedTag = t),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    final items = _visible;
    if (items.isEmpty) {
      return const EmptyState(message: 'No photocards match your search.');
    }
    return CollectionGrid(items: items, onToggleOwned: _toggleOwned);
  }
}