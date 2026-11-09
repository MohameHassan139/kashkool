import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../data/customer_photo_repository.dart';
import 'widgets/photo_strip.dart';

/// All photos of one customer (notebook pages, contracts, receipts). Stored on this phone only.
class CustomerPhotosScreen extends ConsumerWidget {
  final String customerId;
  final String customerName;

  const CustomerPhotosScreen({super.key, required this.customerId, required this.customerName});

  static Future<void> open(BuildContext context, {required String customerId, required String customerName}) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => CustomerPhotosScreen(customerId: customerId, customerName: customerName),
    ));
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(customerPhotoRepositoryProvider);
    final paths = await pickCustomerPhotos(context, repo);
    if (paths.isEmpty) return;
    await repo.addPhotos(customerId, paths);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(paths.length == 1 ? 'الصورة اتضافت' : '${paths.length} صور اتضافوا')),
      );
    }
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, CustomerPhoto photo) async {
    final repo = ref.read(customerPhotoRepositoryProvider);
    await repo.moveToTrash(photo.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('الصورة اتشالت'),
      action: SnackBarAction(label: 'رجّعها', onPressed: () => repo.restore(photo.id)),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(customerPhotosProvider(customerId));
    return Scaffold(
      appBar: AppBar(title: Text('صور $customerName')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add_a_photo_rounded),
        label: const Text('ضيف صور'),
      ),
      body: photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('حصلت مشكلة في تحميل الصور')),
        data: (photos) {
          if (photos.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'مفيش صور للعميل ده لسه.\nصوّر صفحاته من الكشكول أو أي ورقة تخصه — الصور بتفضل على الموبايل بس.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.neutralGrey, height: 1.6),
                ),
              ),
            );
          }
          final paths = photos.map((p) => p.filePath).toList();
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 160,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.78,
            ),
            itemCount: photos.length,
            itemBuilder: (context, i) {
              final photo = photos[i];
              return _PhotoTile(
                photo: photo,
                onTap: () => PhotoViewerScreen.open(context, paths, initialIndex: i, title: customerName),
                onRemove: () => _remove(context, ref, photo),
              );
            },
          );
        },
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final CustomerPhoto photo;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  const _PhotoTile({required this.photo, required this.onTap, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.file(
                File(photo.filePath),
                fit: BoxFit.cover,
                cacheWidth: 400,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: Colors.black12,
                  child: Icon(Icons.broken_image_rounded, color: AppColors.neutralGrey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      photo.note ?? DateFormat('yyyy/MM/dd').format(photo.createdAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                    ),
                  ),
                  IconButton(
                    tooltip: 'شيل الصورة',
                    visualDensity: VisualDensity.compact,
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
