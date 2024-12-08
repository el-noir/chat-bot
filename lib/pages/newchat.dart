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
import 'magic_button.dart'; // Import the MagicButton file

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ChatGPT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
       actions: [
  Padding(
    padding: const EdgeInsets.only(right: 8.0), // Add appropriate padding
    child: MagicButton(
      title: "Sign Up",
      icon: Icon(Icons.person_add, size: 16), // Adjust icon size
      position: "left",
      onPressed: () {
        // Handle sign-up logic
      },
    ),
  ),
],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Greeting message updated
                Text(
                  "Hello, how can I assist you?",
                  style: TextStyle(
                    fontSize: 24, // Larger font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30), // Increased spacing for alignment
                // Cards updated
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16, // Reduced spacing for compactness
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      OptionTile(
                        icon: Icons.image,
                        label: "Create image",
                        onTap: () {
                          // Handle image creation logic
                        },
                      ),
                      OptionTile(
                        icon: Icons.lightbulb_outline,
                        label: "Make a plan",
                        onTap: () {
                          // Handle planning logic
                        },
                      ),
                      OptionTile(
                        icon: Icons.text_snippet_outlined,
                        label: "Summarize text",
                        onTap: () {
                          // Handle text summarization
                        },
                      ),
                      OptionTile(
                        icon: Icons.more_horiz,
                        label: "More",
                        onTap: () {
                          // Handle more options
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black, // Changed color to black
        ),
        padding: EdgeInsets.all(12), // Smaller padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28, // Slightly smaller icon
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12, // Smaller font size
                color: Colors.white, // Text color set to white
                fontWeight: FontWeight.bold, // Bold text
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Handle send logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
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
