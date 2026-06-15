import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: const Color(0xFFE2E8F0).withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0A1628).withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Logo ──────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Grw',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          fontSize: 48,
                          color: Color(0xFF0059C7),
                          letterSpacing: -2.4,
                          height: 1.17,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0059C7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.arrow_upward,
                            color: Colors.white, size: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GROW YOUR MONEY',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: const Color(0xFF45474C).withValues(alpha: 0.8),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Header ────────────────────────────────────
                  const Text(
                    'Log In Your Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black,
                      height: 1.33,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Secure access to your wealth terminal',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF45474C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // ── Email ─────────────────────────────────────
                  _inputField(
                    controller: _emailController,
                    hint: 'Email',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // ── Password ──────────────────────────────────
                  _inputField(
                    controller: _passwordController,
                    hint: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscure: _obscurePassword,
                    trailing: GestureDetector(
                      onTap: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF45474C).withValues(alpha: 0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // ── Forgot password ───────────────────────────
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push('/forgot-password'),
                      child: const Text(
                        'Forgot Your Password?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF0059C7),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Login button ──────────────────────────────
                  GestureDetector(
                    onTap: () =>
                        context.go('/otp', extra: _emailController.text),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0059C7), Color(0xFF004398)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF0059C7).withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.login, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),

                  // ── OR divider ────────────────────────────────
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                            color: const Color(0xFFC5C6CD)
                                .withValues(alpha: 0.3)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color(0xFF45474C),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                            color: const Color(0xFFC5C6CD)
                                .withValues(alpha: 0.3)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ── Social buttons ────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialBtn(
                          bg: Colors.white,
                          icon: Icons.g_mobiledata_rounded,
                          iconColor: Colors.black87,
                          border: true),
                      const SizedBox(width: 24),
                      _socialBtn(
                          bg: Colors.black,
                          icon: Icons.apple,
                          iconColor: Colors.white),
                      const SizedBox(width: 24),
                      _socialBtn(
                          bg: const Color(0xFF1877F2),
                          icon: Icons.facebook,
                          iconColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ── Sign up ───────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have An Account? ",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF45474C)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF0059C7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Secure footer ─────────────────────────────
                  Opacity(
                    opacity: 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.shield_outlined,
                            size: 14, color: Color(0xFF45474C)),
                        SizedBox(width: 4),
                        Text(
                          'Secure Login Portal',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF45474C),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Icon(prefixIcon,
                color: const Color(0xFF45474C).withValues(alpha: 0.7),
                size: 20),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscure,
              style: const TextStyle(
                  fontFamily: 'Inter', fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: const Color(0xFF45474C).withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }

  Widget _socialBtn({
    required Color bg,
    required IconData icon,
    required Color iconColor,
    bool border = false,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: border
            ? Border.all(
                color: const Color(0xFFC5C6CD).withValues(alpha: 0.3))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 28),
    );
  }
}
