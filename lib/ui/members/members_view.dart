import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/members/members_viewmodel.dart';
import 'package:otfksa2/ui/widgtes/helper_widget.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:provider/provider.dart';

class MembersView extends StatelessWidget {
  const MembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MembersViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'assets/images/orangetheory_logo.png',
          ), // (نفس اللوجو)
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.menu_1, color: Colors.red),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildHeader(context, viewModel),
            const SizedBox(height: 16),
            buildSearchBar(viewModel),
            const SizedBox(height: 16),
            viewModel.isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : buildMembersList(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MembersViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Members',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Manage gym members',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => viewModel.onAddMemberPressed(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Iconsax.user_add, color: Colors.white),
        ),
      ],
    );
  }
}
