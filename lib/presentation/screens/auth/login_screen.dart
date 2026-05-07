import 'package:compumatrix/presentation/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/gradient_header.dart';
import '../../providers/auth_provider.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _onSendOtp() async {
    if (_formKey.currentState!.validate()) {
      final success = await context.read<AuthProvider>().requestOtp('+${_mobileController.text}');
      if (success && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtpVerificationScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradientHeader(
              title: 'Sign in to your\nAccount',
              // Removed subtitleWidget from here as requested
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _mobileController,
                      labelText: 'Enter Mobile Number',
                      hintText: '98765 43210',
                      keyboardType: TextInputType.phone,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              'https://flagcdn.com/w40/in.png',
                              width: 24,
                              errorBuilder: (_, __, ___) => const Icon(Icons.flag),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '+91',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(width: 1, height: 20, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v.length != 10) return 'Enter 10 digit number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Consumer<AuthProvider>(
                      builder: (context, auth, _) {
                        return CustomButton(
                          text: 'Send OTP',
                          isLoading: auth.isLoading,
                          onPressed: _onSendOtp,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    // "Don't have an account? Sign Up" moved here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                       Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF2155FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions\n',
                              style: const TextStyle(color: Color(0xFF2155FF), fontWeight: FontWeight.w600),
                            ),
                            const TextSpan(text: 'and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(color: Color(0xFF2155FF), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
