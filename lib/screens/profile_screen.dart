import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Auth/login.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _getUserName() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null && user.userMetadata != null && user.userMetadata!['full_name'] != null) {
      return user.userMetadata!['full_name'];
    }
    return 'User';
  }

  String _getFirstLetter() {
    final name = _getUserName();
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Supabase.instance.client.auth.signOut();
                if (!mounted) return;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = _getUserName();
    final firstLetter = _getFirstLetter();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// PROFILE IMAGE
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.indigo, width: 2),
                ),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// NAME
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 14),

            /// OPTIONS TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Options",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// OPTIONS LIST
            GestureDetector(
              onTap: _navigateToEditProfile,
              child: _optionTile(Icons.person_outline, "Edit Profile"),
            ),

            const SizedBox(height: 10),

            /// LOGOUT
            GestureDetector(
              onTap: _showLogoutDialog,
              child: _optionTile(Icons.logout, "Log Out", color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  /// OPTION TILE WIDGET
  Widget _optionTile(IconData icon, String title,
      {Color color = Colors.black}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: color),
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
