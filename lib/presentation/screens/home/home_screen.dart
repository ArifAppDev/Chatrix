import 'package:chat_hive/presentation/screens/home/inner_widget/my_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("Home Screen"), centerTitle: true),

      //=============== Drawer ================
      drawer: MyDrawer(),
    );
  }
}
