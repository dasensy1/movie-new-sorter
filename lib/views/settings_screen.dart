import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              _buildTile(
                context,
                Icons.palette_outlined,
                'Theme',
                'Dark',
                () {},
              ),
              _buildTile(
                context,
                Icons.language_outlined,
                'Language',
                'English',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Notifications',
            [
              _buildTile(
                context,
                Icons.notifications_outlined,
                'Push Notifications',
                'On',
                () {},
              ),
              _buildTile(
                context,
                Icons.email_outlined,
                'Email Notifications',
                'Off',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'About',
            [
              _buildTile(
                context,
                Icons.info_outline,
                'App Version',
                '1.0.0',
                () {},
              ),
              _buildTile(
                context,
                Icons.description_outlined,
                'Terms of Service',
                '',
                () {},
              ),
              _buildTile(
                context,
                Icons.privacy_tip_outlined,
                'Privacy Policy',
                '',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: Colors.red[400],
                side: BorderSide(color: Colors.red[400]!),
              ),
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.grey[400],
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
    );
  }
}
