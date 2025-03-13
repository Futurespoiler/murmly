import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/chat_themes.dart';
import '../models/chat_message.dart';
import '../models/chat_state.dart';

class ChatScreen extends StatelessWidget {
  final ChatTheme theme;

  const ChatScreen({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatState>(
      create: (_) => ChatState(initialTheme: theme),
      child: const ChatScreenContent(),
    );
  }
}

class ChatScreenContent extends StatefulWidget {
  const ChatScreenContent({super.key});

  @override
  State<ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<ChatScreenContent> {
  final TextEditingController _messageController = TextEditingController();
  final LayerLink _commandLayerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showCommandSuggestions = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_handleTextChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatState>().startConfiguration();
    });
  }

  void _handleTextChange() {
    final text = _messageController.text;
    if (text.endsWith('/')) {
      _showCommandMenu();
    } else if (_showCommandSuggestions && !text.startsWith('/')) {
      _hideCommandMenu();
    }
  }

  void _handleMessage(String text) {
    if (text.isEmpty) return;

    final chatState = context.read<ChatState>();
    
    switch (chatState.currentStep) {
      case ChatConfigurationStep.agentName:
        chatState.setAgentName(text);
        break;
      case ChatConfigurationStep.conversationStyle:
        chatState.setConversationStyle(text);
        break;
      case ChatConfigurationStep.interests:
        final interests = text
            .split(',')
            .map((s) => s.trim())
            .where((s) => RegExp(r'^[1-8]$').hasMatch(s))
            .map((s) => int.parse(s))
            .map((i) => ['Música', 'Cine', 'Viajes', 'Flirteo', 'Deportes', 'Libros', 'Tecnología', 'Moda'][i - 1])
            .toList();
        
        if (interests.isEmpty) {
          context.read<ChatState>().addSystemMessage(
            'Por favor, selecciona al menos un tema usando números del 1 al 8 separados por comas.'
          );
          return;
        }
        
        chatState.setInterests(interests);
        break;
      case ChatConfigurationStep.completed:
        if (text.startsWith('/')) {
          _handleCommand(text);
        } else {
          chatState.addUserMessage(text);
        }
        break;
      default:
        break;
    }

    _messageController.clear();
  }

  void _handleCommand(String command) {
    final chatState = context.read<ChatState>();
    switch (command.toLowerCase()) {
      case '/murm':
        chatState.updateTheme(ChatThemes.defaultTheme);
        break;
      case '/whatsapp':
        chatState.updateTheme(ChatThemes.whatsappTheme);
        break;
      case '/slack':
        chatState.updateTheme(ChatThemes.slackTheme);
        break;
      case '/teams':
        chatState.updateTheme(ChatThemes.teamsTheme);
        break;
      case '/config':
        chatState.startConfiguration();
        break;
    }
  }

  void _showCommandMenu() {
    if (_overlayEntry != null) return;
    setState(() => _showCommandSuggestions = true);

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: CompositedTransformFollower(
          link: _commandLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -200),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCommandTile(
                    'Murmly Theme',
                    '/murm',
                    () => _handleCommand('/murm'),
                  ),
                  _buildCommandTile(
                    'WhatsApp Theme',
                    '/whatsapp',
                    () => _handleCommand('/whatsapp'),
                  ),
                  _buildCommandTile(
                    'Slack Theme',
                    '/slack',
                    () => _handleCommand('/slack'),
                  ),
                  _buildCommandTile(
                    'Teams Theme',
                    '/teams',
                    () => _handleCommand('/teams'),
                  ),
                  _buildCommandTile(
                    'Configure Murmly',
                    '/config',
                    () => _handleCommand('/config'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  Widget _buildCommandTile(String title, String command, VoidCallback onTap) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(command),
      onTap: () {
        onTap();
        _hideCommandMenu();
        _messageController.clear();
      },
    );
  }

  void _hideCommandMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _showCommandSuggestions = false);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = context.watch<ChatState>();
    final theme = chatState.currentTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          chatState.agentName ?? 'Murmly+',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chatState.messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = chatState.messages[chatState.messages.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? theme.userMessageBubbleColor
                            : theme.messageBubbleColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: theme.messageTextStyle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                            style: theme.timestampStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: CompositedTransformTarget(
                    link: _commandLayerLink,
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: _handleMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: theme.primaryColor,
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _handleMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}