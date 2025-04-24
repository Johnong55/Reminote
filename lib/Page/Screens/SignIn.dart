import 'package:flutter/material.dart';
import 'package:study_app/services/Auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

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

  // Handle SignIn logic
  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.signIn(
          _emailController.text.trim(),
          _passController.text.trim(),
        );
        // You can add successful login navigation or feedback here
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công!')));
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false, // remove hết các route trước đó
        );
      } catch (e) {
        String errorMessage = 'Đăng nhập thất bại';
        if (e.toString().contains('wrong-password')) {
          errorMessage = 'Mật khẩu không đúng';
        } else if (e.toString().contains('user-not-found')) {
          errorMessage = 'Email không tồn tại';
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
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
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 450,
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
                      'Log In',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.surfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 30),

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
                    const SizedBox(height: 30),

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
                    const SizedBox(height: 25),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignIn,
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
                        child:
                            _isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(
                                  'Sign In',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Sign Up Link
                    Row(
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                isDarkMode
                                    ? Colors.grey.shade400
                                    : const Color(0xFF837E93),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.surfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // TODO: Handle forgot password
                      },
                      style: theme.textButtonTheme.style,
                      child: Text(
                        'Forget Password?',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.surfaceVariant,
                        ),
                      ),
                    ),
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
        borderSide: const BorderSide(width: 1.5, color: Color(0xFF9F7BFF)),
      ),
      filled: theme.inputDecorationTheme.filled,
      fillColor: theme.inputDecorationTheme.fillColor,
      contentPadding: theme.inputDecorationTheme.contentPadding,
    );
  }
}
