import 'package:flutter/material.dart';

class ChatTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color messageBubbleColor;
  final Color userMessageBubbleColor;
  final Color textColor;
  final TextStyle messageTextStyle;
  final TextStyle userNameStyle;
  final TextStyle timestampStyle;
  final TextStyle inputTextStyle;
  final Color inputBackgroundColor;
  final Color sendButtonColor;
  final double borderRadius;

  const ChatTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.messageBubbleColor,
    required this.userMessageBubbleColor,
    required this.textColor,
    required this.messageTextStyle,
    required this.userNameStyle,
    required this.timestampStyle,
    this.inputTextStyle = const TextStyle(fontSize: 16),
    this.inputBackgroundColor = const Color(0xFFF5F5F5),
    this.sendButtonColor = const Color(0xFF8A6BBE),
    this.borderRadius = 20,
  });
}

class ChatThemes {
  static final defaultTheme = ChatTheme(
    primaryColor: const Color(0xFF8A6BBE),
    backgroundColor: const Color(0xFFF4F1DE),
    messageBubbleColor: Colors.white,
    userMessageBubbleColor: const Color(0xFFFFD166),
    textColor: const Color(0xFF6D6875),
    messageTextStyle: const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      color: Color(0xFF6D6875),
    ),
    userNameStyle: const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6D6875),
    ),
    timestampStyle: const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      color: Colors.grey,
    ),
  );

  static final whatsappTheme = ChatTheme(
    primaryColor: const Color(0xFF075E54),
    backgroundColor: const Color(0xFFECE5DD),
    messageBubbleColor: Colors.white,
    userMessageBubbleColor: const Color(0xFFDCF8C6),
    textColor: Colors.black87,
    messageTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    userNameStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    timestampStyle: const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
    inputBackgroundColor: Colors.white,
    sendButtonColor: const Color(0xFF075E54),
  );

  static final slackTheme = ChatTheme(
    primaryColor: const Color(0xFF4A154B),
    backgroundColor: Colors.white,
    messageBubbleColor: const Color(0xFFF8F8F8),
    userMessageBubbleColor: const Color(0xFFE8F5FA),
    textColor: Colors.black87,
    messageTextStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black87,
    ),
    userNameStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    timestampStyle: const TextStyle(
      fontSize: 11,
      color: Colors.grey,
    ),
    inputBackgroundColor: const Color(0xFFF8F8F8),
    sendButtonColor: const Color(0xFF4A154B),
    borderRadius: 4,
  );

  static final teamsTheme = ChatTheme(
    primaryColor: const Color(0xFF464EB8),
    backgroundColor: Colors.white,
    messageBubbleColor: const Color(0xFFF5F5F5),
    userMessageBubbleColor: const Color(0xFFE1E1F7),
    textColor: Colors.black87,
    messageTextStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
    userNameStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    timestampStyle: const TextStyle(
      fontSize: 11,
      color: Colors.grey,
    ),
    inputBackgroundColor: Colors.white,
    sendButtonColor: const Color(0xFF464EB8),
    borderRadius: 8,
  );
}