import 'package:autiverse/core/widgets/app_drawer.dart';
import 'package:autiverse/core/widgets/common_app_bar.dart';
import 'package:autiverse/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "AutiVerse"),
      drawer: AppDrawer(
        user: User(
          name: 'Kavin Nishanthan',
          email: 'kavin@example.com',
          profileImageUrl: 'https://example.com/profile.jpg',
          phoneNumber: "1234567890",
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
