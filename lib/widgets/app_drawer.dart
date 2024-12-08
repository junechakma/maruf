import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Book Resale Platform',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          if (!authProvider.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          if (authProvider.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Services'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/services');
              },
            ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contact');
            },
          ),
          if (authProvider.isLoggedIn) ...[
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ],
      ),
    );
  }
}
