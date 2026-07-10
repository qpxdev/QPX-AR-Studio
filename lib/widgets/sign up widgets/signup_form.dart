import 'package:flutter/material.dart';
import '../../screens/login/login_screen.dart';

const Color orange = Color(0xFFFF5722);

class SignupForm extends StatefulWidget {
  final bool isMobile;

  const SignupForm({
    super.key,
    this.isMobile = false,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirm = true;
  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please accept Terms & Conditions"),
        ),
      );
      return;
    }

    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Account created successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallHeight = MediaQuery.of(context).size.height <= 600;
    final bool isTinyHeight = MediaQuery.of(context).size.height <= 450;

    return Container(
      color: const Color(0xFF121212),
      padding: EdgeInsets.symmetric(
        horizontal: isTinyHeight ? 16 : (isSmallHeight ? 24 : 40),
        vertical: isTinyHeight ? 4 : (isSmallHeight ? 12 : 20),
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
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: isTinyHeight ? 14 : (isSmallHeight ? 18 : 24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (!isTinyHeight) ...[
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: "Join "),
                        TextSpan(
                          text: "QPX AR Studio",
                          style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " and start creating today."),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 10 : 24)),
                _FieldLabel("Full Name", isSmallHeight: isSmallHeight),
                SizedBox(height: isTinyHeight ? 1 : (isSmallHeight ? 3 : 8)),
                _StyledField(
                  controller: _nameController,
                  hint: "Enter your full name",
                  icon: Icons.person_outline,
                  isSmallHeight: isSmallHeight,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: isTinyHeight ? 3 : (isSmallHeight ? 6 : 20)),
                _FieldLabel("Email Address", isSmallHeight: isSmallHeight),
                SizedBox(height: isTinyHeight ? 1 : (isSmallHeight ? 3 : 8)),
                _StyledField(
                  controller: _emailController,
                  hint: "you@example.com",
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  isSmallHeight: isSmallHeight,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter email";
                    }

                    if (!RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w]{2,4}$')
                        .hasMatch(v)) {
                      return "Invalid email";
                    }

                    return null;
                  },
                ),
                SizedBox(height: isTinyHeight ? 3 : (isSmallHeight ? 6 : 20)),
                _FieldLabel("Password", isSmallHeight: isSmallHeight),
                SizedBox(height: isTinyHeight ? 1 : (isSmallHeight ? 3 : 8)),
                _StyledField(
                  controller: _passwordController,
                  hint: "Create password",
                  icon: Icons.lock_outline,
                  obscureText: _hidePassword,
                  isSmallHeight: isSmallHeight,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Password is required";
                    }
                    if (v.length < 8) {
                      return "Minimum 8 characters";
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(v)) {
                      return "Must contain at least 1 uppercase letter";
                    }
                    if (!RegExp(r'[0-9]').hasMatch(v)) {
                      return "Must contain at least 1 number";
                    }
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v)) {
                      return "Must contain at least 1 special character";
                    }
                    return null;
                  },
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        _hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: isTinyHeight ? 16 : (isSmallHeight ? 18 : 24),
                      ),
                    ),
                  ),
                ),
                if (!isTinyHeight) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Use at least 8 characters with uppercase, numbers, and special characters.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isSmallHeight ? 9 : 11,
                    ),
                  ),
                ],
                SizedBox(height: isTinyHeight ? 3 : (isSmallHeight ? 6 : 20)),
                _FieldLabel("Confirm Password", isSmallHeight: isSmallHeight),
                SizedBox(height: isTinyHeight ? 1 : (isSmallHeight ? 3 : 8)),
                _StyledField(
                  controller: _confirmController,
                  hint: "Confirm password",
                  icon: Icons.lock_outline,
                  obscureText: _hideConfirm,
                  isSmallHeight: isSmallHeight,
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _hideConfirm = !_hideConfirm;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        _hideConfirm ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: isTinyHeight ? 16 : (isSmallHeight ? 18 : 24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 8 : 22)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isTinyHeight ? 16 : (isSmallHeight ? 20 : 24),
                      width: isTinyHeight ? 16 : (isSmallHeight ? 20 : 24),
                      child: Transform.scale(
                        scale: isTinyHeight ? 0.75 : (isSmallHeight ? 0.85 : 0.95),
                        child: Checkbox(
                          value: _agree,
                          activeColor: orange,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            setState(() {
                              _agree = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: isTinyHeight ? 6 : 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: isTinyHeight ? 9 : (isSmallHeight ? 11 : 13),
                          ),
                          children: const [
                            TextSpan(text: "I agree to the "),
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 10 : 26)),
                SizedBox(
                  width: double.infinity,
                  height: isTinyHeight ? 28 : (isSmallHeight ? 36 : 50),
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
                      onPressed: _loading ? null : _signup,
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
                                strokeWidth: isTinyHeight ? 1.5 : (isSmallHeight ? 2.0 : 2.5),
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: isTinyHeight ? 12 : (isSmallHeight ? 14 : 17),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: isTinyHeight ? 4 : (isSmallHeight ? 8 : 20)),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: isTinyHeight ? 10 : (isSmallHeight ? 12 : 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: isTinyHeight ? 10 : (isSmallHeight ? 12 : 14),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool isSmallHeight;

  const _FieldLabel(this.text, {required this.isSmallHeight});

  @override
  Widget build(BuildContext context) {
    final bool isTinyHeight = MediaQuery.of(context).size.height <= 450;
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: isTinyHeight ? 9 : (isSmallHeight ? 11 : 14),
      ),
    );
  }
}

class _StyledField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isSmallHeight;

  const _StyledField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.validator,
    required this.isSmallHeight,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTinyHeight = MediaQuery.of(context).size.height <= 450;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: Colors.white,
        fontSize: isTinyHeight ? 12 : (isSmallHeight ? 13 : 15),
      ),
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
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: isTinyHeight ? 11 : (isSmallHeight ? 12 : 14),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
          size: isTinyHeight ? 16 : (isSmallHeight ? 18 : 22),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFF1B1B1B),
        contentPadding: EdgeInsets.symmetric(
          vertical: isTinyHeight ? 5 : (isSmallHeight ? 10 : 14),
          horizontal: isSmallHeight ? 14 : 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
          borderSide: const BorderSide(
            color: Color(0xFFFF5722),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTinyHeight ? 8 : (isSmallHeight ? 10 : 14)),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: isTinyHeight ? 9 : 12,
        ),
      ),
    );
  }
}
