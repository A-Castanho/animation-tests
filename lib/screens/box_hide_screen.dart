import 'package:flutter/material.dart';
import 'package:hooks_animations/animations/box_hide.dart';
import 'package:hooks_animations/services/image_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoxHideScreen extends ConsumerWidget {
  BoxHideScreen({super.key});
  final _heightProvider = StateProvider<double>(
    (ref) => 0.1,
  );
  final _durationProvider = StateProvider<double>(
    (ref) => 0.1,
  );
  final _pickerImageProvider = StateProvider<Image?>(
    (ref) => null,
  );
  final _hiderImageProvider = StateProvider<Image?>(
    (ref) => null,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hider = ref.watch(_hiderImageProvider.state).state;
    final picker = ref.watch(_pickerImageProvider.state).state;

    return Column(
      children: [
        Slider(
            label: 'Height',
            value: ref.watch(_heightProvider.state).state,
            max: 3.0,
            min: 0.1,
            onChanged: (value) {
              ref.read(_heightProvider.notifier).state = value;
            }),
        Slider(
            label: 'Duration',
            value: ref.watch(_durationProvider.state).state,
            max: 5.0,
            min: 0.1,
            onChanged: (value) {
              ref.read(_durationProvider.notifier).state = value;
            }),
        TextButton(
            onPressed: () async {
              final imageFile = await getImageFromGallery();
              ref.read(_pickerImageProvider.notifier).state =
                  imageFile != null ? Image.file(imageFile) : null;
            },
            child: const Text('Pick the picker')),
        TextButton(
            onPressed: () async {
              final imageFile = await getImageFromGallery();
              ref.read(_hiderImageProvider.notifier).state =
                  imageFile != null ? Image.file(imageFile) : null;
            },
            child: const Text('Pick the hider')),
        if (hider != null && picker != null)
          BoxHide(
            pickerImage: picker!,
            hiderImage: hider!,
            animationHeight: ref.read(_heightProvider.notifier).state,
            animationSeconds:
                ref.read(_durationProvider.notifier).state.round(),
          )
      ],
    );
  }
}
