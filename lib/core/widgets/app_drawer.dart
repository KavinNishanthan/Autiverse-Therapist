import 'package:autiverse/models/user_model.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final User user;

  const AppDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: BeveledRectangleBorder(),
        width: 250,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.profileImageUrl),
                    ),
                  ),
                ],
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  if (user.phoneNumber.isNotEmpty)
                    Text(
                      user.phoneNumber,
                      style: const TextStyle(color: Colors.black54),
                    ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.black),
                      title: const Text('Home',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.add, color: Colors.black),
                      title: const Text('Add Children',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.pushNamed(context, '/addchild');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.black),
                      title: const Text('Settings',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
