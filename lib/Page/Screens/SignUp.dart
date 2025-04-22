import 'package:flutter/material.dart';
import 'package:study_app/services/Auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthService _authService = AuthService();

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
                    height: 457,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
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

                  // Email
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                    cursorColor: theme.colorScheme.surfaceVariant,
                    decoration: _inputDecoration(
                      theme: theme,
                      isDarkMode: isDarkMode,
                      label: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                    cursorColor: theme.colorScheme.surfaceVariant,
                    decoration: _inputDecoration(
                      theme: theme,
                      isDarkMode: isDarkMode,
                      label: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  TextField(
                    controller: _confirmPassController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                    cursorColor: theme.colorScheme.surfaceVariant,
                    decoration: _inputDecoration(
                      theme: theme,
                      isDarkMode: isDarkMode,
                      label: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_passController.text.trim() != _confirmPassController.text.trim()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match")),
                          );
                          return;
                        }
                      try{
                        
                        await _authService.signUp(
                          _emailController.text.trim(),
                          _passController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully SignUp")));
                        Navigator.pop(context);

                      }
                      catch(e){
                        String errorMessage = 'Đăng nhập thất bại';

                        // message
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${errorMessage} , Message: ${e.toString()}, ")));
                      
                      }
                       
                      },
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
                      child: Text(
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
                ],
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
