import 'package:flutter/material.dart';
import '../../screens/signup/signup_screen.dart';

const Color orange = Color(0xFFFF5722);

class RightPanel extends StatefulWidget {
  final bool isMobile;

  const RightPanel({
    super.key,
    this.isMobile = false,
  });

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool _loading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed in successfully'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallHeight = MediaQuery.of(context).size.height <= 600;
    final bool isTinyHeight = MediaQuery.of(context).size.height <= 450;

    return Container(
      color: const Color(0xFF121212),
      padding: EdgeInsets.symmetric(
        horizontal: isTinyHeight ? 16 : (isSmallHeight ? 24 : 40),
        vertical: isTinyHeight ? 4 : (isSmallHeight ? 12 : 28),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTinyHeight ? 14 : (isSmallHeight ? 20 : 32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isTinyHeight) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to your QPX AR Studio account',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isSmallHeight ? 12 : 16,
                    ),
                  ),
                ],
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 12 : 36)),
                _LoginField(
                  controller: emailController,
                  label: 'Email Address',
                  hintText: 'you@example.com',
                  icon: Icons.mail_outline,
                  isSmallHeight: isSmallHeight,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    if (!RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 8 : 22)),
                _LoginField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  icon: Icons.lock_outline,
                  obscureText: hidePassword,
                  isSmallHeight: isSmallHeight,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() => hidePassword = !hidePassword);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: isTinyHeight ? 16 : (isSmallHeight ? 18 : 24),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Minimum 8 characters';
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Must contain at least 1 uppercase letter';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Must contain at least 1 number';
                    }
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                      return 'Must contain at least 1 special character';
                    }
                    return null;
                  },
                ),
                if (!isTinyHeight) ...[
                  SizedBox(height: isSmallHeight ? 4 : 10),
                  Text(
                    'Use at least 8 characters with uppercase, numbers, and special characters.',
                    style: TextStyle(color: Colors.grey, fontSize: isSmallHeight ? 10 : 12),
                  ),
                ],
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 2 : 25)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: isTinyHeight ? 10 : (isSmallHeight ? 12 : 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isTinyHeight ? 6 : (isSmallHeight ? 10 : 28)),
                SizedBox(
                  width: double.infinity,
                  height: isTinyHeight ? 28 : (isSmallHeight ? 38 : 52),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
                    boxShadow: isTinyHeight
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFFFF5722).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                    ),
                    child: ElevatedButton(
                      onPressed: _loading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
                        ),
                      ),
                      child: _loading
                          ? SizedBox(
                              width: isTinyHeight ? 16 : (isSmallHeight ? 18 : 24),
                              height: isTinyHeight ? 16 : (isSmallHeight ? 18 : 24),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: isTinyHeight ? 1.5 : (isSmallHeight ? 2.0 : 2.5),
                              ),
                            )
                          : Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: isTinyHeight ? 12 : (isSmallHeight ? 14 : 17),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 8 : 22)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isTinyHeight ? 10 : (isSmallHeight ? 12 : 14),
                      ),
                    ),
                    TextButton(
                      onPressed: _goToSignUp,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.bold,
                          fontSize: isTinyHeight ? 10 : (isSmallHeight ? 12 : 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final bool isSmallHeight;

  const _LoginField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.validator,
    required this.isSmallHeight,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTinyHeight = MediaQuery.of(context).size.height <= 450;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isTinyHeight ? 9 : (isSmallHeight ? 12 : 14),
          ),
        ),
        SizedBox(height: isTinyHeight ? 1 : (isSmallHeight ? 4 : 8)),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(color: Colors.white, fontSize: isTinyHeight ? 12 : (isSmallHeight ? 13 : 15)),
          decoration: InputDecoration(
            isDense: true,
            prefixIconConstraints: BoxConstraints(
              minWidth: isTinyHeight ? 32 : 48,
              minHeight: 0,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: isTinyHeight ? 32 : 48,
              minHeight: 0,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: isTinyHeight ? 11 : (isSmallHeight ? 12 : 14)),
            prefixIcon: Icon(icon, color: Colors.grey, size: isTinyHeight ? 16 : (isSmallHeight ? 18 : 22)),
            suffixIcon: suffix,
            filled: true,
            fillColor: const Color(0xFF1B1B1B),
            contentPadding: EdgeInsets.symmetric(
              vertical: isTinyHeight ? 5 : (isSmallHeight ? 10 : 14),
              horizontal: isSmallHeight ? 14 : 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
              borderSide: BorderSide(color: Colors.grey.shade800),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
              borderSide: BorderSide(color: Colors.grey.shade800),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
              borderSide: const BorderSide(color: orange, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: isTinyHeight ? 9 : (isSmallHeight ? 10 : 12),
            ),
          ),
        ),
      ],
    );
  }
}
