import 'package:flutter/material.dart';
import 'package:mona/l10n/app_localizations.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/services/sync_service.dart';
import 'package:mona/services/db/app_database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  late TextEditingController _urlController;
  late TextEditingController _passwordController;
  late TextEditingController _encryptionPassphraseController;

  @override
  void initState() {
    super.initState();
    final prefs = Provider.of<PreferencesService>(context, listen: false);
    _urlController = TextEditingController(text: prefs.syncUrl);
    _passwordController = TextEditingController(text: prefs.syncPassword);
    _encryptionPassphraseController =
        TextEditingController(text: prefs.syncEncryptionPassphrase);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _passwordController.dispose();
    _encryptionPassphraseController.dispose();
    super.dispose();
  }

  Future<void> _saveAndSync() async {
    final prefs = Provider.of<PreferencesService>(context, listen: false);
    final syncService = Provider.of<SyncService>(context, listen: false);
    await prefs.setSyncUrl(_urlController.text.trim());
    await prefs.setSyncPassword(_passwordController.text.trim());
    await prefs.setSyncEncryptionPassphrase(
        _encryptionPassphraseController.text.trim());
    await prefs.setSyncToken(null); // Force re-login

    try {
      await syncService.sync();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.syncSuccessful)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.syncFailed(e))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<PreferencesService>();
    final syncService = context.watch<SyncService>();
    final isSyncing = syncService.isSyncing;
    final l10n = context.l10n;
    final lastSyncStr = prefs.lastSyncTime == 0
        ? l10n.never
        : DateFormat.yMd()
            .add_Hms()
            .format(DateTime.fromMillisecondsSinceEpoch(prefs.lastSyncTime));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.syncTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(l10n.syncDescription),
          const SizedBox(height: 16),
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: l10n.syncServerUrl,
              hintText: 'https://mona-sync.example.com',
            ),
            keyboardType: TextInputType.url,
            enabled: !isSyncing,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: l10n.syncPassword,
              helperText: l10n.syncPasswordDescription,
            ),
            obscureText: true,
            enabled: !isSyncing,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _encryptionPassphraseController,
            decoration: InputDecoration(
              labelText: l10n.syncEncryptionPassphrase,
              helperText: l10n.syncEncryptionPassphraseDescription,
              helperMaxLines: 3,
            ),
            obscureText: true,
            enabled: !isSyncing,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(l10n.syncAllowInsecure),
            subtitle: Text(l10n.syncAllowInsecureDescription),
            value: prefs.allowInsecureSync,
            onChanged:
                isSyncing ? null : (value) => prefs.setAllowInsecureSync(value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: isSyncing ? null : _saveAndSync,
            child: isSyncing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.saveAndSync),
          ),
          const Divider(height: 48),
          ListTile(
            title: Text(l10n.lastSync),
            subtitle: Text(lastSyncStr),
          ),
          const SizedBox(height: 16),
          if (prefs.syncUrl != null || prefs.syncPassword != null)
            TextButton(
              onPressed: isSyncing
                  ? null
                  : () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.syncPurge),
                          content: Text(l10n.syncPurgeConfirm),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                              child: Text(l10n.delete),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        await prefs.clearSyncSettings();
                        _urlController.clear();
                        _passwordController.clear();
                        _encryptionPassphraseController.clear();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.syncPurged)),
                          );
                        }
                      }
                    },
              child: Text(
                l10n.syncPurge,
                style: TextStyle(
                  color: isSyncing
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
