import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../theme/chat_themes.dart';

enum ChatConfigurationStep {
  initial,
  agentName,
  conversationStyle,
  interests,
  completed
}

class ChatState extends ChangeNotifier {
  // Configuration state
  ChatConfigurationStep _currentStep = ChatConfigurationStep.initial;
  String? _agentName;
  String? _selectedStyle;
  List<String> _selectedInterests = [];
  
  // Theme state
  ChatTheme _currentTheme;
  
  // Messages
  final List<ChatMessage> _messages = [];
  
  ChatState({required ChatTheme initialTheme}) : _currentTheme = initialTheme;
  
  // Getters
  ChatConfigurationStep get currentStep => _currentStep;
  String? get agentName => _agentName;
  String? get selectedStyle => _selectedStyle;
  List<String> get selectedInterests => List.unmodifiable(_selectedInterests);
  ChatTheme get currentTheme => _currentTheme;
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  
  // Configuration methods
  void startConfiguration() {
    _currentStep = ChatConfigurationStep.agentName;
    _addSystemMessage('¡Hola! Soy tu nuevo confidente. ¿Cómo te gustaría llamarme?');
    notifyListeners();
  }
  
  void setAgentName(String name) {
    _agentName = name;
    _currentStep = ChatConfigurationStep.conversationStyle;
    _addUserMessage(name);
    _addSystemMessage('¡Me encanta ese nombre! Encantado de conocerte, puedes llamarme $name.');
    _showConversationStyleOptions();
    notifyListeners();
  }
  
  void setConversationStyle(String style) {
    _selectedStyle = style;
    _currentStep = ChatConfigurationStep.interests;
    _addUserMessage(style);
    _addSystemMessage('$style ¡Excelente elección! Me adaptaré a este estilo.');
    _showInterestsSelection();
    notifyListeners();
  }
  
  void setInterests(List<String> interests) {
    _selectedInterests = interests;
    _currentStep = ChatConfigurationStep.completed;
    _addUserMessage(interests.join(', '));
    _addSystemMessage('¡Genial! Me encantan esos temas: ${interests.join(', ')}. ¿De cuál te gustaría hablar primero?');
    notifyListeners();
  }
  
  // Theme methods
  void updateTheme(ChatTheme newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
  
  // Message methods
  void addUserMessage(String text) {
    _addUserMessage(text);
    notifyListeners();
  }
  
  void _addUserMessage(String text) {
    _messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
  }
  
  void addSystemMessage(String text) {
    _messages.add(ChatMessage(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  void _addSystemMessage(String text) {
    addSystemMessage(text);
  }
  
  void _showConversationStyleOptions() {
    addSystemMessage(
      'Elige el estilo de tu conversación:\n\n'
      '1. 😊 Chistes, emojis y buen rollo\n'
      '2. 💼 Conversaciones claras y respetuosas\n'
      '3. 😏 Juegos, piropos y complicidad'
    );
  }
  
  void _showInterestsSelection() {
    final List<String> interests = [
      'Música', 'Cine', 'Viajes', 'Flirteo',
      'Deportes', 'Libros', 'Tecnología', 'Moda'
    ];
    
    _addSystemMessage(
      '¿De qué te gustaría hablar? Elige los temas que más te interesen '
      '(escribe los números separados por comas):\n\n' +
      interests.asMap().entries.map((e) => "${e.key + 1}. ${e.value}").join("\n")
    );
  }
}