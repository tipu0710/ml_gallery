import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/ui/photo_details/view/leading_icon.dart';
import 'package:ml_gallery/ui/ui_helper/loader.dart';

class FullScreenPhoto extends StatefulWidget {
  final String url;
  final bool relatedPhoto;
  const FullScreenPhoto(
      {Key? key, required this.url, this.relatedPhoto = false})
      : super(key: key);

  @override
  State<FullScreenPhoto> createState() => _FullScreenPhotoState();
}

class _FullScreenPhotoState extends State<FullScreenPhoto>
    with SingleTickerProviderStateMixin {
  TransformationController transformationController =
      TransformationController();
  late TapDownDetails _doubleTapDetails;

  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  @override
  void dispose() {
    if (widget.relatedPhoto) {
      CachedNetworkImage.evictFromCache(widget.url);
    }
    _animationController.dispose();
    transformationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        transformationController.value = _animation.value;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PhotoDetailsController photoDetailsController = PhotoDetailsController();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onDoubleTapDown: _handleDoubleTapDown,
                  onDoubleTap: _handleDoubleTap,
                  child: InteractiveViewer(
                    maxScale: 4,
                    transformationController: transformationController,
                    child: Hero(
                      tag: widget.url,
                      child: CachedNetworkImage(
                        imageUrl: widget.url,
                        placeholder: (_, __) => const Loader(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: LeadingWidget(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                      showNeumorphism: false,
                    ),
                  ),
                  if (widget.relatedPhoto)
                    Row(
                      children: [
                        Row(
                          children: [
                            LeadingWidget(
                                onTap: () {
                                  photoDetailsController.share(
                                      widget.url, context);
                                },
                                showNeumorphism: false,
                                icon: Icons.share),
                            const SizedBox(
                              width: 15,
                            ),
                            LeadingWidget(
                                onTap: () {
                                  photoDetailsController.savePhoto(
                                      context, widget.url);
                                },
                                showNeumorphism: false,
                                icon: Icons.download),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    if (transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a x zoom
      // translate(-position.dx * (x-1), -position.dy * (x-1))
      _endMatrix = Matrix4.identity()
        ..translate(-position.dx * 3, -position.dy * 3)
        ..scale(4.0);
    }
    _animation = Matrix4Tween(
      begin: transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }
}
