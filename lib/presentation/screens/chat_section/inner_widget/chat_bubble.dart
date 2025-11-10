import 'package:chat_hive/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // light vs dart mode for correct chat message bubble color
    bool isDarkMode = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDartMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isCurrentUser
            ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade600)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
