import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'data/sample_cards.dart';
import 'models/photocard.dart';

class AddPhotocardScreen extends StatefulWidget {
  final bool isDarkMode;

  const AddPhotocardScreen({super.key, this.isDarkMode = true});

  @override
  State<AddPhotocardScreen> createState() => _AddPhotocardScreenState();
}

class _AddPhotocardScreenState extends State<AddPhotocardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _memberController = TextEditingController();
  final _albumController = TextEditingController();
  String _selectedTag = 'Album';
  bool _isOwned = false;

  @override
  void dispose() {
    _memberController.dispose();
    _albumController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newCard = Photocard(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        member: _memberController.text.trim(),
        album: _albumController.text.trim(),
        tag: _selectedTag,
        imagePath: 'assets/images/member1.jpg',
        owned: _isOwned,
      );
      Navigator.pop(context, newCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Photocard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Photocard to Vault',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Enter card details to expand your collectible gallery.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _memberController,
                decoration: const InputDecoration(
                  labelText: 'Member Name',
                  hintText: 'e.g. Jea, Chris, Bryan',
                  prefixIcon: Icon(Icons.person_rounded),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter member name' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _albumController,
                decoration: const InputDecoration(
                  labelText: 'Album / Event Title',
                  hintText: 'e.g. Album One, World Tour 2024',
                  prefixIcon: Icon(Icons.album_rounded),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter album title' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: _selectedTag,
                decoration: const InputDecoration(
                  labelText: 'Category Tag',
                  prefixIcon: Icon(Icons.local_offer_rounded),
                ),
                dropdownColor: isDark ? const Color(0xFF18181F) : Colors.white,
                items: cardTags.map((tag) {
                  return DropdownMenuItem(value: tag, child: Text(tag));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedTag = val);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mark as Owned (In Vault)'),
                subtitle: const Text('Turn on if you already physically own this card'),
                value: _isOwned,
                activeColor: primary,
                onChanged: (val) => setState(() => _isOwned = val),
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.save_rounded),
                  label: const Text(
                    'Save Photocard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
