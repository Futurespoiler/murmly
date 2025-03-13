import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'chat_mode_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Murmly+',
                  style: TextStyle(
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your secrets, our moments.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.secondaryFont,
                    fontSize: 20,
                    color: AppTheme.textColor,
                  ),
                ),
                const Text(
                  'No sign-up needed to start.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.secondaryFont,
                    fontSize: 16,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatModeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Start Chatting',
                    style: TextStyle(
                      fontFamily: AppTheme.primaryFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
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