
import '../../../core/import_file.dart';
import '../../providers/localization_provider.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Language'),
            subtitle: Text(localizationProvider.locale.languageCode == 'en' ? 'English' : 'Hindi'),
            trailing: const Icon(Icons.language),
            onTap: () {
              _showLanguageDialog(context, localizationProvider);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout, color: Colors.red),
            onTap: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocalizationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              leading: Radio<String>(
                value: 'en',
                groupValue: provider.locale.languageCode,
                onChanged: (value) {
                  provider.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Hindi'),
              leading: Radio<String>(
                value: 'hi',
                groupValue: provider.locale.languageCode,
                onChanged: (value) {
                  provider.setLocale(const Locale('hi'));
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
