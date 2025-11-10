import 'package:chat_hive/presentation/screens/chat_section/chat_screen.dart';
import 'package:chat_hive/presentation/screens/home/inner_widget/my_drawer.dart';
import 'package:chat_hive/presentation/widgets/user_tile.dart';
import 'package:chat_hive/service/auth_service.dart';
import 'package:chat_hive/service/chat_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //======= chat & auth Service ===========
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),

      //=============== Drawer ================
      drawer: MyDrawer(),

      body: _buildUserList(),
    );
  }

  // build a list of user except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build a indivisual list tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // display all user except current user

    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tap on a user and go to chate page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                reciverEmail: userData["email"],
                reciverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
