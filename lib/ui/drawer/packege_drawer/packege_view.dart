import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/packege_model.dart';
import 'package:otfksa2/ui/drawer/packege_drawer/packege_view_model.dart';
import 'package:provider/provider.dart';

class PackagesView extends StatelessWidget {
  const PackagesView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PackagesViewModel(),
      child: Consumer<PackagesViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: const Text('Packages Management'),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.add_square, color: _primaryColor),
                  onPressed: () => viewModel.onAddPackage(context),
                  tooltip: 'Add New Package',
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: _primaryColor))
                : _buildPackagesList(context, viewModel),
          );
        },
      ),
    );
  }

  Widget _buildPackagesList(BuildContext context, PackagesViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.packages.length,
      itemBuilder: (context, index) {
        final pkg = viewModel.packages[index];
        return _PackageCard(
          package: pkg,
          onEdit: () => viewModel.onEditPackage(context, pkg.id),
        );
      },
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;
  final VoidCallback onEdit;
  const _PackageCard({required this.package, required this.onEdit});

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: package.isFeatured ? const BorderSide(color: _primaryColor, width: 2) : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Icon(
          package.isFeatured ? Iconsax.star_1 : Iconsax.box,
          color: package.isFeatured ? _primaryColor : Colors.grey,
          size: 30,
        ),
        title: Text(
          package.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '${package.classesCount} Classes',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              package.price,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black87),
            ),
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Edit', style: TextStyle(color: _primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}
