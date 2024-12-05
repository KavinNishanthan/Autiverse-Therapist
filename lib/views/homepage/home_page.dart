import 'package:autiverse/core/widgets/app_drawer.dart';
import 'package:autiverse/core/widgets/common_app_bar.dart';
import 'package:autiverse/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: CommonAppBar(title: "AutiVerse"),
      drawer: user != null ? AppDrawer(user: user) : null,
      body: user == null
          ? const Center(child: Text('No user logged in.'))
          : const Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
