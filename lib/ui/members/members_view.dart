import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/member_model.dart';
import 'package:otfksa2/ui/members/members_viewmodel.dart';
import 'package:otfksa2/ui/widgtes/helper_widget.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:provider/provider.dart';
// import 'package:your_app/models/member_model.dart';
// import 'members_viewmodel.dart';
// import 'members_navigator.dart';

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
            // ✨ UPDATE: Changed icon color to black87 for better contrast
            icon: const Icon(Iconsax.menu_1, color: Colors.black87),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        // ✨ UPDATE: Increased padding from 16.0 to 20.0
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 24), // ✨ UPDATE: Added top space
            _buildHeader(context, viewModel),
            const SizedBox(height: 24), // ✨ UPDATE: Increased spacing
            buildSearchBar(viewModel),
            const SizedBox(height: 20),
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
      crossAxisAlignment: CrossAxisAlignment.center, // ✨ UPDATE: Center alignment
      children: [
        Column( // removed const to allow dynamic styles
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Members',
              // ✨ UPDATE: Bigger font, bolder weight, dark color
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(height: 6), // ✨ UPDATE: adjusted spacing
            Text(
              'Manage gym members',
              // ✨ UPDATE: adjusted grey shade
              style: TextStyle(fontSize: 15, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ],
        ),

        // ✨ UPDATE: Added Container for Shadow effect
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => viewModel.onAddMemberPressed(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(14), // ✨ UPDATE: Slightly larger
              elevation: 0, // Elevation handled by Container
            ),
            child: const Icon(Iconsax.user_add, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}