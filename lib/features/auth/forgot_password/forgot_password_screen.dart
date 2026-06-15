import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Container(
                width: 72, height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.blue, shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_reset,
                  color: Colors.white, size: 32),
              ),
              const SizedBox(height: 24),
              Text('Forgot Password?', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text('Enter phone to reset password',
                style: AppTextStyles.caption),
              const SizedBox(height: 32),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('+20', style: AppTextStyles.body),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.push('/otp', extra: '01234567890'),
                child: const Text('Send'),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.pop(),
                child: Text('Re-Send Code In 0:30 ↺',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
