import 'package:flutter/material.dart';
import 'magic_button.dart'; // Assuming you have MagicButton defined elsewhere.
import 'signup.dart';
import './chatbot_service.dart';
import './custompage.dart';
import './profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String userId;
  final String email;

  // Add named parameters in the constructor
  ChatPage({required this.userId, required this.email});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  DocumentSnapshot? _userData;
  // Fetch user data from Firestore
  void _fetchUserData() async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(_user!.uid) // Assuming the user document is named with UID
      .get();

  setState(() {
  _userData = userDoc;
  });
  }

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
    _user = _auth.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
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
              Expanded(
                child: hasUserStartedChat
                    ? ListView.builder(
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
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to ChatGPT!",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Type your first message to start...",
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.white70
                              : Colors.black54,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 30),
                      AnimatedTypingIndicator(isDarkMode: isDarkMode),
                      SizedBox(height: 40),
                    ],
                  ),
                ),

              ),
              if (isBotTyping)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedTypingDots(isDarkMode: isDarkMode),
                ),
              ChatInputField(
                  controller: _textController, sendMessage: sendMessage),
              if (!isSidebarOpen)
                Footer(
                  onProfileTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          isUserLoggedIn:
                          true, // Replace with actual login state
                          username: "John Doe", // Replace with actual username
                          email:
                          "johndoe@example.com", // Replace with actual email
                          profileImageUrl:
                          "https://example.com/profile.jpg", // Replace with actual URL
                        ),
                      ),
                    );
                  },
                  onChatHistoryTap: () {
                    // Open chat history
                  },
                  onNewChatTap: startNewChat,
                ),

            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isSidebarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Material(
              elevation: 5,
              child: SidebarWidget(
                isDarkMode: isDarkMode,
                onNewChatTap: startNewChat,
                onSignUpTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage(
                      isUserLoggedIn: true,  // Replace with actual login state
                      username: "John Doe",  // Replace with actual username
                      email: "johndoe@example.com",  // Replace with actual email
                      profileImageUrl: "https://example.com/profile.jpg",  // Replace with actual URL
                      userId: _user!.uid,  // Pass the actual userId
                    )),
                  );
                },
                onProfileTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        isUserLoggedIn: true, // Replace with actual login state
                        username: "John Doe", // Replace with actual username
                        email:
                        "johndoe@example.com", // Replace with actual email
                        profileImageUrl:
                        "https://example.com/profile.jpg", // Replace with actual URL
                      ),
                    ),
                  );
                }, // Add navigation logic for Profile
              ),
            ),
          ),

        ],
      ),
    );
  }

}

class AnimatedTypingDots extends StatefulWidget {
  final bool isDarkMode;

  AnimatedTypingDots({required this.isDarkMode});

  @override
  _AnimatedTypingDotsState createState() => _AnimatedTypingDotsState();
}

class _AnimatedTypingDotsState extends State<AnimatedTypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: _animation,
          child: Text(
            '.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        );
      }),
    );
  }
}

class AnimatedTypingIndicator extends StatefulWidget {
  final bool isDarkMode;

  AnimatedTypingIndicator({required this.isDarkMode});

  @override
  _AnimatedTypingIndicatorState createState() =>
      _AnimatedTypingIndicatorState();
}

class _AnimatedTypingIndicatorState extends State<AnimatedTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return ScaleTransition(
          scale: _animation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.white : Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}


class SidebarWidget extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onNewChatTap;
  final VoidCallback onSignUpTap;
  final VoidCallback onProfileTap; // Add this callback for Profile navigation

  SidebarWidget({
    required this.isDarkMode,
    required this.onNewChatTap,
    required this.onSignUpTap,
    required this.onProfileTap, // Include in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.chat,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("New Chat",
                style:
                TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: onNewChatTap,
          ),
          ListTile(
            leading: Icon(Icons.person_add,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Sign Up",
                style:
                TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: onSignUpTap,
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            title: Text("Profile",
                style:
                TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: onProfileTap, // Add the callback here
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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.black54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onChatHistoryTap;
  final VoidCallback onNewChatTap;

  Footer({
    required this.onProfileTap,
    required this.onChatHistoryTap,
    required this.onNewChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
        border: Border(
            top: BorderSide(color: isDarkMode ? Colors.white54 : Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.person,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    isUserLoggedIn: true, // Replace with actual login state
                    username: "John Doe", // Replace with actual username
                    email: "johndoe@example.com", // Replace with actual email
                    profileImageUrl:
                    "https://example.com/profile.jpg", // Replace with actual URL
                  ),
                ),
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.history,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: onChatHistoryTap,
          ),
          IconButton(
            icon: Icon(Icons.chat,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: onNewChatTap,
          ),
        ],
      ),
    );
  }
}