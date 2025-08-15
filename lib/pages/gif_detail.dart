import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifDetail extends StatelessWidget {
  const GifDetail({super.key, required this.gif});

  final Map gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(gif["title"], style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(
                  text: 'Olha esse gif ${gif['images']['fixed_height']['url']}',
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          gif['images']['fixed_height']['url'],
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
