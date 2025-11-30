// lib/ui/add_package/add_package_view.dart

import 'package:flutter/material.dart';
import 'package:otfksa2/ui/add_packege/add_package_viewmodel.dart';

class AddPackageView extends StatelessWidget {
  // 1. Get the ViewModel to access its logic and state
  final AddPackageViewModel viewModel;

  const AddPackageView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Package')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text field for package name
            TextField(
              onChanged: viewModel.setPackageName,
              decoration: const InputDecoration(labelText: 'Package Name'),
            ),

            // ... other input fields ...
            ElevatedButton(
              onPressed: () =>
                  viewModel.savePackage(), // Calls logic from ViewModel
              child: const Text('Save Package'),
            ),
          ],
        ),
      ),
    );
  }
}
