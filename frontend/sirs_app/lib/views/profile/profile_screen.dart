import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //create a user profile, store 
    final user = User(id: 1, name: 'John Doe', email: 'john@example.com');
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //User Info Card
            ListTile(
              leading: const Icon(Icons.person, size: 48),
              title: Text(
                user.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(user.email),
            ),
            const SizedBox(height: 24),
            //Settings
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                /* TODO: navigate to settings */
              },
            ),
            //Support
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text('Support'),
              onTap: () {
                /* TODO: open support */
              },
            ),
            const Spacer(),
            //Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  /* TODO: implement logout */
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
