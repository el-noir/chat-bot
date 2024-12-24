import 'package:flutter/material.dart';
import './magic_button.dart'; // Ensure MagicButton is properly defined and imported.
import './signup.dart';
import './chatbot_service.dart';
import './custompage.dart';
import './profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimatedTile extends StatelessWidget {
  final String title;
  final Function(String) onTap;

  const AnimatedTile({required this.title, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(title),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 49, 50, 50),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
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

  const ChatPage({required this.userId, required this.email, Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  DocumentSnapshot? _userData;

  bool isSidebarOpen = false;
  List<String> chatHistory = [];
  bool isBotTyping = false;
  bool hasUserStartedChat = false;

  final TextEditingController _textController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, -0.5), end: const Offset(0, 0))
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

  void _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      // Fetch chat history
      QuerySnapshot chatHistorySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .collection('chatHistory')
          .orderBy('timestamp', descending: true)
          .get();

      setState(() {
        _userData = userDoc;
        chatHistory = chatHistorySnapshot.docs
            .map((doc) => "${doc['sender']}: ${doc['message']}")
            .toList();
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

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

      // Save the user message and bot response to Firestore
      await saveChatToFirestore("You", inputText);
      await saveChatToFirestore("Bot", botResponse);

    } catch (e) {
      setState(() {
        chatHistory.add("Bot: Error occurred. Please try again.");
        isBotTyping = false;
      });
    }
  }

  Future<void> saveChatToFirestore(String sender, String message) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(_user!.uid);
      final chatRef = userDoc.collection('chatHistory').doc();

      await chatRef.set({
        'message': message,
        'sender': sender,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving chat to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.transparent,
        elevation: 0,
        title: const Text(
          'AI BARKAT',
          style: TextStyle(
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
                builder: (context) => CustomPage(
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
                    final isUserMessage = chatHistory[index].startsWith("You:");
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Align(
                        alignment: isUserMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: isUserMessage
                            ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chatHistory[index].substring(4),
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                            : Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                              AssetImage('assets/profile.jpg'),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "barkatBot",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      chatHistory[index]
                                          .substring(5),
                                      style: const TextStyle(
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome to AI BARKAT!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Type your first message to start...",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
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
                          isUserLoggedIn: _user != null,
                          username: _userData?['username'] ?? 'User',
                          email: _user?.email ?? '',
                          profileImageUrl: _userData?['profileImageUrl'] ?? '',
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
                      userId: '',
                      email: '',
                      username: '',
                      profileImageUrl: '',
                      isUserLoggedIn: false,
                    )),
                  );
                },
                onProfileTap: _user != null ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        isUserLoggedIn: true,
                        username: "John Doe",
                        email: "johndoe@example.com",
                        profileImageUrl: "https://example.com/profile.jpg",
                      ),
                    ),
                  );
                } : () {
                  // Do nothing if not authenticated
                },
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
  final VoidCallback onProfileTap; // Add this line

  SidebarWidget({
    required this.isDarkMode,
    required this.onNewChatTap,
    required this.onSignUpTap,
    required this.onProfileTap, // Add this line
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
