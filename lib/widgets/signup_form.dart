import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

const Color orange = Color(0xFFFF5722);

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

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
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
              const SizedBox(height: 18),
              const _FieldLabel("Full Name"),
              const SizedBox(height: 6),
              _StyledField(
                controller: _nameController,
                hint: "Enter your full name",
                icon: Icons.person_outline,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              const _FieldLabel("Email Address"),
              const SizedBox(height: 6),
              _StyledField(
                controller: _emailController,
                hint: "you@example.com",
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
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
              const SizedBox(height: 14),
              const _FieldLabel("Password"),
              const SizedBox(height: 6),
              _StyledField(
                controller: _passwordController,
                hint: "Create password",
                icon: Icons.lock_outline,
                obscureText: _hidePassword,
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
                suffix: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Use at least 8 characters with uppercase, numbers, and special characters.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 14),
              const _FieldLabel("Confirm Password"),
              const SizedBox(height: 6),
              _StyledField(
                controller: _confirmController,
                hint: "Confirm password",
                icon: Icons.lock_outline,
                obscureText: _hideConfirm,
                validator: (v) {
                  if (v != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                suffix: IconButton(
                  icon: Icon(
                    _hideConfirm ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _hideConfirm = !_hideConfirm;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agree,
                    activeColor: orange,
                    onChanged: (value) {
                      setState(() {
                        _agree = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          children: [
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
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey,
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
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14,
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

  const _StyledField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFF1B1B1B),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFFF5722),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
