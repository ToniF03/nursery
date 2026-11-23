import 'package:material_ui/material_ui.dart';
import 'package:nursery/l10n/app_localizations.dart';

// Shared feedback dialog for controls whose feature is not yet available.
class NotImplementedDialog extends StatelessWidget {
  const NotImplementedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.notImplementedYet),
      content: Text(AppLocalizations.of(context)!.notImplementedYetDescription),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
