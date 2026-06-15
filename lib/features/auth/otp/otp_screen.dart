import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    // Auto-submit when all 4 digits filled
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) _verify();
  }

  void _verify() => context.go('/home');

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

              // Icon
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_outline,
                  color: Colors.white, size: 32),
              ),

              const SizedBox(height: 24),

              Text('OTP Verification', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text('Verification', style: AppTextStyles.sectionTitle
                .copyWith(color: AppColors.blue)),
              const SizedBox(height: 4),
              Text(
                'Enter 4 digit numbers that sent to\n+${widget.phone}',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // OTP fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 60, height: 64,
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h2.copyWith(fontSize: 24),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.bg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.blue, width: 2),
                        ),
                      ),
                      onChanged: (v) => _onChanged(i, v),
                    ),
                  ),
                )),
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _verify,
                child: const Text('Log In →'),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {},
                child: Text('Re-Send Code',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.blue, fontWeight: FontWeight.w600,
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
