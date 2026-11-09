import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/customer_photo_repository.dart';
import '../../../../l10n/l10n.dart';

/// Asks "camera or gallery", then copies the chosen images into the app folder.
/// The gallery allows choosing several images at once. Returns the saved paths (may be empty).
Future<List<String>> pickCustomerPhotos(BuildContext context, CustomerPhotoRepository repo) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_rounded),
            title: Text(L10n.t.photoStrip1),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_rounded),
            title: Text(L10n.t.photoStrip2),
            subtitle: Text(L10n.t.photoStrip3),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (source == null) return const [];

  final picker = ImagePicker();
  final List<XFile> files;
  if (source == ImageSource.camera) {
    final one = await picker.pickImage(source: ImageSource.camera, imageQuality: 75, maxWidth: 2000);
    files = one == null ? const [] : [one];
  } else {
    files = await picker.pickMultiImage(imageQuality: 75, maxWidth: 2000);
  }

  final saved = <String>[];
  for (final f in files) {
    saved.add(await repo.persistFile(f.path));
  }
  return saved;
}

/// A row of thumbnails with an "add photo" tile. Tap a thumbnail to open it full screen,
/// tap its small × to remove it from the list.
class PhotoStrip extends StatelessWidget {
  final List<String> paths;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final double size;
  final String? addLabel;

  const PhotoStrip({
    super.key,
    required this.paths,
    required this.onAdd,
    required this.onRemove,
    this.size = 64,
    this.addLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 8,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 8),
        itemCount: paths.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == paths.length) {
            return _AddTile(size: size, label: paths.isEmpty ? (addLabel ?? L10n.t.photoStrip4) : L10n.t.photoStrip5, onTap: onAdd);
          }
          return _Thumb(
            path: paths[index],
            size: size,
            onTap: () => PhotoViewerScreen.open(context, paths, initialIndex: index),
            onRemove: () => onRemove(index),
          );
        },
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  final double size;
  final String label;
  final VoidCallback onTap;
  const _AddTile({required this.size, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Tooltip(
      message: L10n.t.photoStrip6,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.5)),
            color: color.withValues(alpha: 0.06),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_rounded, color: color, size: 22),
              const SizedBox(height: 2),
              Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String path;
  final double size;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  const _Thumb({required this.path, required this.size, required this.onTap, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  cacheWidth: (size * 3).round(),
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: Colors.black12,
                    child: Icon(Icons.broken_image_rounded, color: AppColors.neutralGrey),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: -6,
            end: -6,
            child: Material(
              color: Colors.black87,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onRemove,
                child: const Padding(
                  padding: EdgeInsets.all(3),
                  child: Icon(Icons.close_rounded, size: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen viewer: swipe between photos, pinch to zoom.
class PhotoViewerScreen extends StatefulWidget {
  final List<String> paths;
  final int initialIndex;
  final String? title;

  const PhotoViewerScreen({super.key, required this.paths, this.initialIndex = 0, this.title});

  static Future<void> open(BuildContext context, List<String> paths, {int initialIndex = 0, String? title}) {
    return Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => PhotoViewerScreen(paths: List.of(paths), initialIndex: initialIndex, title: title),
    ));
  }

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late final PageController _controller = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.paths.length;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(count > 1 ? L10n.t.photoStrip8(widget.title ?? L10n.t.photoStrip7, _index + 1, count) : (widget.title ?? L10n.t.photoStrip9)),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: count,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (_, i) => InteractiveViewer(
          maxScale: 6,
          child: Center(
            child: Image.file(
              File(widget.paths[i]),
              errorBuilder: (_, _, _) => Text(L10n.t.photoStrip10, style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
