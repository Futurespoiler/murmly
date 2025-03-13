import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/chat_screen.dart';
import '../theme/chat_themes.dart';

class ChatModeScreen extends StatelessWidget {
  const ChatModeScreen({super.key});

  Widget _buildDefaultModeCard({
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: AppTheme.primaryColor.withOpacity(0.1),
        highlightColor: AppTheme.primaryColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.chat_bubble_rounded, size: 36, color: AppTheme.primaryColor),
                  const SizedBox(width: 16),
                  const Text(
                    'Murmly+ Chat',
                    style: TextStyle(
                      fontFamily: AppTheme.primaryFont,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Start chatting with our beautiful default theme designed specifically for Murmly+',
                style: TextStyle(
                  fontFamily: AppTheme.secondaryFont,
                  fontSize: 16,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativeModeButton({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppTheme.secondaryFont,
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChat(BuildContext context, ChatTheme theme) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(theme: theme),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error loading chat screen. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Choose Chat Mode',
          style: TextStyle(
            fontFamily: AppTheme.primaryFont,
            color: AppTheme.primaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.primaryColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDefaultModeCard(
                onTap: () => _navigateToChat(context, ChatThemes.defaultTheme),
              ),
              const SizedBox(height: 32),
              const Text(
                'Alternative Themes',
                style: TextStyle(
                  fontFamily: AppTheme.primaryFont,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              const Text(
                'These themes allow you to make your chat look like other popular messaging apps for discretion when needed.',
                style: TextStyle(
                  fontFamily: AppTheme.secondaryFont,
                  fontSize: 14,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAlternativeModeButton(
                    title: 'WhatsApp',
                    color: const Color(0xFF075E54),
                    icon: Icons.chat_bubble_outline,
                    onTap: () => _navigateToChat(context, ChatThemes.whatsappTheme),
                  ),
                  _buildAlternativeModeButton(
                    title: 'Slack',
                    color: const Color(0xFF4A154B),
                    icon: Icons.workspaces_outline,
                    onTap: () => _navigateToChat(context, ChatThemes.slackTheme),
                  ),
                  _buildAlternativeModeButton(
                    title: 'Teams',
                    color: const Color(0xFF464EB8),
                    icon: Icons.groups_outlined,
                    onTap: () => _navigateToChat(context, ChatThemes.teamsTheme),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}