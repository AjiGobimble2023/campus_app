part of 'package:campus_app/core.dart';

class EcoFormInput extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String value)? onChanged;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool readOnly; // Tambahkan properti readOnly
  final void Function()? onTap;

  const EcoFormInput({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.icon,
    this.onChanged,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.readOnly = false, // Default value adalah false
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(
        color: AppColors.black,
      ),
      readOnly: readOnly, // Set nilai readOnly sesuai properti
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.secondary, vertical: AppSizes.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.error500),
        ),
        labelStyle: const TextStyle(
          color: AppColors.grey500,
        ),
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grey500),
        prefixIcon: icon == null
            ? null
            : Transform.scale(
                scale: 0.5,
                child: icon,
              ),
      ),
    );
  }
}
