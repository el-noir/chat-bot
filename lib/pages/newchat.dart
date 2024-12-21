import 'package:flutter/material.dart';
import 'magic_button.dart'; // Assuming you have MagicButton defined elsewhere.
import 'signup.dart';
import './chatbot_service.dart';
import './custompage.dart';

class AnimatedTile extends StatelessWidget {
  final String title;
  final Function(String) onTap;

  AnimatedTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(title),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 49, 50, 50),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  bool isSidebarOpen = false;
  List<String> chatHistory = [];
  bool isUserLoggedIn =
      false; // Assume this is determined based on the user's login status
  bool isBotTyping = false;
  bool hasUserStartedChat = false;

  TextEditingController _textController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  void toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  void startNewChat() {
    setState(() {
      chatHistory.clear();
      hasUserStartedChat = false;
    });
  }

  void sendMessage() async {
    final inputText = _textController.text.trim();

    if (inputText.isEmpty) return;

    setState(() {
      chatHistory.add("You: $inputText");
      _textController.clear();
      isBotTyping = true;
      hasUserStartedChat = true;
    });

    try {
      final botResponse = await ChatBotService.sendMessage(inputText);

      setState(() {
        chatHistory.add("Bot: $botResponse");
        isBotTyping = false;
      });
    } catch (e) {
      setState(() {
        chatHistory.add("Bot: Error occurred. Please try again.");
        isBotTyping = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void updateTextInput(String text) {
    setState(() {
      _textController.text = text;
      isBotTyping = true;
      hasUserStartedChat = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isBotTyping = false;
        chatHistory.add("Bot: Here's a response to '$text'");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.transparent,
        elevation: 0,
        title: Text(
          'ChatGPT',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Custompage(
                  isDarkMode: isDarkMode,
                  onThemeChanged: (value) {},
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: toggleSidebar,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (!hasUserStartedChat)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello, how can I assist you?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      SlideTransition(
                        position: _slideAnimation,
                        child: AnimatedTile(
                          title: "Ask me anything!",
                          onTap: updateTextInput,
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: AnimatedTile(
                          title: "What's your mood today?",
                          onTap: updateTextInput,
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: AnimatedTile(
                          title: "Tell me a joke!",
                          onTap: updateTextInput,
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: AnimatedTile(
                          title: "Need help with something?",
                          onTap: updateTextInput,
                        ),
                      ),
                    ],
                  ),
                ),
              if (hasUserStartedChat)
                Expanded(
                  child: ListView.builder(
                    itemCount: chatHistory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Align(
                          alignment: chatHistory[index].startsWith("You:")
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: chatHistory[index].startsWith("You:")
                                  ? Colors.blue[200]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chatHistory[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (isBotTyping)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Bot is typing...",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                ),
              ChatInputField(
                  controller: _textController, sendMessage: sendMessage),
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isSidebarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Material(
              elevation: 5,
              child: Container(
                width: 250,
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.chat,
                          color: isDarkMode ? Colors.white : Colors.black),
                      title: Text("New Chat",
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: startNewChat,
                    ),
                    if (!isUserLoggedIn) // Hide if the user is logged in
                      ListTile(
                        leading: Icon(Icons.person_add,
                            color: isDarkMode ? Colors.white : Colors.black),
                        title: Text("Sign Up",
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                      ),
                    ListTile(
                      leading: Icon(Icons.settings,
                          color: isDarkMode ? Colors.white : Colors.black),
                      title: Text("Settings",
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black)),
                      onTap: () {
                        // Navigate to settings page
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: isUserLoggedIn
                            ? AssetImage('assets/profile.jpg')
                            : AssetImage('assets/what-is-bot.webp'),
                      ),
                      title: Text("Profile",
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black)),
                    ),
                    Divider(),
                    Expanded(
                      child: Center(
                        child: Text(
                          'No history available.',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white54 : Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;

  ChatInputField({required this.controller, required this.sendMessage});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        border: Border(
          top: BorderSide(color: isDarkMode ? Colors.white54 : Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(onPressed: sendMessage, child: Text("Send"))
        ],
      ),
    );
  }
}
