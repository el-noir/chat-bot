// import 'package:flutter/material.dart';

// class ChatPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'ChatGPT',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: Icon(
//           Icons.menu,
//           color: Colors.black,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle sign-up logic
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text("Sign up"),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "What can I help with?",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 20,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       OptionTile(
//                         icon: Icons.image,
//                         label: "Create image",
//                         onTap: () {
//                           // Handle image creation logic
//                         },
//                       ),
//                       OptionTile(
//                         icon: Icons.lightbulb_outline,
//                         label: "Make a plan",
//                         onTap: () {
//                           // Handle planning logic
//                         },
//                       ),
//                       OptionTile(
//                         icon: Icons.text_snippet_outlined,
//                         label: "Summarize text",
//                         onTap: () {
//                           // Handle text summarization
//                         },
//                       ),
//                       OptionTile(
//                         icon: Icons.more_horiz,
//                         label: "More",
//                         onTap: () {
//                           // Handle more options
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ChatInputField(), // Adding the input form here
//         ],
//       ),
//     );
//   }
// }

// class OptionTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const OptionTile({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.grey[200],
//         ),
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 32,
//               color: Colors.black,
//             ),
//             SizedBox(height: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatInputField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         border: Border(
//           top: BorderSide(color: Colors.grey),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Type your message...",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 8),
//               ),
//             ),
//           ),
//           SizedBox(width: 8),
//           ElevatedButton(
//             onPressed: () {
//               // Handle send logic
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               shape: CircleBorder(),
//             ),
//             child: Icon(Icons.send, size: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'chat_input_field.dart'; // Import the ChatInputField

// // class ChatPage extends StatefulWidget {
// //   @override
// //   _ChatPageState createState() => _ChatPageState();
// // }

// // class _ChatPageState extends State<ChatPage> {
// //   final List<Map<String, String>> _messages = [
// //     {"user": "Hi!", "bot": "Hello! How can I assist you?"}
// //   ];

// //   // Function to handle new messages
// //   void _onSend(String botResponse) {
// //     setState(() {
// //       _messages.add({"user": "User's message", "bot": botResponse});
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white, // White background for the page
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent, // Transparent AppBar
// //         elevation: 0,
// //         centerTitle: true,
// //         title: GestureDetector(
// //           onTap: () {
// //             // Navigation code can be added here
// //           },
// //           child: Hero(
// //             tag: 'appBarTitle',
// //             child: Text(
// //               'ChatGPT',
// //               style: TextStyle(
// //                 color: Colors.black,
// //                 fontSize: 24, // Increased font size
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ),
// //         leading: Icon(Icons.chat_bubble_outline, color: Colors.black),
// //       ),
// //       body: Column(
// //         children: [
// //           // Chat Messages List
// //           Expanded(
// //             child: ListView.builder(
// //               reverse: true,
// //               itemCount: _messages.length,
// //               itemBuilder: (context, index) {
// //                 final message = _messages[index];
// //                 final isUserMessage = message["user"] != null;

// //                 return Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
// //                   child: Align(
// //                     alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
// //                     child: Material(
// //                       borderRadius: BorderRadius.circular(12),
// //                       color: isUserMessage ? Colors.black : Colors.grey[300],
// //                       elevation: 4,
// //                       child: Padding(
// //                         padding: EdgeInsets.all(12),
// //                         child: Text(
// //                           isUserMessage ? message["user"]! : message["bot"]!,
// //                           style: TextStyle(
// //                             color: isUserMessage ? Colors.white : Colors.black,
// //                             fontSize: 16,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
          
// //           // Chat Input Field
// //           ChatInputField(onSend: _onSend), // Integrating the ChatInputField
// //         ],
// //       ),
// //     );
// //   }
// // }


import 'package:flutter/material.dart';
import 'magic_button.dart'; // Assuming you have MagicButton defined elsewhere.
import 'signup.dart';

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
  bool isHoveringMenuIcon = false;
  bool isSidebarOpen = false;
  List<String> chatHistory = [];
  bool isUserLoggedIn = false; // Example flag for user login
  bool isBotTyping = false; // Flag for typing indicator

  // TextEditingController for the input field
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
      chatHistory.clear(); // Clear the chat history
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true); // Repeat animation to make the tile bounce
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

  // Function to handle tile click and update the text field
  void updateTextInput(String text) {
    setState(() {
      _textController.text = text;
      isBotTyping = true; // Show the typing indicator when the bot "types"
    });

    // Simulate bot typing and response delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isBotTyping = false; // Hide the typing indicator after response
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
          icon:
              Icon(Icons.menu, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: toggleSidebar,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MagicButton(
              title: "Sign Up",
              icon: Icon(Icons.person_add, size: 16),
              position: "left",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
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
                    // Add floating animated tiles here
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
              ChatInputField(controller: _textController),
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
                    // Profile Section
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: isUserLoggedIn
                            ? AssetImage(
                                'assets/user_profile.png') // User profile picture
                            : AssetImage(
                                'assets/robot_icon.png'), // Robot icon if not logged in
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

  ChatInputField({required this.controller});

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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              foregroundColor: isDarkMode ? Colors.black : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: CircleBorder(),
            ),
            child: Icon(Icons.send, size: 20),
          ),
        ],
      ),
    );
  }
}
