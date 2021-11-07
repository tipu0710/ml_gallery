import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenPhoto extends StatelessWidget {
  final String url;
  const FullScreenPhoto({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: InteractiveViewer(
        maxScale: 4,
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: url,
                child: CachedNetworkImage(imageUrl: url),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
