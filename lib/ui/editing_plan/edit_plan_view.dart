import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/editing_plan/edit_plan_viewmodel.dart';
import 'package:provider/provider.dart';
// import 'edit_plan_viewmodel.dart';

class EditPlanView extends StatelessWidget {
  const EditPlanView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    // 1. استلام الـ planId من الـ arguments
    final String? planId = ModalRoute.of(context)!.settings.arguments as String?;
    
    if (planId == null) {
      return const Scaffold(
        body: Center(child: Text("Error: Plan ID not provided.")),
      );
    }

    // 2. توفير الـ ViewModel باستخدام الـ ID
    return ChangeNotifierProvider(
      create: (_) => EditPlanViewModel(planId: planId),
      child: Consumer<EditPlanViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Edit Plan: ${viewModel.nameController.text.isNotEmpty ? viewModel.nameController.text : 'Loading...'}'),
              backgroundColor: Colors.white,
              elevation: 0.5,
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: _primaryColor))
                : _buildEditForm(context, viewModel),
          );
        },
      ),
    );
  }

  // ==================
  // Helper Widgets
  // ==================

  Widget _buildEditForm(BuildContext context, EditPlanViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. حقل اسم الخطة
          _buildTextField(
            label: 'Plan Name',
            controller: viewModel.nameController,
            icon: Iconsax.tag_2,
            readOnly: viewModel.isSaving,
          ),
          const SizedBox(height: 20),

          // 2. حقل السعر
          _buildTextField(
            label: 'Monthly Price (\$)',
            controller: viewModel.priceController,
            icon: Iconsax.dollar_square,
            keyboardType: TextInputType.number,
            readOnly: viewModel.isSaving,
          ),
          const SizedBox(height: 20),

          // 3. حقل عدد المشتركين
          _buildTextField(
            label: 'Subscriber Count',
            controller: viewModel.subscribersController,
            icon: Iconsax.people,
            keyboardType: TextInputType.number,
            readOnly: true, // نفترض أن هذا الحقل غير قابل للتعديل
          ),
          const SizedBox(height: 40),

          // 4. زر الحفظ
          ElevatedButton(
            onPressed: viewModel.isSaving ? null : () => viewModel.saveChanges(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: viewModel.isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}