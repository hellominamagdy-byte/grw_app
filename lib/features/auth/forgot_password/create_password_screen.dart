import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/grw_logo.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const GrwLogo(height: 48),
              const SizedBox(height: 24),
              Container(
                width: 72, height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.blue, shape: BoxShape.circle,
                ),
                child: const Icon(Icons.key_outlined,
                  color: Colors.white, size: 32),
              ),
              const SizedBox(height: 24),
              Text('Create New Password', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text('Password must be new',
                style: AppTextStyles.caption),
              const SizedBox(height: 32),
              TextField(
                obscureText: _obscure1,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscure1 = !_obscure1),
                    child: Icon(_obscure1
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                      color: AppColors.txtH),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                obscureText: _obscure2,
                decoration: InputDecoration(
                  hintText: 'Re-Password',
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscure2 = !_obscure2),
                    child: Icon(_obscure2
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                      color: AppColors.txtH),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Confirm'),
              ),
              const SizedBox(height: 16),
              Text('Re-Send Code In 0:30 ↺',
                style: AppTextStyles.caption.copyWith(color: AppColors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
