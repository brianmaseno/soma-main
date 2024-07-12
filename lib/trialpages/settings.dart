import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(4, 133, 162, 1),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          // Account Section
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Profile',
                subtitle: 'Edit your profile',
                leading: Icon(Icons.person),
                onTap: () {
                  // Navigate to profile settings
                },
              ),
              SettingsTile(
                title: 'Change Password',
                subtitle: 'Update your password',
                leading: Icon(Icons.lock),
                onTap: () {
                  // Navigate to change password
                },
              ),
              SettingsTile(
                title: 'Language',
                subtitle: 'Select your language',
                leading: Icon(Icons.language),
                onTap: () {
                  // Navigate to language settings
                },
              ),
            ],
          ),
          Divider(),

          // Notifications Section
          SettingsSection(
            title: 'Notifications',
            tiles: [
              SettingsTile(
                title: 'Push Notifications',
                subtitle: 'Manage your notifications',
                leading: Icon(Icons.notifications),
                trailing: Switch(
                  value: true,
                  onChanged: (bool value) {
                    // Handle switch toggle
                  },
                ),
              ),
              SettingsTile(
                title: 'Email Notifications',
                subtitle: 'Manage email preferences',
                leading: Icon(Icons.email),
                trailing: Switch(
                  value: false,
                  onChanged: (bool value) {
                    // Handle switch toggle
                  },
                ),
              ),
            ],
          ),
          Divider(),

          // Privacy Section
          SettingsSection(
            title: 'Privacy',
            tiles: [
              SettingsTile(
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                leading: Icon(Icons.privacy_tip),
                onTap: () {
                  // Navigate to privacy policy
                },
              ),
              SettingsTile(
                title: 'Terms of Service',
                subtitle: 'Read our terms of service',
                leading: Icon(Icons.description),
                onTap: () {
                  // Navigate to terms of service
                },
              ),
              SettingsTile(
                title: 'Blocked Users',
                subtitle: 'Manage blocked users',
                leading: Icon(Icons.block),
                onTap: () {
                  // Navigate to blocked users
                },
              ),
            ],
          ),
          Divider(),

          // About Section
          SettingsSection(
            title: 'About',
            tiles: [
              SettingsTile(
                title: 'App Version',
                subtitle: '1.0.0',
                leading: Icon(Icons.info),
              ),
              SettingsTile(
                title: 'Contact Support',
                subtitle: 'Get help and support',
                leading: Icon(Icons.support),
                onTap: () {
                  // Navigate to contact support
                },
              ),
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.logout),
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  SettingsSection({required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          ...tiles,
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  SettingsTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
