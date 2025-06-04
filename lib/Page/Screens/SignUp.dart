import 'package:flutter/material.dart';
import 'package:study_app/services/Auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Display Name validation
  String? _validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên hiển thị không được để trống';
    }
    if (value.length < 2) {
      return 'Tên hiển thị phải có ít nhất 2 ký tự';
    }
    if (value.length > 50) {
      return 'Tên hiển thị không được quá 50 ký tự';
    }
    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  // Confirm Password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Xác nhận mật khẩu không được để trống';
    }
    if (value != _passController.text) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  // Handle SignUp logic
  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signUp(
          _emailController.text.trim(),
          _passController.text.trim(),
         _displayNameController.text.trim(),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công!')),
        );
        Navigator.pop(context);
      } catch (e) {
        String errorMessage = 'Đăng ký thất bại';
        
        if (e.toString().contains('email-already-in-use')) {
          errorMessage = 'Email đã được sử dụng';
        } else if (e.toString().contains('weak-password')) {
          errorMessage = 'Mật khẩu quá yếu';
        } else if (e.toString().contains('invalid-email')) {
          errorMessage = 'Email không hợp lệ';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$errorMessage: ${e.toString()}')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.asset(
                    "assets/images/jpg/vector-1.png",
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.surfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Display Name Field
                    TextFormField(
                      controller: _displayNameController,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.surfaceVariant,
                      validator: _validateDisplayName,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        theme: theme,
                        isDarkMode: isDarkMode,
                        label: 'Display Name',
                      ).copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.colorScheme.surfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.surfaceVariant,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        theme: theme,
                        isDarkMode: isDarkMode,
                        label: 'Email',
                      ).copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.colorScheme.surfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.surfaceVariant,
                      validator: _validatePassword,
                      decoration: _inputDecoration(
                        theme: theme,
                        isDarkMode: isDarkMode,
                        label: 'Password',
                      ).copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.colorScheme.surfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPassController,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge,
                      cursorColor: theme.colorScheme.surfaceVariant,
                      validator: _validateConfirmPassword,
                      decoration: _inputDecoration(
                        theme: theme,
                        isDarkMode: isDarkMode,
                        label: 'Confirm Password',
                      ).copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.colorScheme.surfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignUp,
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            theme.colorScheme.surfaceVariant,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Create Account',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Already have account
                    Row(
                      children: [
                        Text(
                          'Already have an account?',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : const Color(0xFF837E93),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Log In',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.surfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required ThemeData theme,
    required bool isDarkMode,
    required String label,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.surfaceVariant,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          color: isDarkMode ? Colors.grey.shade700 : const Color(0xFF837E93),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          color: isDarkMode ? Colors.grey.shade700 : const Color(0xFF837E93),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0xFF9F7BFF),
        ),
      ),
      filled: theme.inputDecorationTheme.filled,
      fillColor: theme.inputDecorationTheme.fillColor,
      contentPadding: theme.inputDecorationTheme.contentPadding,
    );
  }
}