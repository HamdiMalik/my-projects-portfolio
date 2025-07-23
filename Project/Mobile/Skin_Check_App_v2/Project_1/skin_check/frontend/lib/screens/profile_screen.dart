import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincheck/providers/auth_provider.dart';
import 'package:skincheck/providers/scan_provider.dart';
import 'package:skincheck/utils/theme.dart';
import 'package:skincheck/screens/login_screen.dart';
import 'package:skincheck/screens/history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ScanProvider>(
      builder: (context, authProvider, scanProvider, child) {
        final user = authProvider.user;
        final unsyncedCount = scanProvider.unsyncedCount;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF33B8FF).withOpacity(0.8),
                          Color(0xFF33B8FF),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        
                        // Profile Avatar
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // User Info or Login Button
                        if (user != null) ...[
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Sync Status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: unsyncedCount > 0 
                                  ? Colors.orange.withOpacity(0.2)
                                  : Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  unsyncedCount > 0 
                                      ? Icons.cloud_off 
                                      : Icons.cloud_done,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  unsyncedCount > 0 
                                      ? '$unsyncedCount scans not synced'
                                      : 'All scans synced',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Action buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (unsyncedCount > 0) ...[
                                _buildActionButton(
                                  icon: Icons.cloud_upload,
                                  label: 'Sync Now',
                                  onTap: () async {
                                    await scanProvider.syncScans();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('✅ Scans synced successfully!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 12),
                              ],
                              _buildActionButton(
                                icon: Icons.logout,
                                label: 'Sign Out',
                                onTap: () {
                                  _showLogoutDialog(context, authProvider);
                                },
                              ),
                            ],
                          ),
                        ] else ...[
                          const Text(
                            'Welcome to SkinCheck',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to sync your scan history across devices',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),

                          if (unsyncedCount > 0) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlueDark.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$unsyncedCount scans saved locally',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Login Button with new design
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF33B8FF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  // Menu Section
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          icon: Icons.history,
                          title: 'History',
                          subtitle: user != null 
                              ? 'View all your scans'
                              : '$unsyncedCount scans stored locally',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HistoryScreen(),
                              ),
                            );
                          },
                          isFirst: true,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Settings page will be implemented'),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          title: 'About',
                          onTap: () {
                            _showAboutDialog(context);
                          },
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  // Offline Notice
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF33B8FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF33B8FF).withOpacity(0.2),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cloud_off,
                          color: Color(0xFF33B8FF),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Works Offline',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF33B8FF),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'SkinCheck works completely offline. Your scan history is saved locally and will be synced to the cloud when you sign in.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF33B8FF),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          'POWERED BY',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'SKIN CHECK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF33B8FF),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF33B8FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: const Color(0xFF33B8FF),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey[200],
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Color(0xFF33B8FF)),
            SizedBox(width: 8),
            Text('Sign Out'),
          ],
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF33B8FF)),
            ),
          ),
          TextButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pop(context);
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Color(0xFF33B8FF)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF33B8FF)),
            SizedBox(width: 8),
            Text('About Skin Check'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skin Check App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text(
              'An advanced skin health monitoring application designed to help users track and analyze their skin condition.\n\nWorks offline - your scan history is saved locally and synced when you log in.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFF33B8FF)),
            ),
          ),
        ],
      ),
    );
  }
}