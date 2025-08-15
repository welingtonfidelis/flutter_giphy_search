import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class GifTable extends StatelessWidget {
  const GifTable({super.key, required this.gifs, required this.onLoadMore});

  final List<Map<String, dynamic>> gifs;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: gifs.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        if (index < gifs.length) {
          final gif = gifs[index];

          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              height: 300,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              image: gif['images']['fixed_height']['url'],
            ),
            onTap: () => GoRouter.of(context).push('/gif', extra: gif),
            onLongPress: () {
              SharePlus.instance.share(
                ShareParams(
                  text: 'Olha esse gif ${gif['images']['fixed_height']['url']}',
                ),
              );
            },
          );
        }

        return ElevatedButton(
          onPressed: onLoadMore,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text("Carregar outros GIFs"),
        );
      },
    );
  }
}
