import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../env/app_config.dart';

class EnvDemoPage extends StatelessWidget {
  const EnvDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
        backgroundColor: _getFlavorColor(),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFlavorBanner(),
            const SizedBox(height: 24),
            _buildConfigSection(),
            const SizedBox(height: 24),
            _buildSecuritySection(),
            const SizedBox(height: 24),
            _buildActionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlavorBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getFlavorColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            _getFlavorIcon(),
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            'Current Flavor: ${AppConfig.flavorName.toUpperCase()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            AppConfig.version,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuration Values',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildConfigItem('App Name', AppConfig.appName),
            _buildConfigItem('API Base URL', AppConfig.apiBaseUrl),
            _buildConfigItem('Debug Mode', AppConfig.debug.toString()),
            _buildConfigItem('Version', AppConfig.version),
            _buildConfigItem('Is Production', AppConfig.isProduction.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security & Obfuscation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sentry DSN (Obfuscated):',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Text(
                '••••••••••••••••••••••••••••••••',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This value is obfuscated in the generated code for security.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _copyApiUrl(context),
                icon: const Icon(Icons.copy),
                label: const Text('Copy API URL'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showConfigDetails(context),
                icon: const Icon(Icons.info),
                label: const Text('Show Config Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getFlavorColor() {
    switch (AppConfig.flavor) {
      case AppFlavor.dev:
        return Colors.green;
      case AppFlavor.staging:
        return Colors.orange;
      case AppFlavor.prod:
        return Colors.red;
    }
  }

  IconData _getFlavorIcon() {
    switch (AppConfig.flavor) {
      case AppFlavor.dev:
        return Icons.code;
      case AppFlavor.staging:
        return Icons.build;
      case AppFlavor.prod:
        return Icons.rocket_launch;
    }
  }

  void _copyApiUrl(BuildContext context) {
    Clipboard.setData(ClipboardData(text: AppConfig.apiBaseUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('API URL copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showConfigDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuration Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flavor: ${AppConfig.flavorName}'),
            Text('Debug: ${AppConfig.debug}'),
            Text('Production: ${AppConfig.isProduction}'),
            const SizedBox(height: 16),
            const Text(
              'Environment variables are loaded from:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('.env.${AppConfig.flavorName}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
