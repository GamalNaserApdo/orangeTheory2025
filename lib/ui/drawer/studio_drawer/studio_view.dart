import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/drawer/studio_drawer/studio_view_model.dart';
import 'package:provider/provider.dart';
import 'package:otfksa2/models/studio_model.dart';

class StudiosView extends StatelessWidget {
  const StudiosView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudiosViewModel(),
      child: Consumer<StudiosViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: const Text('Studios Management'),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.add_square, color: _primaryColor),
                  onPressed: () => viewModel.onAddStudio(context),
                  tooltip: 'Add New Studio',
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: _primaryColor),
                  )
                : _buildStudiosList(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildStudiosList(StudiosViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.studios.length,
      itemBuilder: (context, index) {
        final studio = viewModel.studios[index];
        return _StudioCard(studio: studio);
      },
    );
  }
}

class _StudioCard extends StatelessWidget {
  final Studio studio;
  const _StudioCard({required this.studio});

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  studio.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _primaryColor,
                  ),
                ),
                _StatusChip(isActive: studio.isActive),
              ],
            ),
            const SizedBox(height: 8),
            _DetailRow(
              icon: Iconsax.location,
              label: 'Location',
              value: studio.location,
            ),
            _DetailRow(
              icon: Iconsax.call,
              label: 'Phone',
              value: studio.contactPhone,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            '$label: $value',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isActive;
  const _StatusChip({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? Colors.green.shade800 : Colors.red.shade800,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
