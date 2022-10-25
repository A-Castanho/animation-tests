import 'package:flutter/material.dart';
import 'package:hooks_animations/animations/box_hide.dart';
import 'package:hooks_animations/services/image_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _minHeight = 100.1;
const _maxHeight = 500.1;

const _minDuration = 0.1;
const _maxDuration = 5.0;

class BoxHideScreen extends ConsumerWidget {
  BoxHideScreen({super.key});
  final heightProvider = StateProvider<double>(
    (ref) => _minHeight,
  );
  final durationProvider = StateProvider<double>(
    (ref) => _minDuration,
  );
  final pickerImageProvider = StateProvider<Image?>(
    (ref) => null,
  );
  final hiderImageProvider = StateProvider<Image?>(
    (ref) => null,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hider = ref.watch(hiderImageProvider.state).state;
    final picker = ref.watch(pickerImageProvider.state).state;

    return Column(
      children: [
        Slider(
            label: 'Height',
            value: ref.watch(heightProvider.state).state,
            max: _maxHeight,
            min: _minHeight,
            onChanged: (value) {
              ref.read(heightProvider.notifier).state = value;
            }),
        Text(ref.watch(heightProvider.state).state.toString()),
        Slider(
            label: 'Duration',
            value: ref.watch(durationProvider.state).state,
            max: _maxDuration,
            min: _minDuration,
            onChanged: (value) {
              ref.read(durationProvider.notifier).state = value;
            }),
        Text(ref.watch(durationProvider.state).state.toString()),
        TextButton(
            onPressed: () async {
              final imageFile = await getImageFromGallery();
              ref.read(pickerImageProvider.notifier).state =
                  imageFile != null ? Image.file(imageFile) : null;
            },
            child: const Text('Pick the picker')),
        TextButton(
            onPressed: () async {
              final imageFile = await getImageFromGallery();
              ref.read(hiderImageProvider.notifier).state =
                  imageFile != null ? Image.file(imageFile) : null;
            },
            child: const Text('Pick the hider')),
        if (hider != null && picker != null)
          Expanded(
            child: Center(
              child: BoxHide(
                pickerImage: picker!,
                hiderImage: hider!,
                animationHeight: ref.read(heightProvider.notifier).state,
                animationSeconds:
                    ref.read(durationProvider.notifier).state.round(),
              ),
            ),
          )
      ],
    );
  }
}
