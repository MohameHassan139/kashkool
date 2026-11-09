import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'notebook_import_screen.dart';
import 'old_installment_import_screen.dart';

/// App-bar button: "انقل من الكشكول" → choose customers & balances, or an old installment.
class NotebookImportButton extends StatelessWidget {
  final bool installmentsEnabled;
  const NotebookImportButton({super.key, this.installmentsEnabled = true});

  static Future<void> showChooser(BuildContext context, {bool installmentsEnabled = true}) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 4),
                child: Text('انقل حساباتك من الكشكول 📒', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Text(
                  'مش لازم تنقل كل حركة قديمة: كفاية اسم العميل واللي عليه دلوقتي.',
                  style: TextStyle(fontSize: 13, color: AppColors.neutralGrey),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.groups_rounded)),
                title: const Text('العملاء وحساباتهم', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('سطر لكل عميل: الاسم والموبايل والمبلغ اللي عليه'),
                onTap: () {
                  Navigator.pop(ctx);
                  NotebookImportScreen.open(context);
                },
              ),
              if (installmentsEnabled)
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.event_repeat_rounded)),
                  title: const Text('قسط قديم', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('السعر، واللي اتدفع، والأقساط الباقية وميعاد الجاي'),
                  onTap: () {
                    Navigator.pop(ctx);
                    OldInstallmentImportScreen.open(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'انقل من الكشكول',
      icon: const Icon(Icons.menu_book_rounded),
      onPressed: () => showChooser(context, installmentsEnabled: installmentsEnabled),
    );
  }
}
